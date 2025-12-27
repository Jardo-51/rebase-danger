#! /bin/sh

set -e

# Alice is finishes with her work and merges to main

cd target/clone-alice/

echo "Blueberry" >> b-fruits.txt
echo "Beetroot" >> b-vegetables.txt

git add b-fruits.txt
git add b-vegetables.txt
git commit -m "Add remaining fruits and vegetables for B"
git push

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

echo "Coconut" >> c-fruits.txt
echo "Cranberry" >> c-fruits.txt

git add c-fruits.txt
git commit -m "Add last fruit for C"
git push

# The feature is done, it can be merged

git switch master
git merge feature/c
