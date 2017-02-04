FROM daocloud.io/ubuntu:14.04

MAINTAINER Eli ae_lion@163.com

EXPOSE 8091
RUN ln -snf /bin/bash /bin/sh
# 替换apt源
#ADD https://raw.githubusercontent.com/Ayi-/docker-ubuntu-14.04/master/sources.list /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu/mirrors.tencentyun/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y wget \
    curl \
    git \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils
# 创建用户

RUN \
    adduser aiiyi --gecos "" --disabled-password && \
    echo "aiiyi:000000" | sudo chpasswd && \
    echo "root:000000" | sudo chpasswd && \
    mkdir /home/aiiyi/code
    

# 切换用户
USER aiiyi

# 切换工作目录
WORKDIR /home/aiiyi

# 设置环境变量
ENV HOME /home/aiiyi
#ENV PYENV_ROOT $HOME/.pyenv
#ENV PATH $PYENV_ROOT/bin:$PATH

RUN \
    # 安装Pyenv
    mkdir /home/aiiyi/.pyenv && \
    curl -L https://api.github.com/repos/yyuu/pyenv/tarball | tar xz --strip=1 -C /home/aiiyi/.pyenv && \

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/aiiyi/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/aiiyi/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> /home/aiiyi/.bashrc && \
    export PYENV_ROOT="$HOME/.pyenv" && \
    export PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init -)" && \

    # 安装pyenv-virtualenv
    mkdir /home/aiiyi/.pyenv/plugins/pyenv-virtualenv && \
    curl -L https://api.github.com/repos/yyuu/pyenv-virtualenv/tarball | tar xz --strip=1 -C /home/aiiyi/.pyenv/plugins/pyenv-virtualenv && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> /home/aiiyi/.bashrc && \
    eval "$(pyenv virtualenv-init -)" && \
    echo $PYENV_ROOT && \

    # 安装python 2.7.12
    wget http://mirrors.sohu.com/python/2.7.12/Python-2.7.12.tar.xz -P /home/aiiyi/.pyenv/cache/ && \
    pyenv install 2.7.12  && \
    pyenv rehash  && \

    # 安装python 3.6.0
    wget http://mirrors.sohu.com/python/3.6.0/Python-3.6.0.tar.xz -P /home/aiiyi/.pyenv/cache/ && \
    pyenv install 3.6.0  && \
    pyenv rehash  && \

    # 修改pip源
    mkdir ~/.pip && \
    echo "[global]" > ~/.pip/pip.conf  &&\
    echo "trusted-host = mirrors.aliyun.com" >> ~/.pip/pip.conf  && \
    echo "index-url = http://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf 


    # 创建virtualenv
    #pyenv virtualenv 2.7.12 blog  

RUN  \

    # 安装jupyter
    /home/aiiyi/.pyenv/versions/2.7.12/bin/python -m pip install jupyter && \
    /home/aiiyi/.pyenv/versions/2.7.12/bin/python -m ipykernel install --user --name 2.7.12 --display-name "Python 2.7.12" && \

    # 安装3.6.0内核
    /home/aiiyi/.pyenv/versions/3.6.0/bin/python -m pip install ipykernel  && \
    /home/aiiyi/.pyenv/versions/3.6.0/bin/python -m ipykernel install --user --name 3.6.0 --display-name "Python 3.6.0" && \
    
    # 创建默认配置文件
    /home/aiiyi/.pyenv/versions/2.7.12/bin/jupyter notebook --generate-config 
RUN \
    # 密码通过from notebook.auth import passwd获取的加密密码设置
    sed -i "s/#c.NotebookApp.password = u''/c.NotebookApp.password = u'sha1:f9f4e18b9b81:bf2a22d5f5639bb23ba60bf758ca4201d330e693'/" ~/.jupyter/jupyter_notebook_config.py  && \
    sed -i "s/#c.NotebookApp.port = 8888/c.NotebookApp.port = 8091/" ~/.jupyter/jupyter_notebook_config.py  && \
    #sed -i "s/#c.NotebookApp.notebook_dir = u''/c.NotebookApp.notebook_dir = u'\/home\/aiiyi\/'/" ~/.jupyter/jupyter_notebook_config.py   && \
    sed -i "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '0.0.0.0'/" ~/.jupyter/jupyter_notebook_config.py && \
    echo -e '#!/bin/bash\n/home/aiiyi/.pyenv/versions/2.7.12/bin/jupyter notebook' > jupyter.sh && \
    chmod +x jupyter.sh

ENTRYPOINT ./jupyter.sh
    
    