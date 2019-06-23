FROM ruby:2.6.3-alpine
RUN apk update && apk add alpine-sdk
RUN apk add sqlite-dev nodejs
WORKDIR /app
RUN gem install bundler
ADD ./ ./
RUN bundle install
CMD APP_ENV=production bundle exec ruby server.rb
