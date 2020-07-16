#!/bin/bash

source /tmp/provisioning/config.sh

echo "Cleaning up ..."
rm -rf /tmp/provisioning

echo -e "Useful information\n\n"
cat $OUTPUT_FILE