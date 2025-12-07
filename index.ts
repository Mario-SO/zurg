import { dlopen, FFIType } from "bun:ffi";
import { join } from "path";

const libPath = join(import.meta.dir, "zzurg", "zig-out", "lib", "libzzurg.dylib");

const zurg = dlopen(libPath, {
	start_server: {
		args: [],
		returns: FFIType.i32,
	},
} as const);

const port = zurg.symbols.start_server();

if (port <= 0) {
	throw new Error("failed to start echo server from Zig");
}

console.log(`echo server listening on 127.0.0.1:${port}`);
console.log(`try: echo "hello zig" | nc 127.0.0.1 ${port}`);

await new Promise(() => { });
