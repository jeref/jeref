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

Deployments to different environnement :
environnement Secrets and workflow_call (https://docs.github.com/en/enterprise-cloud@latest/actions/using-workflows/reusing-workflows) !
https://blog.gitguardian.com/github-actions-security-cheat-sheet/
with:
  path: 'production/'
  environment: 'production'
# ./.github/workflows/deploy_reusable.yml
workflow_call:
  inputs:
    environment:
      type: string
-------------
jobs:
 deploy:
 environment: ${{ inputs.environment }}

 MAR 29/11
 https://supports.uptime-formation.fr/06-ansible/cours4/
 
 Ansible repo cleaner :
 https://rtyley.github.io/bfg-repo-cleaner/
 alternative to git-filter-branch
<==> suppression de gros fichiers

VEN 02/12
https://adamj.eu/tech/2022/03/25/how-to-squash-and-rebase-a-git-branch/
+ test auto versioning

LUN 05/12
check test_ci1_
test GitGardian + envisager Yelp detect-secrets

MAR 06/12
finaliser MEP Secrets DB logins
logins ==
Docker_password

use of act with podman : https://github.com/nektos/act/issues/303
MER 07/12
toujours pas de récupération de la dernière image
<==> use docker-compose down --rmi all
https://www.baeldung.com/ops/docker-compose-latest-image

Documentation CI/CD
https://boralex.sharepoint.com/:w:/r/sites/A2I_FR/_layouts/15/Doc.aspx?sourcedoc=%7BAB0915AB-1F52-48BA-9F02-993951048E65%7D&file=Documentation_CI-CD.docx&action=default&mobileredirect=true

MER 07/12
Documentation CI/CD
hit merge test_ci2 (develop) avec test_ci1 
JEU 08/12
on test_ci1 :
>git checkout -b test_ci2 
>git rebase -i develop (f ou s pour suppression des commits non désirés)

https://claroty-statamic-assets.nyc3.digitaloceanspaces.com/resource-downloads/2021_q1_global_splunk_integration_brief.pdf

LUN 12/12
Sonar not showing all unit tests
- https://stackoverflow.com/questions/26870606/how-to-get-python-unit-test-results-in-sonarqube
==> ancien bug 2015 ! Sonar 4.5
- https://stackoverflow.com/questions/32715266/sonar-xunit-file-is-not-parsed-by-sonar-runner
==> sonar.python.xunit.skipDetails=false change rien !

Ansible
https://roelofjanelsinga.com/articles/ansible-easy-safe-ssh-deployments-from-github/
==> Pas utile

https://serverfault.com/questions/241588/how-to-automate-ssh-login-with-password
$ sudo apt-get install sshpass
$ sshpass -p your_password ssh user@hostname
==> connexion with passwork allowed !


https://serverfault.com/questions/285800/how-to-disable-ssh-login-with-password-for-some-users
Match User user1,user2,user3,user4
    PasswordAuthentication no
==> Match User ansible
    PasswordAuthentication no
dans /etc/ssh/sshd_config.d/ansible.conf
sudo systemctl restart ssh && sudo systemctl restart sshd
ssh ansible@10.140.242.100 -o PubkeyAuthentication=no ==>KO
ssh 'ext-jeremie.foricheu@boralex.kingsey'@10.140.242.100 -o PubkeyAuthentication=no ==> asks Pass & OK ==> ansible diff !
mais sshpass -p <pass> ssh ansible@10.140.242.100 ==> Pass !
Semble ne pas être possible de supprimer complètement l'auth via password comme ça, il faudrait essayer en désactivant pour tous les utilisateurs et aussi UsePAM ! 

MAR 13/12
exécution du déploiement via ansible

https://learn.microsoft.com/en-us/azure/developer/ansible/configure-in-docker-container?tabs=azure-cli
==> spécifique Azure
https://duffney.io/containers-for-ansible-development/#create-a-dockerfile
==> centos7
https://geektechstuff.com/2020/02/10/ansible-in-a-docker-container/
==> https://hub.docker.com/r/philm/ansible_playbook ==> ansible 2.2.2 (old)

https://duffney.io/containers-for-ansible-development/#create-a-dockerfile ==> vault


https://github.com/marketplace/actions/run-your-ansible-playbook-in-a-docker-container
==> uses private key !

pour se connecter à ansible depuis energy.markets :
ssh -i ~/.ssh/ansible ansible@10.140.242.100

docker run -it --rm --volume "$(pwd)":/ansible --entrypoint bash -w /ansible ansible
ajouter le partage des clefs ssh :
 -v ~/.ssh/ansible:/root/.ssh/id_rsa -v ~/.ssh/ansible.pub:/root/.ssh/id_rsa.pub

MER 21/12
Suite de mise en place d'Ansible (depuis 1 semaine !)
Semble avoir fonctionnée.q

Slide schéma global
creuser des points (code review) : 
- Docker
- github
- Ansible
- Workflow ?
- tests unitaires / fonctionnels

toDo : ansible_rsa-encypted ne doit pas se retrouver sur le host esclave ! (Work dir Volume !)

JEU 22/12
optimisation de la récupération des secrets
TEST_SECRET sur private_tests:

LUN MAR MER 02 03 04 /01
- Optimisation de l'utilisation des variables
- limitation des copies ansible
- création de sauvegardes images DockerHub
- test d'un pseudo déploiement master sur feature_ci_scandockerhub

JEU 05/01
Nettoyage des images DockerHub
- lister toutes les images ==> nécessite une pull boralex/blx-vpp_frontend -a
- supprimer les images distantes : nécessite l'utilisation du wget ou curl avec TOKEN 

https://stackoverflow.com/questions/44209644/how-do-i-delete-a-docker-image-from-docker-hub-via-command-line
HUB_TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$HUB_USERNAME\", \"password\": \"$HUB_PASSWORD\"}" https://hub.docker.com/v2/users/login/ | jq -r .token)
curl -i -X DELETE   -H "Accept: application/json"   -H "Authorization: JWT $HUB_TOKEN"   https://hub.docker.com/v2/repositories/boralex/blx-vpp_frontend/tags/feature_ci_scandockerhub-23.01.04-17.46.41
UNAME=boralex
GET list of tags :
curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/blx-vpp_frontend/tags/?page_size=100 | jq -r '.results|.[]|.name'
scripts from https://gist.github.com/kizbitz/e59f95f7557b4bbb8bf2
##
UNAME=boralex
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"$HUB_USERNAME\", \"password\": \"$HUB_PASSWORD\"}" https://hub.docker.com/v2/users/login/ | jq -r .token)
curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/blx-vpp_frontend/tags/?page_size=100 | jq -r '.results|.[]|.name'
==>
eature_ci_scandockerhub-23.01.04-18.05.18
feature_ci_scandockerhub
feature_ci_cd
test_ci3
test_ci2
master
test_ci1
develop
test_secrets
test_merge

DOCKER_PASSWORD
DOCKER_USERNAME
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"${DOCKER_USERNAME}\", \"password\": \"${DOCKER_PASSWORD}\"}" https://hub.docker.com/v2/users/login/ | jq -r .token)
curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/blx-vpp_frontend/tags/?page_size=100 | jq -r '.results|.[]|.name'

use of https://github.com/dhet/scan-docker-tags-action ==> failing in private DH repo : https://github.com/dhet/scan-docker-tags-action/issues/7

WIP : https://gist.github.com/kizbitz/e59f95f7557b4bbb8bf2

VEN 05/01
Nettoyage des images master et develop : garder la dernière sauvegarde des dernières semaine, mois, années

LUN 09/01
Procedure de déploiement d'une image versionnée + préparation du point avec Simon

MAR 10/01
Mise en place environnement production
préparation PR front 

docker save -o .tar boralex/..front..:master

MER 11/01
préparation démo
netoyage des branches front

JEU 12/01
ajout des secrets METEOLOGICA_*
Préparation de mise en prod : test des variables ?
optimisation du déploiement ansible back (limiter les copies)
nettoyage des branche back
mise en prod front
correction TU back

Questions : Power Factor

VEN 13/01
correction create SNAPSHOT front on master
check cron trigger
import login dans back !

toDo : template deployment (yml github workflow)


Péparation entretien Alexandre Debargis <adebargis@microsoft.com>
==>
Questions MS github
- politique : open-source vs Proprietary
- Dev : visual vs code friendly
- learning : MS vs multi-cloud
- cost curve : 
github : free to expensive on enterprise (Higher curve)
Azure : minimal cost to managed cost (slower curve but complex step down)

Ajout de la variable de back.env au secrets

logins à renommer
back.env : nouvelle variable

prefect_login extra logger : nouvelle variable PREFECT__LOGGING__EXTRA_LOGGERS

LUN 16/01
création d'un deploy manuel pour le back (fait par Olivier pour Front)

MAR 17/01
merged PR
ftp to meteologica : passive mode not allowed ==> incompatibilité docker-compose

MER 18/01
documentation sur le versionning d'application (tagging)
procédure et commandes
JEU 19/01
réunion avec Simon pour valider la mise en prod.
Mise en oeuvre du tagging automatique
VEN 20/01
Mise en place du tagging automatique sur boralex/blx-vpp_frontend
ci/tag-rebuild_BRANCH.sh triggered by PR on .github\workflows\PR-tagging.yml

LUN 23/01
Next step = HEX