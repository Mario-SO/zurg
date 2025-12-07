import { App } from "./app";

async function main() {
  const app = App();
  const { port } = await app.listen();
  console.log(`echo server listening on 127.0.0.1:${port}`);
  console.log(`try: echo "hello zig" | nc 127.0.0.1 ${port}`);
  await new Promise(() => {});
}

if (import.meta.main) {
  main().catch((err) => {
    console.error(err);
    process.exit(1);
  });
}
