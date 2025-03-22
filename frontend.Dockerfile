FROM node:18 AS frontend-builder
WORKDIR /app/frontend
COPY app/frontend ./
RUN npm install && npm run build

FROM nginx:alpine
WORKDIR /app
COPY --from=frontend-builder /app/frontend/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]