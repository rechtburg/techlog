FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
# ARG NODE_VERSION=${NODE_VERSION:-10.15.3}
# RUN curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" \
#     && tar -xJf "node-v${NODE_VERSION}-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
#     && rm "node-v${NODE_VERSION}-linux-x64.tar.xz" \
#     && ln -s /usr/local/bin/node /usr/local/bin/nodejs
# RUN npm install -g npm@6.14.0
# RUN npm install -g yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# RUN bundle install

COPY . /app

# Add a script to be executed every time the container starts.
COPY ./dev-dockerize/start_rails.sh /usr/bin/
RUN chmod +x /usr/bin/start_rails.sh
ENTRYPOINT ["start_rails.sh"]
EXPOSE 4000

# Start the main process.
CMD ["bash"]
