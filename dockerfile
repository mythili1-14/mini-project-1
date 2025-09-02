# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency definitions
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the app code
COPY . .

# Build React app (outputs to 'dist')
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Run the app
CMD ["npm", "start"]
