import { serve } from "bun";

serve({
  port: process.env.PORT ?? 3000,
  hostname: "0.0.0.0",
  async fetch(req) {
    return new Response(Bun.file("dist" + new URL(req.url).pathname));
  }
});
