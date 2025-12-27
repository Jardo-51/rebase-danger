#! /bin/sh

set -e

# Alice is done with her work, she merges her branch

cd target/clone-alice/
git switch master
git merge feature/fruits-a-to-c
git push

# Bob decides to rebase and merge

cd ../clone-bob/
git switch master
git pull
git switch -
git rebase master

# TODO: resolve conflict

git push -f # needs to use force

git switch master
git merge feature/fruits-d-to-i
