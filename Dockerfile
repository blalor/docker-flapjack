## this feels a little weird, but redis is core to flapjack…
FROM blalor/redis

# redis
EXPOSE 6380
EXPOSE 3080
EXPOSE 3081

VOLUME [ "/var/lib/flapjack" ]

ADD src /tmp/src/
RUN /tmp/src/config.sh
