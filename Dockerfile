# Step 1: Build the application
FROM node:20 AS build-stage

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the Vue.js application
RUN npm run build

# Step 2: Serve the application
FROM nginx:alpine AS production-stage

# Copy the build files from the build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copy custom Nginx configuration file if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port Nginx is running on
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
