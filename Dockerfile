# Use an official nginx runtime as a base image
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Copy only necessary files
COPY index.html .
COPY script.js .
COPY style.css .

# Expose port 80 to the outside world
EXPOSE 80

# Command to run the application when the container starts
CMD ["nginx", "-g", "daemon off;"]
