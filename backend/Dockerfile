# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

ARG NODE_VERSION=22.1.0

################################################################################
# STAGE 1: Build
FROM node:22.1.0-alpine AS build
# Use the node image for the build stage
# Use the slim version to reduce image size

WORKDIR /build
# Set the working directory to /build
# This is where the application code will be copied to

COPY  package.json package-lock.json tsconfig.json ./
# Copy package.json and package-lock.json to the working directory
# This is important for installing dependencies
# The package-lock.json file is used to install the exact versions of dependencies
# This is important for reproducible build

COPY src/ /build/src/
# Copy the application src code to the working directory
# This is important for the build process

RUN npm ci
# Clean install all dependencies
# This will install all dependencies listed in package.json

RUN npm run build
# Build the application
# This will create a dist directory with the compiled code
# This is important for the runtime stage

##############################################################################
# STAGE 2: Runtime
##############################################################################
FROM node:22.1.0-alpine AS runtime

WORKDIR /backend

COPY --from=build /build/dist ./dist
# Copy the dist directory from the builder stage to the runtime stage
# This is where the compiled code is located
# This is important for the runtime stage

COPY --from=build /build/package.json ./

RUN npm install --omit=dev
# Install only the production dependencies
# This will install only the dependencies listed in package.json
# This is important for the runtime stage

CMD ["node", "dist/server.js"]
# Start the application
# This will start the application using the compiled code
# This is important for the runtime stage
# This is the command that will be run when the container is started

