# Build stage
FROM oven/bun:latest AS build
WORKDIR /app

COPY package.json bun.lockb* ./
RUN bun install

COPY . .
RUN bun vite build

# Run stage
FROM oven/bun:latest
WORKDIR /app

# A dist fájlok átmásolása
COPY --from=build /app/dist ./dist

# Render PORT
ENV PORT=3000

EXPOSE 3000

# Serve 0.0.0.0-on és $PORT-on
CMD ["bun", "x", "serve", "-s", "dist", "-l", "0.0.0.0:$PORT"]


