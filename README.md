# Docker note & some problems solved
This File recorded the problem and code when I learned Docker.</br>
If you have some problems and code you want to reshare or somethig I wrote wrong, you can commit your file, and i will check and merge.</br>
Hope this file can help everyone and get some inspiration !

## Docker instructions
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
* Install Docker engine (Ubuntu)</br>
  ```
  sudo apt-get install docker.io

  // check the install finished or not
  service docker status 
  ```
* Standard docker instructions</br>
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
  docker run -i -t -d --name=[yourname]:[some message, like version] [image name]
  // ex: docker run -i -t -d --name=myubuntu:v0 ubuntu
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



## Problems [Solved & Unsolved]
* The ubuntu on VMWare and no network connection</br>
  ***SOLVED***
  * there has the image of network
  ```
  sudo service network-manager restart
  ```
  * there has not the image of network
  ```
  sudo service network-manager stop
  sudo rm /var/lib/NetworkManager/NetworkManager.state
  sudo service network-manager start
   ```
* When you use a exist image or Dockerfile to create container, and you want to use **apt-get update**,</br>
  it may cause an **E: Unable to locate package ... or another warning message** problem, this may be a **DNS** problem.</br>
  [caused by the difference DNS between /etc/resolv.conf and /run/systemd/resolved/resolv.conf]</br>
  ***SOLVED***</br>
  * Use soft link **ln** to connect the /etc/resolv.conf and /run/systemd/resolved/resolv.conf file to get the same DNS server.</br>
  ```
  sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
  ```
* when you use docker instructions and you do not want to use **sudo**</br>
  ***SOLVED***
  ```
  sudo usermod -aG docker **YOUR NAME**
  ```