FROM ruby:2.7.2-alpine3.11

LABEL "com.quatrolabs.watchman"="quatroLABS Watchman"
LABEL "description"="Watchman helps to keep track of automating services; a tiny continuous deployment service"

RUN apk add --update --no-cache \
    binutils-gold \
    curl \
    g++ \
    gcc \
    gnupg \
    libgcc \
    linux-headers \
    make \
    python \
    postgresql \
    postgresql-contrib \
    postgresql-libs \
    postgresql-dev

RUN apk add --update --no-cache nodejs
RUN apk add --update --no-cache yarn

ENV PATH=/usr/local/bin:$PATH

ENV HANAMI_ENV=production
ENV HANAMI_HOST=0.0.0.0
ENV SERVE_STATIC_ASSETS=true
ENV NODE_ENV=production

RUN mkdir -p /app
WORKDIR /app
COPY . /app

RUN gem update --system
RUN gem install bundler:2.2.19
RUN bundle install --verbose --jobs=5 --retry=5

ARG COMMIT_HASH_ARG
ENV COMMIT_HASH=${COMMIT_HASH_ARG}

RUN yarn install --network-timeout 1000000 --verbose
RUN yarn build
RUN bundle exec hanami assets precompile

EXPOSE 3000

ENTRYPOINT [ "rake" ]
CMD [ "foreman:web" ]
