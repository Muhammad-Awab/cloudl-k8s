# Stage 1: Build
FROM node:10 as build

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

# Stage 2: Production
FROM node:10-alpine

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Expose the port your app runs on
EXPOSE 5000

CMD ["npm", "start"]
