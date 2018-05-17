FROM ubuntu:16.04
#Installing Python 3 packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
	python3 \
	python3-dev \
	python3-setuptools \
	python3-pip \
	build-essential \
	python-lxml && rm -rf /var/lib/apt/lists/*

#Installing dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
	gstreamer1.0-plugins-base \
	gstreamer1.0-tools \
	gstreamer1.0-x \
	qtcreator-dev \
	qt-sdk \
	libqt5webkit5-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	xvfb && rm -rf /var/lib/apt/lists/*

#Install uwsgi package
RUN pip3 install uwsgi

#Install Monit and Nginx services
RUN apt-get update && \ 
	apt-get install --no-install-recommends -y monit nginx

#Adding ubuntu User
RUN useradd ubuntu -m --home-dir /home/ubuntu -u 1000
RUN mkdir -p /home/ubuntu/golddigger/

#Setup log and config dirs
RUN mkdir -p /home/ubuntu/logs && mkdir -p /home/ubuntu/config && \ 
			 chown ubuntu /home/ubuntu/logs  && \
			 chown ubuntu /home/ubuntu/config

#Copying requirements.txt and Installing python dependencies
COPY requirements.txt /home/ubuntu/golddigger/
WORKDIR /home/ubuntu/golddigger
RUN pip3 install -r requirements.txt

#Copying configs and startup scripts
ADD ./deploy/uwsgi.ini /home/ubuntu/config/uwsgi.ini
ADD ./deploy/monitrc /etc/monit/monitrc
RUN chmod 600 /etc/monit/monitrc
ADD ./deploy/golddigger-nginx.conf /etc/nginx/sites-available/default
ADD ./deploy/container_start.sh /home/ubuntu/config/container_start.sh
RUN chmod a+x /home/ubuntu/config/container_start.sh

#Exposing Nginx port 
EXPOSE 80

#Exposing Monit port
EXPOSE 2812

 #Starting Wrapper script
CMD ["sh", "/home/ubuntu/config/container_start.sh"]
