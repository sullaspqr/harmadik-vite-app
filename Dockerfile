# ---- Build stage ----
FROM oven/bun:1 AS build
WORKDIR /app

COPY package.json bun.lockb ./
RUN bun install

COPY . .
RUN bun run build   # Vite → dist/

# ---- Run stage ----
FROM oven/bun:1
WORKDIR /app

# dist bemásolása
COPY --from=build /app/dist ./dist

# Bun static server – NINCS Node, NINCS serve, NINCS server.js
EXPOSE 3000
ENV PORT=3000

CMD ["bun", "run", "start"]


