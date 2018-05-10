#!/bin/sh
git add .
git commit -m "`date`"
git push -u "`git symbolic-ref --short HEAD`"
