#FROM node:10-alpine

#RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

#WORKDIR /home/node/app

#COPY package*.json ./

#USER node

#RUN npm install

#COPY --chown=node:node . .

#EXPOSE 8080

#CMD [ "node", "app.js" ]


FROM node:14


RUN apt-get update && apt-get install -y \
	git 

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

RUN cd /home/node/app && git clone https://rockgger@bitbucket.org/rockgger/webservice.git

WORKDIR /home/node/app/webservice

RUN npm install
RUN node ace build --production
RUN cp .env.example build/.env

WORKDIR /home/node/app/webservice/build
RUN npm ci --production

EXPOSE 8080

CMD ["node", "server.js"]