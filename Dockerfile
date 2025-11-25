FROM oven/bun:1

WORKDIR /app

# Copy package files first for better caching
COPY package.json bun.lockb* ./
RUN bun install

# Copy source code and build
COPY . .
RUN bun run build

EXPOSE 3000
ENV PORT=3000

# Change to the dist directory and serve from there
WORKDIR /app/dist
CMD ["bun", "--serve", ".", "--port", "3000"]
