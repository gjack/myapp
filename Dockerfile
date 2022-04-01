FROM ruby:2.7

LABEL maintainer="gabi@gabijack.com"

# Allow apt to work with http-based resources
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
apt-transport-https

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
netcat \
nodejs \
yarn \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* /usr/src/app/

ENV BUNDLE_PATH /gems
RUN bundle install

COPY . /usr/src/app/

RUN ["chmod", "+x", "/usr/src/app/wait-for"]

RUN bin/rails assets:precompile

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]