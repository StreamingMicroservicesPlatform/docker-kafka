#!/bin/bash
echo "Hi,"
echo ""
echo "Select as entrypoint one of these scripts:"
find ./local/bin/* -printf "%f\n"
echo ""
echo "You might find one of the sample config files useful:"
find /etc/ -name *.properties
echo ""
