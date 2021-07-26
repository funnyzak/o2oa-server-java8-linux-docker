#基础镜像
FROM funnyzak/alpine-glibc

ARG O2OA_LINUX_VERSION=o2server-6.2.2.Java8-linux-x64

LABEL org.label-schema.vendor="potato<silenceace@gmail.com>" \
    org.label-schema.name="O2OA" \
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.description="O2OA Server." \
    org.label-schema.docker.cmd="docker run --net host --privileged -p 80:80 -p 20020:20020 -p 20030:20030 -p 20040:20040 -p 20050:20050 funnyzak:o2oa-server-java8-linux sh -c './start_linux.sh'" \
    org.label-schema.url="https://yycc.me" \
    org.label-schema.version="${O2OA_LINUX_VERSION}" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref="${VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/funnyzak/o2oa-server-java8-linux-docker" 

ENV LANG=C.UTF-8

# Install modules
RUN apk update && apk upgrade && \
    # Install python/make/gcc for gyp compilation.
    apk add --no-cache g++ make && \
    # Install need modules
    apk add --no-cache bash git openssh rsync && \
    apk add --no-cache curl nginx zip unzip gzip bzip2 tar wget tzdata && \
    apk add --no-cache ca-certificates && \
    # Install Font
    apk add fontconfig msttcorefonts-installer && \
    update-ms-fonts && \
    fc-cache -f && \
    # Remove Apk Cache
    rm  -rf /tmp/* /var/cache/apk/*

# 定义环境变量
ENV WORK_HOME /usr/local/o2server

RUN mkdir -p $WORK_HOME

WORKDIR $WORK_HOME

ARG APP_ZIP_NAME=${O2OA_LINUX_VERSION}

COPY app/${APP_ZIP_NAME}.zip $WORK_HOME/

RUN unzip $WORK_HOME/${APP_ZIP_NAME}.zip
RUN rm -f $WORK_HOME/${APP_ZIP_NAME}.zip

RUN mv ./o2server/* $WORK_HOME


EXPOSE 80
EXPOSE 8080
EXPOSE 20020
EXPOSE 20030
EXPOSE 20040
EXPOSE 20050

ENTRYPOINT ["/bin/bash", "./start_linux.sh"]