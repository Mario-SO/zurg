import { bindings } from "./ffi";

type ListenResult = { port: number };

function startServer(): number {
  const port = bindings.symbols.start_server();
  if (port <= 0) {
    throw new Error("failed to start echo server from Zig");
  }
  return port;
}

export function App() {
  let currentPort: number | null = null;

  return {
    async listen(): Promise<ListenResult> {
      if (currentPort !== null) return { port: currentPort };
      const port = startServer();
      currentPort = port;
      return { port };
    },

    port(): number | null {
      return currentPort;
    },
  };
}
