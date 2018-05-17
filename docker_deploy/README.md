# Golddigger Docker repo
This repository contains the Dockerfile and other configuration files required for building NameCheck docker image. 

The NameCheck is a Django Application(part of Golddigger application) and served using USWGI application server and Nginx Reverse proxy. Monit is used to monitor and mange uwsgi and Nginx processes inside the Docker Container.

Django Database Migration and static files generation(manage.py collectstatic) are handled via wrapper startup script. Django code is not included in the image.

If you need to update/remove python packages used by NameCheck application, edit the file `requirements.txt` and build the image.

## EXPOSED PORTS
 - 80 (Nginx)
 - 2812 (Monit)

## Volumes
 - /home/ubuntu/golddigger/ (Mount to the Django code directory of the host machine)
 
After building the image, upload the image to the Amazon Docker repo `116803286952.dkr.ecr.us-east-1.amazonaws.com/namecheck
`

## Building the image 

1. Extract the contents to a directory. To start the build process:
    ```
    docker build -t namecheck:<version> .
    ```
2. Login to Amazon Docker repo. You can get the login command via running following script.
    ```
    aws ecr get-login --no-include-email --region us-east-1
    ```
3. Tag the docker image
    ```
    docker tag (ImageID of golddocker:<version>) 116803286952.dkr.ecr.us-east-1.amazonaws.com/namecheck:<version>
    docker tag (ImageID of golddocker:<version>) 116803286952.dkr.ecr.us-east-1.amazonaws.com/namecheck:latest
    ```
4. Push the tagged image to Amazon Docker repository
    ```
    docker push 116803286952.dkr.ecr.us-east-1.amazonaws.com/namecheck:<version>
    docker push 116803286952.dkr.ecr.us-east-1.amazonaws.com/namecheck:latest

    ```
