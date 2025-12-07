const lib = @import("lib/zzurg.zig");

/// Public entrypoint that forwards to the implementation in lib/.
/// Exported with C calling convention so bun:ffi can load it from the dylib.
pub export fn add(a: i32, b: i32) callconv(.c) i32 {
    return lib.add(a, b);
}
