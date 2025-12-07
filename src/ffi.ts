import { dlopen, FFIType } from "bun:ffi";
import { join } from "path";

const libPath = join(import.meta.dir, "..", "zzurg", "zig-out", "lib", "libzzurg.dylib");

export const bindings = dlopen(libPath, {
  start_server: {
    args: [],
    returns: FFIType.i32,
  },
} as const);
