#!/bin/sh
CURRENT_BRANCH="`git symbolic-ref --short HEAD`"
git add .
git commit -m "`date`"
git push -u origin $CURRENT_BRANCH
git checkout master
git merge $CURRENT_BRANCH
git checkout $CURRENT_BRANCH
