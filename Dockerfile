FROM daocloud.io/ubuntu:14.04
# replace this with your application's default port
MAINTAINER Eli ae_lion@163.com
# 添加阿里apt源
ADD docker-ubuntu-14.04/sources.list /etc/apt/sources.list
EXPOSE 8081:8081 2223:22

