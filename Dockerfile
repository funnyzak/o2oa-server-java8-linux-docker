#基础镜像
FROM funnyzak/alpine-glibc

ARG O2OA_LINUX_VERSION=o2server-6.2.2.java8-linux-x64

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

ARG O2OA_LINUX_DOWNLINK=https://download.o2oa.net/download/${O2OA_LINUX_VERSION}.zip

RUN curl "$O2OA_LINUX_DOWNLINK" -H 'Host: download.o2oa.net' -H 'Connection: keep-alive' -H 'sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"' -H 'sec-ch-ua-mobile: ?0' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' -H 'Sec-Fetch-Site: cross-site' -H 'Sec-Fetch-Mode: navigate' -H 'Sec-Fetch-User: ?1' -H 'Sec-Fetch-Dest: document' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: zh-CN,zh;q=0.9,zh-TW;q=0.8,en;q=0.7' -H 'Cookie: Hm_lvt_b60277863000072d920be5d8bf17a09e=1627283388; Hm_lpvt_b60277863000072d920be5d8bf17a09e=1627283388; Hm_lvt_3bf86557bdd5f1d58ae181f0b61b0829=1627283388; Hm_lpvt_3bf86557bdd5f1d58ae181f0b61b0829=1627283388; __root_domain_v=.o2oa.net; _qddaz=QD.488827283388362; _qdda=3-1.1; _qddab=3-sagfwh.krkaiigq' --compressed --output './app.zip'

RUN unzip app.zip
RUN rm -f app.zip

RUN mv ./o2server/* $WORK_HOME

WORKDIR $WORK_HOME

EXPOSE 80
EXPOSE 8080
EXPOSE 20020
EXPOSE 20030
EXPOSE 20040
EXPOSE 20050

ENTRYPOINT ["/bin/bash", "./start_linux.sh"]