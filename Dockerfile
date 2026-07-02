FROM mirror.gcr.io/library/node:22-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install --frozen-lockfile
RUN cd packages/deps && NODE_OPTIONS="--max-old-space-size=4096" yarn build

FROM mirror.gcr.io/library/nginx:alpine
COPY --from=builder /app/packages/deps/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
