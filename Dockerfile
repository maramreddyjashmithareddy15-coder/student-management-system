# Step 1: Build React Frontend
FROM node:20-alpine AS build-frontend
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

# Step 2: Production Server
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080

# Install backend dependencies
COPY backend/package*.json ./backend/
WORKDIR /app/backend
RUN npm ci --only=production

# Copy backend source & built frontend
WORKDIR /app
COPY backend ./backend
COPY --from=build-frontend /app/frontend/dist ./frontend/dist

WORKDIR /app/backend
EXPOSE 8080

CMD ["node", "src/server.js"]
