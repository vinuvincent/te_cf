#!/bin/sh
#Correcting permission
chown ubuntu:ubuntu -R /home/ubuntu/golddigger/
#Django DB Migration scripts
su - ubuntu -c 'cd /home/ubuntu/golddigger && /usr/bin/python3.5 manage.py migrate --noinput' 
#Setup static files in Django
su - ubuntu -c 'cd /home/ubuntu/golddigger && /usr/bin/python3.5 manage.py collectstatic --noinput'

#Starting Monit in interactive mode
/usr/bin/monit -d 10 -Ic /etc/monit/monitrc

#Starting Monit in daemon Mode
#/etc/init.d/monit start 
#Uncomment below, if starting Monit in daemon mode
# # Stay up for container to stay alive
#while [ 1 ] ; do
#    sleep 1d
#done