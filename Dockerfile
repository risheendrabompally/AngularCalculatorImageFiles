# Select base image
FROM node:14-alpine as build

# Configure app path
WORKDIR /app

# Copy package file
COPY package.json .

# Setup dependencies 
RUN npm install

# Copy the app code
# COPY . /app
COPY . .

#Install ng
RUN npm install -g @angular/cli

# Build the code
RUN ng build

#Multi stage build
FROM httpd:2.4.48-alpine
COPY --from=build /app/dist/angularCalc /usr/local/apache2/htdocs
