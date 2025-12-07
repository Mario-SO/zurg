import { dlopen, FFIType } from "bun:ffi";
import { join } from "path";

const libPath = join(import.meta.dir, "zzurg", "zig-out", "lib", "libzzurg.dylib");

const zurg = dlopen(libPath, {
	add: {
		args: [FFIType.i32, FFIType.i32],
		returns: FFIType.i32,
	},
	substract: {
		args: [FFIType.i32, FFIType.i32],
		returns: FFIType.i32,
	},
} as const);

const add = zurg.symbols.add(2, 3);
const substract = zurg.symbols.substract(2, 3);

console.log(`add(2, 3) = ${add}`);
console.log(`add(2, 3) = ${substract}`);
