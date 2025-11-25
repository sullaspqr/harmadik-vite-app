import { serveStatic } from "bun";

export default {
  port: process.env.PORT || 3000,
  fetch(req) {
    return serveStatic("dist", { req });
  },
};
