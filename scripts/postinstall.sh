#!/bin/bash

source /tmp/provisioning/config.sh

echo -e "Useful information\n\n"
cat $OUTPUT_FILE

echo -e "\n\nCleaning up ..."
rm -rvf /tmp/provisioning