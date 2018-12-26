FROM ubuntu:trusty
MAINTAINER Jay S 

#prevent the dpackage errors
ENV TERM=xterm-256color

#setting up a mirrors to a local us mirror so that it can speed up the deployment of the image

RUN sed -i "s/http:\/\/archive./http:\/\/us.archive./g" /etc/apt/sources.list

##Installing the Python package

RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \ 
    python python-virtualenv libpython2.7 python-mysqldb

##the -o APT flag tells apt-get not to install the recommended packages by default , and only the ones which we specify 


## create a Virtual enviornment 
## Upgrade pip in virtual enviornment to latest version , best practise is to ceate a virtualenv in the base image so that the child images does not need to worry about it 
## using the dot operator since docker images are built using the bourne shell 


RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade 


## Create an entry point hook/script for the app to activate the virtualenv and then run the app

## Adding entrypoint scripts

ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]