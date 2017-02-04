启动本地nginx测试环境


    docker run \
    --name nginx-local \
    -d \
    -p 80:80 \
    -v /code/docker/nginx/local/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v /code/docker/nginx/local/conf.d:/etc/nginx/conf.d \
    daocloud.io/nginx:1.10.2
