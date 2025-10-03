# Etapa de build
FROM node:20-bookworm AS build
WORKDIR /app
RUN apt-get update -y && apt-get install -y --no-install-recommends openssl ca-certificates
COPY package*.json ./
RUN npm ci
COPY . .
# Se for monorepo, rode a build do pacote desejado aqui
# ex: npm run build --workspace=@meuorg/minha-app
RUN npx prisma generate || true

# Etapa final (runtime)
FROM node:20-bookworm
WORKDIR /app
RUN apt-get update -y && apt-get install -y --no-install-recommends openssl ca-certificates && update-ca-certificates
ENV NODE_ENV=production
COPY --from=build /app /app
EXPOSE 3000
# Ajuste para seu entrypoint real
CMD ["sh", "-lc", "PORT=${PORT:-3000} npm start"]
