# Build step /app/build has all the files we want to copy over to run phase 
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine

EXPOSE 80

# file path share/nginx from https://hub.docker.com/_/nginx
COPY --from=builder /app/build /usr/share/nginx/html

