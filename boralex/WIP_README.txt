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
-	Use cahed layers from docker build push

https://github.com/docker/build-push-action/issues/493
-> https://github.com/orgs/community/discussions/25728
==	Add in  “action”.yml = load: true

04/11/2022
https://github.com/Boralex-France/blx-vpp_backend/blob/feature_tests_unitaires/.github/workflows/docker-image-test.yml
uses cache for docker-compose
/!\ https://github.com/Boralex-France/blx-vpp_backend/actions/caches ==> cache limit
NO master cache ==> probably erased by space demand.
curl -H "Accept: application/vnd.github+json" -H "Authorization: Bearer <PERSONAL_TOKEN>"   https://github.com/api/v3/enterprises/Boralex-France/actions/cache/usage-policy
Not Found

https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment

deploy front

Sonar CE deployment :
[
    use with any branch plugin :
https://hub.docker.com/r/mc1arke/sonarqube-with-community-branch-plugin
]
https://www.bitslovers.com/how-to-use-sonarqube-with-docker-and-maven/
==> KO !
==> https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/
== use CLI SonarScanner
1: $docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:community
test sur blx-vpp_frontend
==> branche
create sonar-project.properties + sonar.yml
jeref@LPT-FR-o5kT13Rc:~$ mkdir /home/jeref/actions-runner/_work/_temp/_github_home
chmod -R 777 /home/jeref/jeref@LPT-FR-o5kT13Rc:~$ actions-runner/_wor
create docker group and add to $USER
create _temp/_github_home , _temp/_github_workflow , _temp/_runner_file_commands

run https://weihungchin.medium.com/how-to-set-up-sonarqube-in-windows-mac-and-linux-using-docker-3959c5a95eb2
Asus-Jeref WSL Ubuntu 22.04
docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:community

jeref@Asus-Jeref:~/Dev/test_tmp$ docker run --network=host -e SONAR_HOST_URL='http://localhost:9000' -e SONAR_LOGIN="sqp_8787b53db5b296400cbd1845ec6184d0d108c9db" -v "$PWD:/usr/src" sonarsource/sonar-scanner-cli
OKgit config