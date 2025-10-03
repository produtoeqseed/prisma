FROM node:20-bookworm
WORKDIR /app
COPY . .
RUN apt-get update -y && apt-get install -y --no-install-recommends openssl ca-certificates && update-ca-certificates
ENV PORT=3000
CMD ["node", "-e", "require('http').createServer((_,res)=>res.end('ok')).listen(process.env.PORT||3000)"]
