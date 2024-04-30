# Use NGINX as the base image
FROM nginx

# Set working directory within the NGINX HTML directory
WORKDIR /usr/share/nginx/html

# Copy the HTML and CSS files into the container's HTML directory
COPY index.html .
COPY styles.css .

# Expose port 80 for NGINX
EXPOSE 80


# # Use the official Nginx image as the base image
# FROM nginx:alpine

# # Copy the HTML and CSS files into the Nginx default HTML directory
# COPY index.html /usr/share/nginx/html/
# COPY styles.css /usr/share/nginx/html/

# # Expose port 80 to allow external access
# EXPOSE 80
