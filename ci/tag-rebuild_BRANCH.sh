#!/bin/bash
echo "tag-rebuild_BRANCH.sh"
# JFO 19/01/2022
# create new tag for build branch and rename odd tags to be lower than this new one
# ######################
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ ! -z "$1" ] && [ "$1" != "${BRANCH}" ]
then
    echo "move to branch $1"
    git checkout $1
    if [ ! $? -eq 0 ]
    then
        echo "#ERROR ${BRANCH} not available !"
        exit 1
    else
        git pull
        BRANCH=$1
    fi
fi
echo "# create new tag on ${BRANCH}"
if [ -z "${BRANCH}" ]; then echo s"#ERROR ! BRANCH name not found !"; exit 1; fi
# 1 : 1-	Get max SemVer versionpresent on my branch
echo "get last version"
VERSION=$(git tag --sort=version:refname --merged ${BRANCH} v* | tail -1 | sed "s/\(v[0-9\.]*\).*/\1/")
if [ -z "${VERSION}" ]
then
    echo "# no version found !"
    echo "List of all tags on this branch :"
    git tag --sort=version:refname --merged ${BRANCH}
    echo "init VERSION to v0.0.0"
    VERSION=v0.0.0
fi
LAST_SEMVER=$(git tag --sort=version:refname --merged ${BRANCH} ${VERSION}-${BRANCH^^}* | tail -1)
echo "LAST_SEMVER=${LAST_SEMVER}"
# 3 - determine Build numbers
# 3.1 last one
V_BRANCH=$(git tag --merged ${BRANCH} ${VERSION}-${BRANCH^^}* | sed "s/${VERSION}-${BRANCH^^}\(\.[0-9]*\).*/\1/"  | grep -e "^\.[0-9]*$" | sed "s/\.//" | sort -n | tail -1)
# 3.2 next one
# V_BRANCH and NEW_V_BRANCH should stay empty if no tag available (empty LAST_SEMVER)
NEW_V_BRANCH=""
if [ ! -z "${LAST_SEMVER}" ]
then
    echo "Last ${VERSION}-${BRANCH^^} tag is ${LAST_SEMVER}"
    # calculate new Build number
    if [ -z "${V_BRANCH}" ]
    then 
        # exist a version-${BRANCH^^} (without build number) ==> next build number is 2
        V_BRANCH=.1
    else
        # increment version and add . before to concatenate to ${VERSION}-${BRANCH^^}
        V_BRANCH=.$(expr ${V_BRANCH} + 1)
    fi
    # should create higher semver to leave place for odd branches renaming
    NEW_V_BRANCH=.$(expr ${V_BRANCH//./} + 1)
fi
# 4- create new tag 
echo "create tag ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}"
git tag ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}
# 5 - eventually rename odd tags
LAST_SEMVER=$(git tag --sort=version:refname --merged ${BRANCH} ${VERSION}-${BRANCH^^}* | tail -1)
SUFFIX=""
while [ "${LAST_SEMVER}" != "${VERSION}-${BRANCH^^}${NEW_V_BRANCH}" ]
do
    # add the odd suffix to new version V_BRANCH
    SUFFIX=${LAST_SEMVER/${VERSION}-${BRANCH^^}/}
    TAG_RENAMED=${VERSION}-${BRANCH^^}${V_BRANCH}-renamed-${SUFFIX}
    echo "SUFFIX is ${SUFFIX}"
    echo "- rename ${LAST_SEMVER} to ${TAG_RENAMED}"
    git tag ${TAG_RENAMED} ${LAST_SEMVER}
    git tag -d ${LAST_SEMVER}
    git push origin ${TAG_RENAMED} :${LAST_SEMVER}
    # check last semantic version
    LAST_SEMVER=$(git tag --sort=version:refname --merged ${BRANCH} ${VERSION}-${BRANCH^^}* | tail -1)
    echo "- check ${LAST_SEMVER} != ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}"
done
# 6 - decrement tag if no rename done
if [ -z "${SUFFIX}" ] && [ ! -z "${NEW_V_BRANCH}" ]
then
    echo "rename tag ${VERSION}-${BRANCH^^}${NEW_V_BRANCH} to ${VERSION}-${BRANCH^^}${V_BRANCH}"
    git tag ${VERSION}-${BRANCH^^}${V_BRANCH} ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}
    git tag -d ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}
    NEW_V_BRANCH=${V_BRANCH}
fi
# 7 - publish new build tag
echo "*** push origin ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}"
git push origin ${VERSION}-${BRANCH^^}${NEW_V_BRANCH}