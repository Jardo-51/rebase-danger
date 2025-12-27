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

# Alice does some initial work

echo "Apple" >> fruits.txt
echo "Bannana" >> fruits.txt
echo "Cherry" >> fruits.txt

git add fruits.txt
git commit -m "Initial commit"
git push

# Now alice starts working on in a feature branch

git switch -c feature/fruits-d-to-f
git push --set-upstream origin feature/fruits-d-to-f

echo "Date" >> fruits.txt
echo "Elderberry" >> fruits.txt
echo "Fig" >> fruits.txt

git add fruits.txt
git commit -m "Add fruits from D to F"
git push

# Create Bob's clone

cd ../
git clone base-repo/ clone-bob
cd clone-bob/
git config user.name Bob
git config user.email bob@example.com

git switch -c feature/fruits-g-to-l
git push --set-upstream origin feature/fruits-g-to-l

# Create Carl's clone (he will help Bob with his branch)

cd ../
git clone base-repo/ clone-carl
cd clone-carl/
git config user.name Carl
git config user.email carl@example.com

git switch feature/fruits-g-to-l

# Bob adds fruits G and H (I is work in progress)

cd ../clone-bob

echo "Grape" >> fruits.txt
echo "Honeydew" >> fruits.txt

git add fruits.txt
git commit -m "Add fruits G and H"
git push

# Carl adds fruits from J to L

cd ../clone-carl

echo "Jackfruit" >> fruits.txt
echo "Kiwi" >> fruits.txt
echo "Lemon" >> fruits.txt

git add fruits.txt
git commit -m "Add fruits from J to L"
# no push yet
