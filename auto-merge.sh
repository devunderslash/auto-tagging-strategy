#!/bin/sh
# Automatically merge the last commit through the following branches:
# 2.1 -} 2.2 -} 2.3 -} master

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)

echo Automatically merging commit $LAST_COMMIT from $CURRENT_BRANCH rippling to main

case $CURRENT_BRANCH in

release-1)
  git checkout release-1
  git merge $CURRENT_BRANCH

  git checkout release-2 
  git merge release-1

  git checkout main 
  git merge release-2

<<<<<<< HEAD
  git checkout $CURRENT_BRANCH
  ;;
release-2)
  git checkout release-2 
  git merge release-1

  git checkout main
  git merge release-2
  
=======
  git checkout $CURRENT_BRANCH
  ;;
release-2)
  git checkout release-2 
  git merge release-1

  git checkout main
  git merge release-2
  
  git checkout $CURRENT_BRANCH
  ;;
release-3)
  git checkout main 
  git merge release-3

>>>>>>> release-1
  git checkout $CURRENT_BRANCH
  ;;
release-3)
  git checkout main 
  git merge release-3

  git checkout $CURRENT_BRANCH
  ;;
esac