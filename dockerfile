# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install 'serve' globally to serve static files
RUN npm install -g serve

# Copy built frontend files from dist/
COPY dist/ .

# Expose port 3000
EXPOSE 3000

# Run the app with serve on port 3000
CMD ["serve", "-s", ".", "-l", "3000"]
