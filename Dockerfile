FROM oven/bun:1
WORKDIR /app

# Copy package files
COPY package.json bun.lockb* ./

# Install dependencies
RUN bun install

# Copy source code
COPY . .

# Build the app
RUN bun run build

EXPOSE 3000
ENV PORT=3000

# Serve the built app
CMD ["bun", "--serve", "dist", "--port", "3000"]

