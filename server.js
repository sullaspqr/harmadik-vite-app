import { serve } from "bun";
import path from "path";
import fs from "fs";

serve({
  port: process.env.PORT ?? 3000,
  hostname: "0.0.0.0",
  async fetch(req) {
    try {
      let urlPath = new URL(req.url).pathname;
      if (urlPath === "/") urlPath = "/index.html"; // alapértelmezett
      const filePath = path.join("dist", urlPath);
      return new Response(await Bun.file(filePath));
    } catch {
      return new Response("Not found", { status: 404 });
    }
  },
});
