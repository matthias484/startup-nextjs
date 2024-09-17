# Use the official Node.js image.
FROM node:20-alpine

# Set the working directory.
WORKDIR /app

# Install dependencies.
COPY package*.json ./
RUN npm install

# Copy the rest of the application code.
COPY . .

# Build the app.
RUN npm run build

# Expose the port the app runs on.
EXPOSE 3000

# Command to run the app.
CMD ["npm", "start"]