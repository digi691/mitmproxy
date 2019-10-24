FROM alpine:3.8

ENV LANG=en_US.UTF-8
ENV HOME=/mitmproxy

ARG WHEEL_MITMPROXY
ARG WHEEL_BASENAME_MITMPROXY

COPY $WHEEL_MITMPROXY $HOME/

# Add our user first to make sure the ID get assigned consistently,
# regardless of whatever dependencies get added.
RUN apk add --no-cache \
        su-exec \
        git \
        g++ \
        libffi \
        libffi-dev \
        libstdc++ \
        openssl \
        openssl-dev \
        python3 \
        python3-dev \
    && python3 -m ensurepip --upgrade \
    && pip3 install -U pip \
    && LDFLAGS=-L/lib pip3 install -U $HOME/${WHEEL_BASENAME_MITMPROXY} \
    && apk del --purge \
        git \
        g++ \
        libffi-dev \
        openssl-dev \
        python3-dev \
    && rm -rf ~/.cache/pip $HOME/${WHEEL_BASENAME_MITMPROXY} \
    && chmod g=u /etc/passwd \
    && chgrp -R 0 $HOME && chmod -R g=u $HOME
    

VOLUME $HOME

COPY release/docker/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER 1000

EXPOSE 8080 8081

CMD ["mitmproxy"]
