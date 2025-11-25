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

COPY --from=build /app/dist ./dist

EXPOSE 3000
ENV PORT=3000

# Serve the built app
CMD ["bun", "--serve", "dist", "--port", "3000"]
