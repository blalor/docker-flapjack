FROM blalor/supervised

ADD src /tmp/src/
RUN /tmp/src/config.sh
