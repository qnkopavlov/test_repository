#!/bin/bash

trap "echo 'CANT KILL MEEE !!!!'" INT

while True; do
    echo "Hello World !!!"
    sleep 1
done
