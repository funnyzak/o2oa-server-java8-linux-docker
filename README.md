oc# O2OA Server Java8 Linux Docker

[![Docker Stars](https://img.shields.io/docker/stars/funnyzak/o2oa-server-java8-linux.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/o2oa-server-java8-linux/)
[![Docker Pulls](https://img.shields.io/docker/pulls/funnyzak/o2oa-server-java8-linux.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/o2oa-server-java8-linux/)

This image is based on Alpine Linux image, which is 1.4G+ image, and contains O2OA Server Java8 Linux (**o2server-6.2.2.java8-linux-x64**).

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

Compose事例：

```docker-compose
version: '3'
services:
  server:
    image: funnyzak/o2oa-server-java8-linux
    container_name: o2oa-server
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "1g"
    privileged: true
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - ./o2server/logs:/usr/local/o2server/logs
      - ./o2server/config:/usr/local/o2server/config
    ports:
      - 82:80
      - 20020:20020 # 以下默认端口号和映射最好保持一致
      - 20030:20030
      - 20040:20040
      - 20050:20050
    depends_on:
      - mysql
    links:
      - mysql
    networks:
      - o2oa_net
  mysql:
    container_name: o2oa-mysql
    image: mysql:8.0.22
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    restart: always
    volumes:
      - ./db/mysql:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=sjdf@sdnd5j
      - MYSQL_PASSWORD=sjdsdfsd23f3
      - MYSQL_DATABASE=o2oa
      - MYSQL_USER=u_o2oa
    ports:
      - 1060:3306
    networks:
      - o2oa_net
networks:
  o2oa_net:
    driver: bridge
      
```

## System Intro

### 默认账号

用户名：xadmin  密码：o2


## Develop

### 修改程序文件

如果需要开发，修改源程序，则可以在启动container以后，复制一份"o2server"源程序，volume挂载相应的目录或配置文件。具体操作如：

1. 在compose上下文执行cmd：
  
```bash
docker cp o2oa:/usr/local/o2server ./
```

2. 然后修改挂载对应目录或文件

以下为挂载所有o2server程序目录

```compose
volumes:
  - ./o2server:/usr/local/o2server # server
```

3. 然后在上下文执行：

```bash
docker-compose up -d
```

### 修改端口映射

如何映射的端口和默认端口不同，则需要修改配置文件。修改的文件如下：

[系统配置-服务器端口冲突和端口修改@启动报错](https://www.yuque.com/o2oa/course/ugnw7f)

对外的端口主要修改：`proxyPort`

**端口映射最好和默认端口一致，以免有意外问题**

### 可能使用的配置

* [系统配置-第三方数据库配置-MySQL@平台配置](https://www.yuque.com/o2oa/course/qlyse7)
* [系统配置-服务器端口冲突和端口修改@启动报错](https://www.yuque.com/o2oa/course/ugnw7f)
* [开发知识-单个端口模式的Nginx和系统配置](https://www.yuque.com/o2oa/course/ar1gnh)
* [OEM白标-如何修改平台中的Logo图标和文字](https://www.yuque.com/o2oa/course/qfbuga)

### 获取服务器端口配置

```html
http://xxx.xxx.xxx.xxx:20030/x_program_center/jaxrs/distribute/webserver/assemble/source/xxx.xxx.xxx.xxx
````
以上改为服务器IP。

### 其他说明

* 如修改相应服务端口，请务必修改 **node.json**的 port 端口。


---

## Related Link

* https://www.o2oa.net/download.html
* https://www.yuque.com/o2oa/course
