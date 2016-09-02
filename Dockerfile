FROM node:6.5
MAINTAINER Synctree Appforce

RUN apt-get update \
  && apt-get install -y supervisor \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create base app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# build node dependancies
ADD package.json /usr/src/app/
RUN npm install \
  && npm cache clean

# Add application code to image
ADD . /usr/src/app

# Expose default Web port
EXPOSE 3000

ADD docker/usr/bin/*.sh /usr/bin/
ADD docker/etc/supervisor/conf.d/*.conf /etc/supervisor/conf.d/
ADD docker/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

# Start the web server
CMD [ "prerender" ]
