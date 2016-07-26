FROM alpine:3.3

MAINTAINER Owen Ouyang <owen.ouyang@live.com>

ENV NOIP_USER=xxx 
ENV NOIP_PW=XXX
ENV NOIP_INT=30m

RUN export BUILD_DEPS="tar \
                build-base \
                wget" \
    && apk add --update --no-cache  \
                ${BUILD_DEPS} \
    && cd /tmp \
    && wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz \
    && tar xvfz noip-duc-linux.tar.gz \
    && cd noip-2.1.9-1/ \
    && make \
    && cp noip2 /bin/noip2 \
  	&& apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/noip*

ENTRYPOINT ["/bin/noip2", "-u", "$NOIP_USER", "-p", "$NOIP_PW", "-U", "$NOIP_INT"]
