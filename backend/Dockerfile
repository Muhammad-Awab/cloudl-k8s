# Stage 1: Builder
FROM node:10 as build

WORKDIR /app

# Copy only required files
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Copy necessary app source filesssssss
COPY server.js ./
COPY models ./models
COPY routes ./routes
COPY utils ./utils

# Stage 2: Final runtime image
FROM node:10-alpine

WORKDIR /app

COPY --from=build /app /app

EXPOSE 5000
CMD ["npm", "start"]
