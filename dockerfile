FROM nginx:alpine

# Clean default nginx html
RUN rm -rf /usr/share/nginx/html/*

# Copy prebuilt frontend files from your repo (dist/)
COPY dist /usr/share/nginx/html

# Expose default web port
EXPOSE 80


# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
