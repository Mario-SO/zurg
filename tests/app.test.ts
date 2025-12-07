import { test, expect } from "bun:test";
import { App } from "../src/app";

// Facade-level check: listen returns a port and caches it across calls.
test("App.listen returns port and is idempotent", async () => {
	const app = App();
	try {
		const first = await app.listen();
		expect(typeof first.port).toBe("number");
		const second = await app.listen();
		expect(second.port).toBe(first.port);
	} catch (err) {
		throw err;
	}
});
