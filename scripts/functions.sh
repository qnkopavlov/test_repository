#!/bin/bash
function get_binary {
   name=$1
   url=$2
   bin_dir="$3"

   if [[ ! -d $bin_dir ]]; then
       mkdir -p $bin_dir
       export PATH="${PATH}:${bin_dir}"
   fi

   curl -Lo ${bin_dir}/${name} $url
   chmod 755 ${bin_dir}/${name}
   sleep 3
}

function download {
    url="$1"
    filename="$2"

    wget --no-directories --quiet --output-document $filename $url
    retval=$?

    if [[ $retval -ne 0 ]]; then
        echo "Downloading $file from $url has failed"
        exit $retval
    fi

}
