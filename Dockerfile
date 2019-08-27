FROM ruby:2.5.1-alpine

ENV APP_ROOT /usr/src/app

RUN mkdir -p $APP_ROOT

WORKDIR $APP_ROOT
EXPOSE 3000

ENV BASE_PACKAGES="git" \
    BUILD_PACKAGES="bash curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs" \
    # linux-headers: raindrops
    GEM_PACKAGES="linux-headers"

RUN apk update && \
    apk upgrade && \
    apk add --update --virtual build-dependencies \
    imagemagick \
    $BASE_PACKAGES \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES \
    $PYTHON_PACKAGES \
    $GEM_PACKAGES && \
    rm -rf /var/cache/apk/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN bundle config build.nokogiri --use-system-libraries && \
    QMAKE=/usr/lib/qt5/bin/qmake bundle install && \
    bundle clean

COPY . $APP_ROOT
