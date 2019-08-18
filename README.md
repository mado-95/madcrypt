# madcrypt v1.0

A script that strips/compresses/signs any portable executable in an effort to lower antivirus detection ratio.

## usage

```
git clone https://github.com/mado-95/madcrypt
cd madcrypt
bash madcrypt.sh
```

## requirements

- bash
- python2
- UPX compressor
- GNU/Strip

All binaries must be in PATH and executable. This script was designed/tested on Debian 10. Other operating systems should work as long as they have the above packages but there will be no support for errors on non-Debian platforms.

## quickcrypt

In ```madcrypt/bin```,  you'll find the ```quickcrypt.sh``` file. This script contains the full functionality of ```madcrypt```, but is faster and takes arguments from command line.

Example usage:
```
bash madcrypt.sh /root/malware.exe /root/Downloads/template.exe
```
This will obfuscate the ```/root/malware.exe``` and sign it using ```/root/Downloads/putty.exe```

Please note the script is designed to function located in ```madcrypt/bin``` only and if you're moving it elsewhere you'll have to change the paths to ```madfill.py``` and ```sigthief.py```.
