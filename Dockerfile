FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci --no-audit --no-fund

COPY public ./public
COPY src ./src
RUN npm run build

FROM nginxinc/nginx-unprivileged:stable-alpine

USER root
RUN apk update && apk del nginx-module-geoip nginx-module-image-filter nginx-module-njs nginx-module-xslt && apk add --no-cache nginx=1.30.7-r0 && apk upgrade --no-cache

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

USER 101

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
