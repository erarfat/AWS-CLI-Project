#!/bin/bash
###############################################
# This script installs, starts, and put html file in Apache web server on a Linux system.
# It checks if the installation was successful and provides appropriate messages.
###############################################
# Function to install Apache web server
install_apache() {
    echo "Installing Apache web server..."
    if command -v yum &> /dev/null; then
        sudo yum install -y httpd
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y apache2
    else
        echo "Unsupported package manager. Please install Apache manually."
        exit 1
    fi
}
# Function to start Apache web server
start_apache() {
    echo "Starting Apache web server..."
    if command -v systemctl &> /dev/null; then
        sudo systemctl start httpd || sudo systemctl start apache2
        sudo systemctl enable httpd || sudo systemctl enable apache2
    else
        echo "Systemctl not found. Please start Apache manually."
        exit 1
    fi
}
# Function to create a sample HTML file
create_html_file() {
    echo "Creating a sample HTML file..."
    if [ -d /var/www/html ]; then
        echo "<html><body><h1>Apache is successfully installed and running!</h1></body></html>" | sudo tee /var/www/html/index.html
    else
        echo "Web root directory not found. Please create the HTML file manually."
        exit 1
    fi
}
# Function to verify Apache installation
verify_installation() {
    if command -v systemctl &> /dev/null; then
        if systemctl is-active --quiet httpd || systemctl is-active --quiet apache2; then
            echo "Apache web server is running."
            echo "You can access the sample HTML file at http://<your-server-ip>/"
        else
            echo "Apache web server is not running. Please check the service status."
            exit 1
        fi
    else
        echo "Systemctl not found. Please verify Apache installation manually."
        exit 1
    fi
}
# Main script execution
install_apache
start_apache
create_html_file
verify_installation
echo "Apache installation and setup completed successfully."
