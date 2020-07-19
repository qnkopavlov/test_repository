#!/bin/bash
function download {
    url="$1"
    filename="$2"

    echo "Downloading $url into $filename"
    wget --no-directories --quiet --output-document $filename $url
    retval=$?

    if [[ $retval -ne 0 ]]; then
        echo "Downloading $file from $url has failed"
        exit $retval
    fi
    echo "Download finished successfully"
}

function get_binary {
   name="$1"
   url="$2"
   bin_dir="$3"

   #For some reason binaries cannot be found in $PATH
   #after being downloaded into /usr/local/bin
   #Use absolute paths !!!!
   if [[ ! -d $bin_dir ]]; then
       mkdir -p $bin_dir
       export PATH="${PATH}:${bin_dir}"
   fi

   download $url "${bin_dir}/${name}"
   chmod 755 ${bin_dir}/${name}
   sleep 1
}

function get_jenkins_crumb {
    url="$1"
    user="$2"
    pass="$3"

    return_data=$(curl ${url}/crumbIssuer/api/json --user ${user}:${pass})
    crumb=$(echo $return_data | \
    python -c "import sys, json; print(json.load(sys.stdin)['crumb'])")

    echo $crumb
}