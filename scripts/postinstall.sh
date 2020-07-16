#!/bin/bash

source /tmp/provisioning/config.sh

echo -e "\nUseful information\n\n"
if [[ -f $OUTPUT_FILE ]]; then
    cat $OUTPUT_FILE
fi

echo -e "\n\nCleaning up ..."
rm -rvf /tmp/provisioning
