#!/bin/bash

# Check if python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Please install Python3 to continue."
    exit 1
else
    echo "Python3 is installed."
fi

# Virtual Environment and Requirements Install
rm -rf venv
python3 -m venv venv && source venv/bin/activate && \
pip install -r requirements.txt > /dev/null 2>&1 && \
pip install --upgrade pip > /dev/null 2>&1

# Run Test
python3 selenium-test.py

# Deactivate Environment
deactivate
