# Dockerfile for Ruby
# https://www.ruby-lang.org/en/

FROM rclanan/docker-nodejs
MAINTAINER Ray Clanan <rclanan@utopianconcept.com>

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

RUN curl -O http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz && \
  tar -zxvf ruby-2.1.2.tar.gz && \
  cd ruby-2.1.2 && \
  ./configure --disable-install-doc && \
  make && \
  make install && \
  cd .. && \
  rm -r ruby-2.1.2 ruby-2.1.2.tar.gz

RUN /bin/bash -l -c "gem install bundler"

ENTRYPOINT ["ruby"]

CMD ["-v"]
