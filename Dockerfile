# Stage 1: Build React/Vite application
FROM node:24 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build production files
RUN npm run build


# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy Vite production build to Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Nginx listens on port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]