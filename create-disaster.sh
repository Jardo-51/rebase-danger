#! /bin/sh

set -e

# Alice is done with her work, she merges her branch

cd target/clone-alice/
git switch master
git merge feature/b
git push

# Bob decides to rebase

cd ../clone-bob/
git switch master
git pull
git switch -
git rebase master
git push -f # needs to use force

# Bob finishes his work

echo "Cranberry" >> c-fruits.txt

git add c-fruits.txt
git commit -m "Add last fruit for C"
git push

# The feature is done, it can be merged

git switch master
git merge feature/c
