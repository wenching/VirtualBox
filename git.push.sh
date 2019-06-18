#!/bin/bash

for file in `find . -type f -name '._*' -print`; do echo $file; rm $file; done
for file in `find . -type f -name '.DS_Store' -print`; do echo $file; rm $file; done
for file in `find . -name '.Rhistory' -print`; do echo $file; rm -rf $file; done


echo "### YOU MIGHT WANT TO ADD LARGE FILE(S) AS REPOS SPECIFIC EXCLUSIONS ###"
echo "find * -size +5M >> .gitignore"
echo


echo "### ADD THE LATEST CONTENT TO THE REPOS ###"
git status
echo "--- --- --- --- --- ---"
git add .
echo "--- --- --- --- --- ---"
git status
echo

echo "### ADD A DEFAULT COMMIT WITH TIMESTAMP ###"
timeStamp=$(date)
echo $timeStamp
git commit -m "$timeStamp"
echo

echo "### IF EVERYTHING GOES WELL, THEN PUSH THE COMMIT ###"
echo "git push origin master"
echo

echo "### OR, FIX ANY ERRORS AND STARTS AGAIN ###"
echo "git reset HEAD~"
echo


# https://www.atlassian.com/git/tutorials/syncing/git-pull
<<pull_rebase
A rebase pull does not create the new commit.
Instead, the rebase has copied the remote commits and
appended them to the local origin/master commit history.
pull_rebase
echo "### OR, DISTORY THE HISTORY AND HARD PULL FROM THE REMOTE ###"
echo "git pull --rebase"
echo
