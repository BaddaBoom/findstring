#!/bin/bash
#
# This will search all files in a supplied directory for either an ascii string,
# or, if the arg "hex" is applied, a hex version of that string. It is a lot
# more efficient than attempting to open each in an editor and do a Ctl-F.
# 
# 

function usage {
	echo -e "USAGE: ${0} <filetype> <input directory> \"<string to match>\" [\"hex\"]\n"
	exit 1
}

function do_test {
	local f=$1
	local n=$2
	test=$(xxd -p $f | tr -d '\n' | grep -c "${n}")
	if [[ $test -eq 1 ]]; then
		echo -n "1"	
		return
	fi
	echo -n "0"
	return
}

echo -e "\n+-------------------------+"
echo -e "|                         |"
echo -e "|   (HEX) STRING FINDER   |"
echo -e "|                         |"
echo -e "+-------------------------+\n"

if [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
	usage
fi

if [ "$#" -ne 3 ] && [ "$#" -ne 4 ]; then
	echo -e "[!] ERROR: arg count wrong. Should be 3 or 4 not $#.\n"
	usage
fi

filetype=$1
indir=$2

if [[ $4 == "hex" ]]; then
	dohex=1
	echo -e "[+] Using hex mode\n"
else
	dohex=0
fi


if [ ! -d $indir ]; then
	echo -e "[!] ERROR: ${indir} is not a directory!\n"
	usage
fi

if [[ ${filetype:0:1} == "." ]]; then
	filetype=${filetype:1:${#filetype}}
fi

if [ $dohex -eq 1 ]; then
	needle=$(echo -n $3|xxd -p)
	echo -e "[+] Searching all .${filetype} files in ${indir} for hex string \"${needle}\"...\n"
else
	needle=$3
	echo -e "[+] Searching all .${filetype} files in ${indir} for string \"${needle}\"...\n"
fi


filelist=$(find $indir -name "*.${filetype}")
c=0
t=0
for f in $filelist; do
	if [ $dohex -eq 1 ]; then
		test=$(xxd -p $f | tr -d '\n' | grep -c "${needle}")
	else
		test=$(cat $f | grep -c "${needle}")
	fi
	if [[ $test -eq 1 ]]; then
		echo -e "[-] File: ${f}"
		((c++))
	fi
	((t++))
done

echo -e "\n[+] Found in ${c} files (of ${t} total files)."
echo -e "\n[+] Finished.\n"
