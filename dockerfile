# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency definitions
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app code
COPY . .

# Expose port 3000
EXPOSE 3000

# Run the app
CMD ["npm", "start"]
