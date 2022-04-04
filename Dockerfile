FROM alpine

RUN apk update && \
      apk upgrade && \
      apk add ruby ruby-io-console ruby-bundler && \
      rm -rf /var/cache/apk/*
RUN gem install --no-document bundler

ENV APP_PATH /app/
RUN mkdir $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile* $APP_PATH
RUN bundle install
COPY . $APP_PATH
CMD "rake"