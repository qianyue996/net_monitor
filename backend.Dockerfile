FROM node:18-alpine
WORKDIR /app/backend
COPY app/backend ./
RUN npm install && apk add --no-cache iproute2
ENV PORT=3000
EXPOSE $PORT
CMD sh net_monitor.sh & node server.js