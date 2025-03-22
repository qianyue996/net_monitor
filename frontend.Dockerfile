FROM node:18 AS frontend-builder
WORKDIR /app/frontend
COPY app/frontend ./
RUN npm install && npm run build

FROM nginx:alpine
WORKDIR /app
COPY --from=frontend-builder /app/frontend/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
ENV PORT=80
EXPOSE $PORT
CMD ["nginx", "-g", "daemon off;"]