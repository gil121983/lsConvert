# lsConvert

usage: ./lsConv [-f | --file <path>] [-d | --directory <path>] 
		[-r | --recursive] [-re | --regex] [-js | --json]
		[-o | --output <path>]
		[-h | --help] 

Converts a list of files from a directory or a text file to a chosen format

  -d, --directory	converts files from selected folder, -d <path>
  -f, --file		converts files listed in a file, -f <path> 
  			  (supports * wildcard)
  -js, --json		converts list to json format 
  -o, --output-file	prints converted list to a file, -o <path>	
  -r, --recursive	with -d, list all files in sub-folders
  -re, --regex		converts list to regex
  -h, --help		display this help and exit
  -v, --version  	output version information and exit

