#! /bin/sh

set -e

# Alice is done with her work, she merges her branch

cd target/clone-alice/
git switch master
git merge feature/fruits-d-to-f
git push

# Bob decides to rebase

cd ../clone-bob/
git switch master
git pull
git switch -
git rebase master || true # expected failre due to conflict

# Bob resolves the conflict and pushes

sed '/^<<<<<<< /d;/^=======/d;/^>>>>>>> /d' fruits.txt > fruits.txt.resolved && mv fruits.txt.resolved fruits.txt
git add fruits.txt
git rebase --continue
git push -f # needs to use force

# Bob finishes his work

echo "Indian fig" >> fruits.txt

git add fruits.txt
git commit -m "Add fruit for I"
git push

# The feature is done, it can be merged

git switch master
git merge feature/fruits-g-to-l
