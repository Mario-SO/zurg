const std = @import("std");
const net = std.net;
const print = std.debug.print;

pub const Server = struct {
    const host: []const u8 = "127.0.0.1";
    const any_port: u16 = 0;
    const max_connections: u32 = 8;
    const max_messages: u32 = 64;

    pub fn start() i32 {
        const address = net.Address.parseIp4(host, any_port) catch |err| {
            print("failed to parse address: {s}\n", .{@errorName(err)});
            return -1;
        };
        var listener = address.listen(.{ .reuse_address = true }) catch |err| {
            print("failed to start echo server: {s}\n", .{@errorName(err)});
            return -1;
        };
        errdefer listener.deinit();

        const chosen_port = listener.listen_address.getPort();
        const worker = std.Thread.spawn(.{}, acceptLoop, .{listener}) catch |err| {
            print("failed to start worker: {s}\n", .{@errorName(err)});
            return -1;
        };
        worker.detach();
        return @as(i32, @intCast(chosen_port));
    }

    fn acceptLoop(listener: net.Server) void {
        var srv = listener;
        defer srv.deinit();

        var handled: u32 = 0;
        while (handled < max_connections) {
            const client = srv.accept() catch |err| {
                print("accept error: {s}\n", .{@errorName(err)});
                return;
            };

            handled += 1;
            handleClient(client) catch |err| {
                print("client error: {s}\n", .{@errorName(err)});
            };
        }
    }

    fn handleClient(client: net.Server.Connection) !void {
        print("Accepted connection from {f}\n", .{client.address});
        defer client.stream.close();

        var stream_buf: [1024]u8 = undefined;
        var reader = client.stream.reader(&stream_buf);
        var writer = client.stream.writer(&.{});

        var seen: u32 = 0;
        while (seen < max_messages) {
            print("Waiting for data from {f}...\n", .{client.address});
            const msg = reader.interface().takeDelimiterInclusive('\n') catch |err| {
                if (err == error.EndOfStream) {
                    print("{f} closed the connection\n", .{client.address});
                    return;
                }

                return err;
            };

            seen += 1;
            print("{f} says {s}", .{ client.address, msg });
            try writer.interface.writeAll(msg);
        }
    }
};
