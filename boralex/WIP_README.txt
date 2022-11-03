raspberrypi : install CI tools :
https://www.simplilearn.com/tutorials/docker-tutorial/raspberry-pi-docker
==> /!\ docker apt install
usermod -aG docker $USER
reboot (https://docs.docker.com/engine/install/linux-postinstall/)

remote access : https://www.socketxp.com/iot/how-to-access-raspberry-pi-remotely-over-the-internet/#:~:text=Connect%20Raspberry%20Pi%20Remotely%20Over%20Internet&text=Just%20click%20the%20terminal%20icon,put%20in%20a%20shell%20prompt.
https://portal.socketxp.com/#/devices
when logged out : have to wait

https://www.simplilearn.com/tutorials/docker-tutorial/raspberry-pi-docker

search :
- https://github.com/wbond/pi-github-runner : to execute as docker container
https://github.com/jonico/awesome-runners
https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners#prerequisites
jeref@raspberrypi:~/actions-runner $ ./run.sh

debug : KO on docker login
DOCKER_HUB_ACCESS_TOKEN & USER on repo perso

https://github.com/jeref/private_tests/actions/runs/3363363956/jobs/5576398286
Build dont use cache :
https://github.com/docker/build-push-action/issues/153
crazy-max commented on 4 Oct 2020 • 
Hi @ltamrazov
That's because your cache is mixed with 2 images. You have to create another cache:
...