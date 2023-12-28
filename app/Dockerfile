# Base Image
FROM node:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy Source Code
COPY . /usr/src/app
RUN npm ci

# Expose a port
EXPOSE 3000

# Start The Backend App
CMD ["node", "nodeapp.js"]
