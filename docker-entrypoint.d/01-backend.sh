#!/bin/bash

java --version

if [ -f "/usr/share/backend.java" ]; then
    echo "Found backend file"
    termination(){
        kill -SIGINT $PID_SERVER
        exit 0
    }

    trap 'termination' SIGTERM

    java -jar /usr/share/backend.java &
    PID_SERVER=$!

    exec "$@"
else
    echo "Could not find backend in /usr/share/backend.java"
    echo "Skipping.."
fi
