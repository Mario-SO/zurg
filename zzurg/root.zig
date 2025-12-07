const zurg = @import("lib/zzurg.zig");

/// Public entrypoint that forwards to the implementation in lib/.
/// Exported with C calling convention so bun:ffi can load it from the dyzurg.
pub export fn add(a: i32, b: i32) callconv(.c) i32 {
    return zurg.add(a, b);
}

pub export fn substract(a: i32, b: i32) callconv(.c) i32 {
    return zurg.substract(a, b);
}
