# Dockerfile for Ruby
# https://www.ruby-lang.org/en/

FROM rclanan/docker-nodejs

MAINTAINER Ray Clanan <rclanan@utopianconcept.com>


RUN apt-get update && \
  apt-get install -y bison curl ruby procps && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /usr/src/ruby && \
  curl -SL "http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.bz2" | tar -xjC /usr/src/ruby --strip-components=1 && \
  cd /usr/src/ruby && \
  autoconf && \
  ./configure --disable-installall-doc && \
  make -j"$(nproc)" && \
  apt-get purge -y bison ruby procps && \
  apt-get autoremove -y && \
  make install && \
  rm -r /usr/src/ruby

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

RUN gem install bundler

VOLUME ["/data"]

CMD ["irb"]
