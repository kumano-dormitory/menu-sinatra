FROM ruby:2.6.3-alpine
RUN gem install bundler
RUN apk update && apk add alpine-sdk
RUN apk add sqlite-dev nodejs
WORKDIR /app
ADD Gemfile .
RUN bundle install
CMD APP_ENV=production bundle exec ruby server.rb
