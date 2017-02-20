# $1 is the source directory
# $2 is the target directory

pattern='\.[a-z0-9]+$' # matches filenames with a file extension

# for each file with a file extension
find $1 -type f | grep -Ei $pattern | while read f
do
    # extract the extension of the file
    extension=$(echo $f | grep -Eio $pattern | cut -c2-)

    # create a sub-folder with the name of the extension in the target directory
    mkdir -p "$2$extension"
    
    # copy the file to its corresponding sub-folder in the target directory
    cp "$f" "$2$extension"
    # alternatively a symbolic link can be created or the file can be moved
done
