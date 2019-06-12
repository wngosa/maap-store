FROM ruby:2.5.3

RUN \
  apt-get update && \
  curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs build-essential libpq-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

RUN gem install bundler

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN bundle install

ADD . /app

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

EXPOSE $PORT

CMD bundle exec rails s -p 3000 -b '0.0.0.0'
