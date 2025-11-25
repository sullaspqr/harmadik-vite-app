# ---- Run stage ----
FROM oven/bun:1
WORKDIR /app

COPY --from=build /app/dist ./dist

EXPOSE 3000
ENV PORT=3000

# Bun built-in static server
CMD ["bun", "--serve", "dist", "--port", "3000"]

