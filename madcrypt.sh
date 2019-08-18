# madcrypt version 1.0
## variables
###  maddir: initial working directory

clear
maddir=$PWD

## dependency check

sleep 1
echo '[+] dependency check...'
if [ ! which strip > /dev/null 2>&1 ]; then
  sleep 0.5
  echo '[>] binutils missing! exiting...'
  echo
  exit 1
fi
if [ ! which upx > /dev/null 2>&1 ]; then
  sleep 0.5
  echo '[>] upx compressor missing! exiting...'
  echo
  exit 1
fi
if [ ! -f $maddir/bin/madfill.py ]; then
   sleep 0.5
   echo '[!] madfill missing! exiting...' >&2
   echo
   exit 1
fi
if [ ! -f $maddir/bin/sigthief/sigthief.py ]; then
   sleep 0.5
   echo '[!] sigthief missing! exiting...' >&2
   echo
   exit 1
fi
sleep 0.5
echo '[+] done!'
sleep 1

## script
### working variables:
### exePath: path of PE to obfuscate
### signChoice: PE signing boolean

### some ascii
echo "                        _                       _ "
echo "            mado-95's  | |                     | |"
echo "    _ __ ___   __ _  __| | ___ _ __ _   _ _ __ | |_"
echo "   |  _   _ \ / _  |/ _  |/ __|  __| | | | '_ \| __|"
echo "   | | | | | | (_| | (_| | (__| |  | |_| | |_) | |_"
echo "   |_| |_| |_|\__,_|\__,_|\___|_|   \__, | .__/ \__|"
echo "                                     __/ | |"
echo "                                    |___/|_|  v1.0"
echo
sleep 1

### basic configuration
read -p '[-] enter path to pe: ' exePath
if [ ! -f $exePath ]; then
  sleep 0.5
  echo '[!] file doesnt exist! exiting...'
  echo
  exit 1
fi
sleep 0.3
echo '[+] do you want to sign pe?'
sleep 0.3
echo ' - signature will be copied from different'
echo '   executable, and appended onto your pe'
sleep 0.3
echo ' - this is done by sigthief (not my software)'
sleep 0.3
read -p '[-] answer y/n: ' signChoice
sleep 1

### pe obfuscation begins
echo '[+] stripping...'
strip --strip-all $exePath > /dev/null 2>&1
sleep 0.3
echo '[+] pumping...'
python2 $maddir/bin/madfill.py $exePath 3 > /dev/null 2>&1
sleep 0.3
echo '[+] compressing...'
upx --force $exePath > /dev/null 2>&1
sleep 0.3
case $signChoice in
  [Yy]* ) default_signature=$maddir/exes/putty.exe
          read -p '[-] specify signature template: ' signature
          sleep 0.3
          echo '[+] signing...'
          signature="${signature:-${default_signature}}"
          python $maddir/bin/sigthief/sigthief.py -i $signature -t $exePath -o $maddir/tmp.exe > /dev/null 2>&1
          rm -f $exePath && mv $maddir/tmp.exe $exePath
          sleep 0.3;;
  * ) ;;
esac
echo '[-] stripping again...'
strip --strip-all $exePath > /dev/null 2>&1
echo '[-] pumping again...'
python2 $maddir/bin/madfill.py $exePath 3 > /dev/null 2>&1
sleep 0.3
echo '[!] done!'
exit 0
