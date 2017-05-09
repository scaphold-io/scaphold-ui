# /usr/bin/bash
set -e

echo 'Temporarily ignoring package.json'

echo 'Stashing git'
git stash

echo 'Patching full package.json'
npm version patch
mv package.json package.json.tmp

echo 'Swapping package.json'
mv package.npm.json package.json

echo 'Stashing git'
git stash

echo 'Patching swapped package.json'
npm version patch

echo 'Publishing to NPM'
npm publish

echo 'Unstashing git'
git stash drop
git stash drop

echo 'Swapping back package.json'
mv package.json package.npm.json
mv package.json.tmp package.json

echo 'Removing temp .npmignore'
cp .gitignore .gitignore.tmp
head -n -3 .gitignore.tmp > .gitignore
rm -f .gitignore.tmp