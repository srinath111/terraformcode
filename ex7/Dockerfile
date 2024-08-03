FROM httpd
MAINTAINER srinath
RUN apt update -y\
     &&  apt install -y git curl nginx net-tools\
     && apt install -y maven\
     && mkdir myapp
WORKDIR /myapp
copy index.html /myapp
CMD  bash  cp /myapp/index.html /var/www/html
ENTRYPOINT [ "yum install maven" ]
