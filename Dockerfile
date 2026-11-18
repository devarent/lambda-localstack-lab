# Dockerfile untuk menjalankan AWS Lambda secara lokal tanpa akun AWS
# Menggunakan Node.js official image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json ./

# Copy source files
COPY index.mjs index.html local_server.mjs ./

# Expose port
EXPOSE 9000

# Run the local server dengan stdin support untuk command "confirm"
CMD ["sh", "-c", "node local_server.mjs"]
