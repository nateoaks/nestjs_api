FROM node:16-alpine as builder
WORKDIR /app
COPY package.json package-lock.json /app
RUN npm install
COPY ./src ./src
COPY tsconfig.build.json tsconfig.json  /app
EXPOSE 3000
RUN npm run build

FROM node:16-alpine as production
WORKDIR /app
COPY package.json package-lock.json /app
RUN npm install
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD npm run start:prod
