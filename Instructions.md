# Docker instructions
* push your own docker to ducker hub
  [you need to have account of docker hub]
  ```
  docker login
  
  // check what image you want to push
  docker image ls

  // tag image
  docker tag [image id] [name of ducker hub / ducker repository name : vision]
  // ex: docker tag 57452930cc15 jxxxxxxj/test-container:1.0.0

  // push to docker hub
  docker push jxxxxxxj/test-container:1.0.0
  ```
* Install Docker engine (Ubuntu)  
  ```
  sudo apt-get install docker.io

  // check the install finished or not
  service docker status 
  ```
* find the image on docker hub
  ```
  // (omitted sudo by problem 3 below)
  // If you want to find specific vision, you can use like ubuntu:16.04, if not, it will be seen as latest vision.
  docker search [image name like ubuntu ,ubuntu:latest or ubuntu:16.04]
  ```
* pull the image
  ```
  docker pull [image name]
  ```
* search the images on local
  ```
  docker images
  ```
* run the container based on ubuntu image
  ```
  // -i -> interactive with this container
  // -t -> create a terminal for container
  // -d -> run this containr in background
  // --name -> your container name, if you do not want to name, it will be a long ugly id, so...
  docker run -i -t -d --name=[your container name] [image name]
  // ex: docker run -i -t -d --name=myubuntu:v0 ubuntu
  ```
* construct image from container
  ```
  docker commit -m 'some message about modification' -s 'your name' [container id] [image name and version]
  ```
* search the container we create
  ```
  // show the running containers
  docker ps

  // show all containers (include sleeping containers)
  docker ps -a
  ```
* stop the running container
  ```
  docker stop [container name or container id]
  ```
* awake the sleeping container
  ```
  docker (start or restart) [container name or container id]
  ```
* use the running container
  ```
  docker attach [container name or container id]
  ```
* leave the running container
  ```
  exit or tab ctrl+d
  ```
* remove container
  ```
  // remove one container
  docker rm [container name or container id]

  // remove all containers
  docker rm $(docker ps -a -q)
  ```
* remove images
  ```
  // When you want to remove the image, you will check there is not any container use the base of this image.
  // If there has one container which based on image you want to remove, the image will not be removed !

  // remove one image
  docker rmi [image name or image id]

  // remove all images
  docker rmi $(docker images -q)
  ```
* Use example to show the sequential instructions</br>
  [run an cpp example on ubuntu container]</br>
  ***FIRST WAY***
  ```
  docker search ubuntu
  docker pull ubuntu
  docker run -it --name:myubuntu ubuntu /bin/bash
  apt-get update
  apt-get install nano g++
  // you can write a simple hello world code to test, suppose we write a cpp code named test.cpp
  g++ test.cpp -o test
  ./test
  exit
  ```
  ***SECOND WAY - DOCKERFILE***
  * write a Dockerfile
  ```
  FROM [image name, like ubuntu]
  RUN apt-get update
  // make a directory
  MKDIR test
  // copy file from host to container's directory 
  COPY test.cpp /test
  ```
  * build the images
  ```
  docker build -t [your image name, like myubuntu:v1] .
  // check image constructed or not
  docker images
  ```
  * construct the container & run container
  ```
  docker run -i -t -d --name=[your container name] [your image name, as above:myubuntu:v1] /bin/bash
  ```
  * run the cpp code
  ```
  apt-get install g++
  g++ test.cpp -o test
  ./test
  exit
  ```
* construct data volume without connecting to container
  ```
  docker volume create [volume name]
  ```
* construct data volume with container
  ```
  docker run -it --name=[container's name] -v [data volume]:/[container data path of data volume] [image name]

  // container can have many data volume
  docker run -it --name=[container's name] -v [data volume]:/[container data path of data volume] -v [data volume]:/[container data path of data volume] [image name]
  ```
* search data volume
  ```
  docker volume list
  ```
* delete data volume
  ```
  // remove one data volume
  docker volume rm [data volume name or id]

  // remove all data volume
  docker volume rm $(docker volume list)
  ```
* construct data volume container (same as construct a container)
  ```
  docker create --name=[container name] -v [data volume]:/[container data path of data volume] [image name]
  ```
* connect to data volume container
  ```
  docker run -it --name=[container name] --volumes-from [name of data volume container] [image name]
  ```
