#!/bin/bash
. run-ccnx-common.sh
echo init keystores
for i in 0 
do
    install_ccnd_keystore $i
    install_user_keystore $i
    mkdir -p files-$i/tmp
done
i=2
echo 1 >files-0/tmp/100
while [ $i -le 100 ]; do echo $i >>files-0/tmp/100; i=$((i+1)); done
echo setting test file
cp README files-0/tmp
EXE=dce-ccnd-short-stuff
if [ "" == "$GDB" ]
then
    $NS3_BIN/$EXE 2>&1 | tee -a output.txt
else
    $GDB $NS3_BIN/$EXE
fi
emacs output.txt  files-*/var/log/*/* &

