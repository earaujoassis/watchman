FROM ruby:2.6.3-alpine3.10

LABEL "com.quatrolabs.watchman"="quatroLABS Watchman"
LABEL "description"="Watchman helps keep track of GitHub projects; a tiny continuous deployment service"

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

RUN bundle install --verbose
RUN yarn install --network-timeout 1000000 --verbose
RUN yarn build
RUN bundle exec hanami assets precompile

EXPOSE 3000

ENTRYPOINT [ "rake" ]
CMD [ "foreman_web" ]
