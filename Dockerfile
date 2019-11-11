FROM ruby:2.6.5-alpine

WORKDIR /mewblr

RUN apk add git
RUN apk add --update bash perl
RUN apk add libxslt-dev libxml2-dev build-base
RUN apk add mysql-client mysql-dev
RUN apk add --no-cache file
RUN apk add yarn --no-cache
RUN apk add tzdata
RUN apk --update add imagemagick

COPY . /mewblr

RUN bundle install
RUN yarn install

RUN mkdir -p /mewblr/tmp/sockets

RUN mkdir -p /tmp/public && \
    cp -rf /mewblr/public/* /tmp/public