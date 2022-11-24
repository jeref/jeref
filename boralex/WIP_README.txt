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
restart : docker restart c7d568bfab9bee89b3280f7a33ef4c72e3e67b3ff5592dc007c856dd0be86aa6

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

sur PC blx :
2: docker run --network=host -e SONAR_HOST_URL='http://localhost:9000' -e SONAR_LOGIN="sqp_b6fe62c9e6efce5f013680c2bb8805d7364b6ab9" -v "$PWD:/usr/src" sonarsource/sonar-scanner-cli
org.sonarqube:sonarqube-scanner

14/11/2022
lier la couverture de code de unittest avec Sonar
https://pypi.org/project/unittest-xml-reporting/
==> ouputs xml file to be analysed with sonar

Probléme : ConnectException: Failed to connect to localhost/0:0:0:0:0:0:0:1:9000
docker run --rm --network=host -e SONAR_HOST_URL="***" -e SONAR_LOGIN="***" -v "$PWD:/usr/src" sonarsource/sonar-scanner-cli


16/11
run unittest coverage
17/11
pass unittest output to next step
VEN 18/11
adapt unitest output to sonar requirements

LUN 21/11
xmlrunner not executed ==> no unit test report in Sonar
MAR 22/11
https://linuxhandbook.com/modifying-docker-image/
Not applied but should ! (not testing the right image)

VScode addon github action but unused !
https://github.com/marketplace/actions/github-build-deploy-action

test workflow syntax : https://dev.to/byteslash/how-to-test-your-github-actions-locally-3830
==> install https://github.com/nektos/act

run workflow triggered by workflow_run
https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows

run releases by needs and if branch (ref_name) : 
https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idneeds
https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idif

MER 23/11
Realease ok
test failure
https://community.sonarsource.com/t/error-in-check-quality-gate-status-github-action/69773/3
<==> Adding /d:sonar.qualitygate.wait=true == check sonar quality gate status failed sonarqube from github

JEU 24/11
deploy OK
toDo : build same Dokerfile, squash commits
démo : voir déroulé
cookBook : en cours
next : secrets, ansible, alertes/dashboard
