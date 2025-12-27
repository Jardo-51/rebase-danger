#! /bin/sh

set -e

# Create base repo

mkdir -p target/base-repo
cd target/base-repo/
git init --bare

# Create Alice's clone

cd ../
git clone base-repo/ clone-alice
cd clone-alice/
git config user.name Alice
git config user.email alice@example.com

# Alice does some initial work

echo "Apple" >> a-fruits.txt
echo "Apricot" >> a-fruits.txt
echo "Acerola" >> a-fruits.txt

echo "Asparagus" >> a-vegetables.txt
echo "Artichoke" >> a-vegetables.txt
echo "Arugula" >> a-vegetables.txt

git add a-fruits.txt
git add a-vegetables.txt
git commit -m "Initial commit"
git push

# Now alice starts working on in a feature branch

git switch -c feature/b
git push --set-upstream origin feature/b

echo "Banana" >> b-fruits.txt
echo "Blueberry" >> b-fruits.txt
echo "Blackberry" >> b-fruits.txt

echo "Broccoli" >> b-vegetables.txt
echo "Beetroot" >> b-vegetables.txt
echo "Bell pepper" >> b-vegetables.txt

git add b-fruits.txt
git add b-vegetables.txt
git commit -m "Add fruits and vegetables for B"
git push

# Create Bob's clone

cd ../
git clone base-repo/ clone-bob
cd clone-bob/
git config user.name Bob
git config user.email bob@example.com

git switch -c feature/c

# Bob adds fruits G and H (I is work in progress)

echo "Cherry" >> c-fruits.txt
echo "Coconut" >> c-fruits.txt

git add c-fruits.txt
git commit -m "Add fruits for C"
git push --set-upstream origin feature/c

# Create Carl's clone (he will help Bob with his branch, he will do vegetables for C)

cd ../
git clone base-repo/ clone-carl
cd clone-carl/
git config user.name Carl
git config user.email carl@example.com

git switch feature/c

# Carl adds vegetables for C

echo "Carrot" >> c-vegetables.txt
echo "Cauliflower" >> c-vegetables.txt
echo "Cucumber" >> c-vegetables.txt

git add c-vegetables.txt
git commit -m "Add vegetables for C"
git push
