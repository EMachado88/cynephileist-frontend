FROM node:16
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./ /usr/src/app/
RUN export NODE_OPTIONS=--openssl-legacy-provider
RUN yarn && yarn cache clean && yarn build
ENV NUXT_HOST 0.0.0.0
ENV NUXT_PORT 80
ENV TMDB_API_KEY 231e814ed17a796649656af07ad112cb
EXPOSE 80
CMD [ "yarn", "start" ]
