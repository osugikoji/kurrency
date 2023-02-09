#!/bin/bash
echo “Running pre-commit hook”
echo “- Build KMM Swift Package -”
./gradlew shared:createSwiftPackage
if [ $? -ne 0 ]; then
 echo “Swift Package building failed.”
 exit 1
fi