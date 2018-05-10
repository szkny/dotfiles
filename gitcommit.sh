#!/bin/sh
git add .
git commit -m "`date`"
git push -u origin "`git symbolic-ref --short HEAD`"
