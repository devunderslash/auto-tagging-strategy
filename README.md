<<<<<<< HEAD
# Tagging Docker Images POC

To Build the dockerfile use the following:

Run the bash script with `sh docker-build.sh`

To run the image:

`docker run -it -d --name {enter-name-here} -p 80:8080 devunderslash/test:{hash}-{timestamp}` 

You can get the {hash}-{timestamp} from running `docker ps`

If you want to get into the container then run the following:

`docker exec -it {container-name} bash`

This comment should make it to master
=======
# Tagging Docker Images POC

To Build the dockerfile use the following:

Run the bash script with `sh docker-build.sh`

To run the image:

`docker run -it -d --name {enter-name-here} -p 80:8080 devunderslash/test:{hash}-{timestamp}` 

You can get the {hash}-{timestamp} from running `docker ps`

If you want to get into the container then run the following:

`docker exec -it {container-name} bash`


This will be updated

This will be updated and it's contentious

>>>>>>> release-2
