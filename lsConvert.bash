#!/bin/bash

TMPFILE="tmp_list.tmp"
POS=()

while [[ $# -gt 0  ]] 
do
opt="$1"
case $opt in
	-re|--regex)
		REGEX=1
		INPUT_FILE="$2"
		shift
		shift
		;;
	-js|--json)
		JSON=1
		INPUT_FILE="$2"
		shift
		shift
		;;
	-o|--output)
		OUTPUT_FILE="$2"
		shift
		shift
		;;
	-h|--help)
		HELP=1
		shift
		shift
		;;
	*)    # unknown option
    		POS+=("$1") # save it in an array for later
    		shift
		;;
esac
done

set -- "${POS[@]}" # restore positional parameters
#printf "\nINPUT FILE:\t${INPUT_FILE}\n"
if [[ -n $1 ]]; then echo "ERROR: Invalid option:"; tail -1 "$1"; exit 0; fi

function print_help(){
	printf "\nWe are helpless! read the code\n\n"
	exit 0
}

function check_cmd_params(){
	if [ ! -f $1 ]; then echo "ERROR: File not exists"; exit 0; fi
        if [ "$1" == ""  ]; then echo "ERROR: Missing argument: path to file."; print_help; fi
}


if [[ $HELP ]]; then print_help; fi

## Initialize
check_cmd_params ${INPUT_FILE}
if [ -f $TMPFILE ];then touch ${TMPFILE}; else echo "">$TMPFILE; fi
fnList=$(< ${INPUT_FILE})
echo "$fnList" > $TMPFILE


if [[ $REGEX ]]; then
	sed -i -e 's/^/\|/' $TMPFILE
	sed -i -e '1s/^.//' $TMPFILE
	sed -i -e "s/[\!\@\#\$\%\^\&\(\)-\/\|\.]/\\\&/g" $TMPFILE
	sed -i -e "s/\*/.*/" $TMPFILE
	output=$(cat $TMPFILE)
	output="${output//$'\n'/}"
fi


if [[ $JSON ]]; then
	output='{"files_list": ['
	while read fn; do output+="\"${fn}\",";	done <$TMPFILE
	output=${output::-1}	
	output+=']}'
fi



## Proccess output to a file or print to stdout

if [ $OUTPUT_FILE ]; then
	if [ -f $OUTPUT_FILE ];then touch ${OUTPUT_FILE}; else echo "">$OUTPUT_FILE; fi
	printf "${output}" > $OUTPUT_FILE
else
	printf "${output}\n"
fi

rm $TMPFILE
#EOF
