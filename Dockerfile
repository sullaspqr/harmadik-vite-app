FROM oven/bun:latest
WORKDIR /app
COPY . .
RUN bun install
RUN bun vite build
EXPOSE 3000
CMD ["bun", "x", "serve", "-s", "dist", "-l", "3000"]

