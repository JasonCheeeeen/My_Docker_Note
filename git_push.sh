#!/bin/bash

echo "git push ..."

git add .
read -p "input the commit message: " message
git commit -m "$message"
git push origin master

echo "git push success!"
