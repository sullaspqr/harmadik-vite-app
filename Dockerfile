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

# Kimásoljuk a buildelt fájlokat (dist) és a csomagfájlokat (a függőségekhez, amik a bun:1 image-ben vannak)
COPY package.json bun.lockb* ./
COPY --from=build /app/dist ./dist

# EXPOSE 3000 # Ezt elhagyhatjuk, a Render.com a PORT változót használja
ENV PORT=3000 # Ezt a Render felülírja, de jó ha van egy alapértelmezett

# A "start" script futtatása a package.json-ból, ami a $PORT változót használja:
# "start": "bun --serve dist --port $PORT"
CMD ["bun", "run", "start"] 
# VAGY
# A Bun statikus kiszolgáló futtatása, hivatkozva a $PORT környezeti változóra:
# CMD ["bun", "--serve", "dist", "--port", "$PORT"]
# DE a fenti (CMD ["bun", "run", "start"]) a legtisztább, ha a package.json-ban van definiálva.
