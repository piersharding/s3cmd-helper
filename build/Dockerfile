ARG ALPINE_BASE_IMAGE=alpine:3.8
FROM $ALPINE_BASE_IMAGE

RUN apk --update add \
  ca-certificates \
  git \
  py-pip \
  py-setuptools \
  python

RUN pip install python-dateutil

# apk for s3cmd is in edge/testing and is broken
RUN git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd
RUN ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

WORKDIR /opt

# default configuration
COPY ./s3cfg /opt/.s3cfg

# Folders for s3cmd IO
RUN mkdir /src
RUN mkdir /dest

WORKDIR /

# declar the IO and a place for sharing in a custom config
VOLUME ["/src", "/dest", "/config"]

ENTRYPOINT ["/opt/s3cmd/s3cmd"]
CMD ["--config=/opt/.s3cfg", "--help"]
