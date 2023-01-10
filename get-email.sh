#!/bin/bash

# to keep email adresses out of github use look-up 
# file 'emails.list', and this script to abstract
# out yucky bash

cat emails.list | grep $1 | cut -f 2
