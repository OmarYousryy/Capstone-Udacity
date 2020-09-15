FROM nginx:alpine

# Create a working directory
WORKDIR /app

# Copy source code to working directory
COPY . index.html /app/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]