#!/bin/bash -e

source /tmp/provisioning/config.sh

echo -e "\nUseful information\n\n"
if [[ -f $OUTPUT_FILE ]]; then
    cat $OUTPUT_FILE
fi

echo -e "\n\nCleaning up ..."
<<<<<<< HEAD
#rm -rvf /tmp/provisioning
=======
rm -rvf /tmp/provisioning
>>>>>>> 24adab79bb6a6529f85d45bc13bcdbd37ee9c7b2
