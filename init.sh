#!/bin/bash

# Function to handle Python environment setup and test
python_setup() {
    cd python-example

    echo "Checking Python installation..."

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
}

# Function to handle Node.js setup and start
node_setup() {
    cd node-example

    echo "Checking Node.js installation..."

    # Check if node is installed
    if ! command -v node &> /dev/null; then
        echo "Node.js is not installed. Please install Node.js to continue."
        exit 1
    else
        # Display Node.js version
        echo "Node.js is installed. Version: $(node -v)"
    fi

    rm -rf node_modules && npm install && npm start
}

# Display Menu
echo "Select an option:"
echo "1. Python setup and start"
echo "2. Node.js setup and start"
echo "3. Exit"
read -p "Enter your choice: " choice

# Case selection
case $choice in
    1)
        python_setup
        ;;
    2)
        node_setup
        ;;
    3)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice, exiting."
        exit 1
        ;;
esac
