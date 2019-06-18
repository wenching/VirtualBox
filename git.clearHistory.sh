#!/bin/bash

for file in `find . -type f -name '._*' -print`; do echo $file; rm $file; done
for file in `find . -type f -name '.DS_Store' -print`; do echo $file; rm $file; done
for file in `find . -name '.Rhistory' -print`; do echo $file; rm -rf $file; done

# https://gist.github.com/stephenhardy/5470814

echo "### REMOVE THE HISTORY ###"
rm -rf .git
echo

echo "### RECREATE THE REPOS FROM THE CURRENT CONTENT ONLY ###"
echo "[WARNING] 'git init' WILL DESTROY YOUR REPOSITORY!"
git init
echo


echo "### ADD THE LATEST CONTENT TO THE REPOS ###"
git status
git add .
git status
echo

echo "### ADD INTIAL COMMIT ###"
timeStamp=$(date)
echo $timeStamp
git commit -m "$timeStamp: Initial commit"
echo

repos=${PWD##*/}
echo "### PUSH TO THE GITHUB REMOTE REPOS (${repos}) ENSURING YOU OVERWRITE HISTORY ###"
res="$(git remote add origin git@github.com:wenching/${repos}.git)"
git push -u --force origin master
echo
