# Use Node.js base image
FROM node:alpine

# Set working directory
WORKDIR /app

# Copy app dependencies
COPY package*.json ./
RUN npm install

# Copy app files
COPY . .

# Expose 3000
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
