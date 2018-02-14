#!/bin/bash

#SET THE pathWithFiles value below!

# always read a script before executing!
echo "always read your script first! exiting"
exit 0

# the single folder we are going to work with
pathWithFiles=/tmp/testfiles

#iterate over the files in the path(just the supplied path)
for currentFilename in $pathWithFiles/*; do
	#echo $currentFilename

	#get the path
	#get the name
	#get the extension
	#run md5sum on file location
	filename=$(basename "$currentFilename")
	extension="${filename##*.}"
	filename="${filename%.*}"

	# for linux
	md5=`md5sum ${currentFilename} | cut -d ' ' -f 1`
	# for a mac
	# md5=`md5 ${currentFilename} | cut -d ' ' -f 4`
	#echo "Filename ${filename}  extension ${extension} md5sum ${md5}"

	#create new filename
	newFileName=${pathWithFiles}/${md5}.${extension}
	#echo "Current: ${currentFilename} New: ${newFileName}"

	#verify new file doesn't already exist
	if [ -a "$newFileName" ]
	then
		# if current file != new file then delete
		if [ "$currentFilename" != "$newFileName" ]
		then
			echo "$currentFilename is a duplicate, delete it"
			rm $currentFilename
		fi
	else
		# -n no clobber, -i interactive on overwrite (just being cautious)
		echo "Moving: ${currentFilename} ${newFileName}"
		mv -n -i $currentFilename $newFileName
	fi

	
done