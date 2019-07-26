FROM ruby:2.5.1-alpine

ENV APP_ROOT /usr/src/app

RUN mkdir -p $APP_ROOT

WORKDIR $APP_ROOT
EXPOSE 3000

ENV BASE_PACKAGES="git" \
    BUILD_PACKAGES="bash curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs" \
    PYTHON_PACKAGES="python3 python3-dev" \
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

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN pip3 install cleo==0.6.8
RUN pip3 install framgia-ci==0.2.1

RUN gem install brakeman bundle-audit

RUN npm install --global eslint

COPY . $APP_ROOT
