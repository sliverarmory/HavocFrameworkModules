#!/bin/bash

HOME=$(pwd)
BOFDIR=$1

echo "[+] Changing directory: $BOFDIR"
cd $BOFDIR
echo "[+] Compiling:"
rm bin/*.o
make

echo "[+] Creating artifact:"
mkdir artifacts
mv bin/*.o ./artifacts/
VERSION=$(git describe --tags --abbrev=0)
cat extension.json | jq ".version |= \"$VERSION\"" > ./artifacts/extension.json
cd artifacts 

echo "[+] Creating package:"
MANIFEST=$(cat extension.json | base64 -w 0)
COMMAND_NAME=$(cat extension.json | jq -r .command_name)
echo "[+] executing: tar -czvf $HOME/packages/$COMMAND_NAME.tar.gz ."
tar -czvf $HOME/packages/$COMMAND_NAME.tar.gz .
cd $HOME/packages
echo
pwd
ls -l

echo "[+] Signing package:"
bash -c "echo \"\" | /home/runner/minisign -s /home/runner/minisign.key -S -m ./$COMMAND_NAME.tar.gz -t \"$MANIFEST\" -x $COMMAND_NAME.minisig"