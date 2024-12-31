FROM node:20 as build
WORKDIR /app
COPY package.json package-lock.json ./
COPY .npmrc ./
RUN npm install -g npm@latest && npm install 
RUN npm cache clean --force --no-cache --legacy-peer-deps
COPY . .
RUN npm run build
FROM node:20 as runner
WORKDIR /app
COPY --from=build /app/package.json .
COPY --from=build /app/package-lock.json .
COPY --from=build /app/next.config.js ./
COPY --from=build /app/public ./public
COPY --from=build /app/.next ./.next
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/.env ./
EXPOSE 5000
CMD ["npm", "start"]
