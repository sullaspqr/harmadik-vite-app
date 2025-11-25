# Build
FROM oven/bun:latest AS build
WORKDIR /app

COPY package.json bun.lockb* ./
RUN bun install

COPY . .
RUN bun vite build

# Run
FROM oven/bun:latest
WORKDIR /app

COPY --from=build /app/dist ./dist

ENV PORT=3000
EXPOSE 3000

CMD ["bun", "x", "serve", "-s", "dist", "--listen", "http://0.0.0.0:$PORT"]


