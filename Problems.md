# Problems [Solved & Unsolved]
* The ubuntu on VMware and no network connection</br>
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
* When you use docker instructions and you do not want to use **sudo**</br>
  ***SOLVED***
  ```
  sudo groupadd docker
  sudo usermod -aG docker **YOUR NAME**
  ```
