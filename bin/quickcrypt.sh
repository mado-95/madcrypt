#!/bin/bash
# quickcrypt.sh
# no dependency checks or delays
# arguments from command line
## usage: ./quickcrypt.sh [path to exe] [path to sig template]

cd ..
maddir=$PWD # remove above line and change to folder where madcrypt dependencies are if moving this file
exePath=$1
signature=$2

echo '[+] stripping...'
strip --strip-all $exePath > /dev/null 2>&1
sleep 0.3
echo '[+] pumping...'
python2 $maddir/bin/madfill.py $exePath 3 > /dev/null 2>&1
sleep 0.3
echo '[+] compressing...'
upx --force $exePath > /dev/null 2>&1
sleep 0.3
echo '[+] signing...'
python $maddir/bin/sigthief/sigthief.py -i $signature -t $exePath -o $maddir/tmp.exe > /dev/null 2>&1
rm -f $exePath && mv $maddir/tmp.exe $exePath
sleep 0.3
echo '[-] stripping again...'
strip --strip-all $exePath > /dev/null 2>&1
echo '[-] pumping again...'
python2 $maddir/bin/madfill.py $exePath 3 > /dev/null 2>&1
sleep 0.3
echo '[!] done!'
exit 0
