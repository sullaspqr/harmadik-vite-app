# ---- Build stage ----
FROM oven/bun:1 AS build
WORKDIR /app

COPY package.json bun.lockb* ./
RUN bun install

COPY . .
RUN bun run build   # Vite → dist/

# ---- Run stage ----
FROM oven/bun:1
WORKDIR /app

COPY package.json bun.lockb* ./
COPY --from=build /app/dist ./dist

ENV PORT=3000 

CMD ["bun", "run", "start"] 
