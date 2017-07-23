#!/bin/bash
echo "Hi,"
echo ""
echo "This image is basically just the official Kafka distribution,"
echo "containing both servers and utils, each with its own help output."
echo ""
echo "Select as entrypoint one of these scripts:"
find ./bin/ -name *.sh
echo ""
echo "You might find one of the sample config files useful:"
find ./config/ -name *.properties
echo ""
echo "Add more using volumes, or downstream images."
echo "Enjoy Kafka!"
echo ""
