# Dockerfile (na raiz ou na subpasta definida como Root Directory)
FROM node:20-bookworm
WORKDIR /app
RUN apt-get update -y && apt-get install -y --no-install-recommends openssl ca-certificates && update-ca-certificates
COPY . .
ENV PORT=3000
# Ajuste PRISMA_SCHEMA via ENV no Dokploy se estiver em outro caminho
CMD ["bash","-lc","npx prisma studio --port ${PORT} --hostname 0.0.0.0 --schema ${PRISMA_SCHEMA:-prisma/schema.prisma}"]
