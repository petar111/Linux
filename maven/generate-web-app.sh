#!/bin/bash

set -e

CURRENT_DIRECTORY=`pwd`

PROJECT_DIRECTORY=''
GROUP_ID=''
ARTIFACT_ID=''

echo 'Absolute path of the directory where the project will be made:'
read PROJECT_DIRECTORY

echo 'Group id:'
read GROUP_ID

echo 'Artifact id:'
read ARTIFACT_ID

echo 'Java version for project:'
read JAVA_VERSION

echo $PROJECT_DIRECTORY $GROUP_ID $ARTIFACT_ID

if ! [ -d $PROJECT_DIRECTORY ]
then
	mkdir $PROJECT_DIRECTORY
fi

cd $PROJECT_DIRECTORY

mvn archetype:generate -DgroupId=$GROUP_ID -DartifactId=$ARTIFACT_ID -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

#going into project directory
cd ./$ARTIFACT_ID

TEXT_TO_INSERT_IN_POM="<properties>\n\t<project\.build\.sourceEncoding>UTF-8<\/project\.build\.sourceEncoding>\n\t<maven\.compiler\.source>$JAVA_VERSION<\/maven.compiler\.source>\n\t<maven\.compiler\.target>$JAVA_VERSION<\/maven.compiler\.target>\n<\/properties>"

sed -i "/^.*<url>.*<\/url>.*$/a $TEXT_TO_INSERT_IN_POM" pom.xml

PACKAGES=""

#adding packages from groupId
for package in $(echo $GROUP_ID | tr "." "\n")
do
PACKAGES="$PACKAGES$package/"
done

#adding package from artifactId
PACKAGES=$PACKAGES/$ARTIFACT_ID

MAIN_DIRECTORY="src/main/java"
TEST_DIRECTORY="src/test/java"

mkdir -p "$MAIN_DIRECTORY/$PACKAGES"
mkdir -p "$TEST_DIRECTORY/$PACKAGES"

#renaming file to html to prevent errors
mv "src/main/webapp/index.jsp" "src/main/webapp/index.html"

cd ..

cd $CURRENT_DIRECTORY
#grep "^.*<url>.*</url>.*$" pom.xml
#grep -n "^.*<url>.*</url>.*$" pom.xml | awk -F: '{print $1}'
