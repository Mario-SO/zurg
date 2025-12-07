const zurg = @import("lib/zzurg.zig");

/// Public entrypoint that forwards to the implementation in lib/.
/// Exported with C calling convention so bun:ffi can load it from the dyzurg.
pub export fn start_server() callconv(.c) i32 {
    return zurg.Server.start();
}
