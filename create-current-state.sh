#! /bin/sh

set -e

# Create base repo

mkdir -p target/base-repo
cd target/base-repo/

git init --bare
git config user.name Someone
git config user.email someone@example.com

# Create Alice's clone

cd ../
git clone base-repo/ clone-alice
cd clone-alice/
git config user.name Alice
git config user.email alice@example.com

# Alice creates initial project skeleton

echo "A:" >> fruits.txt
echo "B:" >> fruits.txt
echo "C:" >> fruits.txt
echo "D:" >> fruits.txt
echo "E:" >> fruits.txt
echo "F:" >> fruits.txt
echo "G:" >> fruits.txt
echo "H:" >> fruits.txt
echo "I:" >> fruits.txt

git add fruits.txt
git commit -m "Initial commit"
git push

# Now Alice starts working on in a feature branch

git switch -c feature/fruits-a-to-c
git push --set-upstream origin feature/fruits-a-to-c

sed -i 's/^A:$/A: Apple/' fruits.txt
sed -i 's/^B:$/B: Bannana/' fruits.txt
sed -i 's/^C:$/C: Cherry/' fruits.txt

git add fruits.txt
git commit -m "Add fruits from A to C"
git push

# Create Bob's clone

cd ../
git clone base-repo/ clone-bob
cd clone-bob/
git config user.name Bob
git config user.email bob@example.com

git switch -c feature/fruits-d-to-i

# Bob adds fruits D and E (F is work in progress)

sed -i 's/^D:$/D: Date/' fruits.txt
sed -i 's/^E:$/E: Elderberry/' fruits.txt

git add fruits.txt
git commit -m "Add fruits D and E"
git push --set-upstream origin feature/fruits-d-to-i

# Create Carl's clone (he will help Bob with his branch)

cd ../
git clone base-repo/ clone-carl
cd clone-carl/
git config user.name Carl
git config user.email carl@example.com

git switch feature/fruits-d-to-i

sed -i 's/^G:$/G: Grape/' fruits.txt
sed -i 's/^H:$/H: Honeydew/' fruits.txt
sed -i 's/^I:$/I: Indian fig/' fruits.txt

git add fruits.txt
git commit -m "Add fruits from G to I"
git push
