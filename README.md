# grass-desktop-node
Docker image for [Grass Desktop Node](https://app.getgrass.io/register/?referralCode=mym0QmjqhIN89gy). 
The Grass Desktop Node is a lightweight standalone application that is designed to run on any desktop. Users of the desktop node are awarded priority network traffic and are able to earn additional rewards for occasional access to the user's bandwidth.

# Setup
```bash
docker run -d \
   --restart unless-stopped \
   --name grass \
   --network host \
   -v $HOME/appdata/grass:/config \
   -e USER_ID=$(id -u) \
   -e GROUP_ID=$(id -g) \
   -e TZ=Asia/Shanghai \
   217heidai/grass:latest
```
or
```bash
docker run -d \
   --restart unless-stopped \
   --name grass \
   -v $HOME/appdata/grass:/config \
   -e USER_ID=$(id -u) \
   -e GROUP_ID=$(id -g) \
   -e TZ=Asia/Shanghai \
   -p 5800:5800 \
   217heidai/grass:latest
```

# Setting
1. Open the webpage http://yourip:5800
2. login grass with your account
3. earn more rewards