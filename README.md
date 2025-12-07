# zurg

An echo server built in Zig with a Bun TypeScript facade.

## Install

```bash
bun install
```

## Run

```bash
bun run start
```

The `start` script builds the Zig dynamic library (`zzurg/`) and then runs `src/index.ts`. If you have already built the library yourself (`cd zzurg && zig build`), you can also launch the entrypoint directly with `bun run src/index.ts`.

## Test

```bash
bun test
```
