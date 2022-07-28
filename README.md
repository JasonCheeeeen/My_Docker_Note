# Docker Note & some problems solved
This File is record the problem and code when I learning docker.</br>
If you have some problems or code tou want to reshare, you can commit your file, and i will merge.</br>
Hope this file can help everyone and get some inspiration !

## Code instruction


## Problems & solved
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
  it may cause an **InRelease** problem, this is the **DNS** problem.</br>
  [caused by the difference DNS between /etc/resolv.conf and /run/systemd/resolved/resolv.conf]</br>
  ***SOLVED***</br>
  * Use soft link **ln** to connect the /etc/resolv.conf and /run/systemd/resolved/resolv.conf file to get the same DNS server.</br>
  ```
  sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
  ```
