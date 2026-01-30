# NestJS backend — multi-stage build
# Required env at runtime: DATABASE_URL, JWT_SECRET. Optional: PORT (default 3000), FRONTEND_ORIGIN, SKIP_MIGRATE=1

# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies (including devDependencies for build)
COPY package.json package-lock.json ./
RUN npm ci

# Prisma: generate client (no DB connection needed)
COPY prisma ./prisma
RUN npx prisma generate

# Build NestJS
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Copy package files, prisma (for migrate at runtime), and built app
COPY package.json package-lock.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/dist ./dist

# Optional: run migrations on startup (set SKIP_MIGRATE=1 to skip)
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 4000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["node", "dist/main.js"]
