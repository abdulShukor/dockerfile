# Multi  stages dcokerfile
#  Build image
FROM ubuntu:latest AS BUILD_IMAGE 
RUN apt update && apt install -y \
wget \
unzip \
&& rm -rf 2131_wedding_lite 2131_wedding_lite.zip \
&& wget https://templatemo.com/tm-zip-files-2020/templatemo_580_woox_travel.zip \
&& unzip templatemo_580_woox_travel \
&& cd templatemo_580_woox_travel  \
&& tar cvzf templatemo_580_woox_travel.tar.gz  * 

#-----
FROM ubuntu:latest
LABEL "Author"="Abdul"
LABEL "Project"="Woox Travel Template"
RUN apt update && apt install -y \
git \
apache2 
EXPOSE 80
WORKDIR /var/www/html
RUN rm -rf * 
COPY  --from=BUILD_IMAGE templatemo_580_woox_travel/templatemo_580_woox_travel.tar.gz /var/www/html
RUN tar xvzf templatemo_580_woox_travel.tar.gz  && rm -f templatemo_580_woox_travel.tar.gz 
VOLUME /var/log/apache2
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
