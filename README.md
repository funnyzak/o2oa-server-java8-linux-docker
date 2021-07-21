# O2OA Server Java8 Linux Docker

[![Docker Stars](https://img.shields.io/docker/stars/funnyzak/o2oa-server-java8-linux.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/o2oa-server-java8-linux/)
[![Docker Pulls](https://img.shields.io/docker/pulls/funnyzak/o2oa-server-java8-linux.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/o2oa-server-java8-linux/)

This image is based on Alpine Linux image, which is 2.3G+ image, and contains O2OA Server Java8 Linux (**o2server-6.2.1.java8-linux-x64**).

[Docker hub image: funnyzak/o2oa-server-java8-linux](https://hub.docker.com/r/funnyzak/o2oa-server-java8-linux)

Docker Pull Command: `docker pull funnyzak/o2oa-server-java8-linux`

---

## Usage Example

Here is an example configuration of Docker and Docker Compse.

### Docker Run

```Docker
docker run --net host --privileged -p 80:80 -p 20020:20020 -p 20030:20030 -p 20040:20040 -p 20050:20050 funnyzak:o2oa-server-java8-linux sh -c './start_linux.sh'
```

### Compose

```docker
version: '3'
services:
  nginx:
    image: funnyzak/o2oa-server-java8-linux
    container_name: o2oa-server-java8-linux
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "1g"
    privileged: true
    ports:
      - 82:80
      - 20020:20020
      - 20030:20030
      - 20040:20040
      - 20050:20050
```

---

## Related Link

* https://www.o2oa.net/download.html
* https://www.yuque.com/o2oa/course
