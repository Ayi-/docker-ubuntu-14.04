## 构建

`docker build -t 'jupyter' .`

## 启动

`docker run -d -p 8091:8091 -p 8092:8092 -v /home/ubuntu/code/jupyter/code:/home/aiiyi/code --name jupyter jupyter`



>  设置密码
>
> `c.NotebookApp.password = u'sha1:f9f4e18b9b81:bf2a22d5f5639bb23ba60bf758ca4201d330e693'`
>
> 密码通过`from notebook.auth import passwd`获取的加密密码设置

