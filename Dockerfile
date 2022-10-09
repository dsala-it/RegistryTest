FROM node
WORKDIR /usr/src/app
COPY package*.json ./
COPY .npmrc ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]