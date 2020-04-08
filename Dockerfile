FROM ruby:2.7-alpine

ENV APP_HOME /devhub_app
ENV BUNDLE_PATH ${APP_HOME}/.gems_devhub

RUN apk update && apk upgrade && apk --no-cache add build-base nodejs postgresql-dev git tzdata && rm -rf /var/cache/apk/*

ENV PATH=/root/.yarn/bin:$PATH
RUN apk add --virtual build-yarn curl && touch ~/.bashrc && \
  curl -o- -L https://yarnpkg.com/install.sh | sh && apk del build-yarn

RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}

COPY Gemfile* ${APP_HOME}/
RUN bundle install --jobs=10 --path=${BUNDLE_PATH} --clean

ADD . ${APP_HOME}