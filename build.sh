#!/bin/sh

echo "Cleaning existing classes..."
rm -rf src/main/java/build
mkdir -p src/main/java/build

echo "Compiling source code and unit tests..."
javac -d src/main/java/build -cp .:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar src/main/java/*.java src/test/java/*.java
if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi

echo "Running unit tests..."
java -cp src/main/java/build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore EdgeConnectorTest
if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

echo "Running application..."
java -cp src/main/java/build RunEdgeConvert
