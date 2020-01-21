FROM node:12.14-alpine

ENV NODE_ENV development

ENV PATH /usr/app/node_modules/.bin:$PATH

WORKDIR /usr/app

COPY package.json /usr/app/package.json
RUN npm install

COPY . /usr/app

EXPOSE 8080

CMD ["npm", "run", "serve"]
