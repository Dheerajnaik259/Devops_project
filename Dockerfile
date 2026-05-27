# ---- Build Stage ----
FROM node:20-alpine AS builder

WORKDIR /app

COPY app/package*.json ./
RUN npm ci --only=production

# ---- Production Stage ----
FROM node:20-alpine

WORKDIR /app

# Copy only production dependencies and app code
COPY --from=builder /app/node_modules ./node_modules
COPY app/index.js .

# Cloud Run uses PORT env variable
ENV PORT=8080
EXPOSE 8080

# Run as non-root user (security best practice)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD ["node", "index.js"]
