FROM node:18 AS backend-builder
RUN apt-get update && apt-get install -y iproute2
WORKDIR /app/backend
COPY app/backend ./
RUN npm install
EXPOSE 3000
CMD bash net_monitor.sh & node server.js