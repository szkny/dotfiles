#!/bin/sh
CURRENT_BRANCH="`git symbolic-ref --short HEAD`"
git add -A
git commit -m "`date`"
git push -u origin $CURRENT_BRANCH
# git checkout main
# git pull
# git merge $CURRENT_BRANCH
# git push -u origin main
# git checkout $CURRENT_BRANCH
