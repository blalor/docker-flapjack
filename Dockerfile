FROM blalor/supervised:latest
MAINTAINER Brian Lalor <blalor@bravo5.org>

EXPOSE 3080
EXPOSE 3081
EXPOSE 3071

ADD src /tmp/src/
RUN /tmp/src/config.sh
