#!/bin/bash

# Function to validate disk space
check_disk_space() {
    THRESHOLD=1024 # Minimum free space in MB
    FREE_SPACE=$(df / | awk 'NR==2 {print $4}') # Get free space in KB

    if (( FREE_SPACE < THRESHOLD * 1024 )); then
        echo "Error: Not enough disk space. Minimum ${THRESHOLD}MB required."
        exit 1
    else
        echo "Disk space check passed: $(($FREE_SPACE / 1024)) MB available."
    fi
}

# Function to validate memory
check_memory() {
    MIN_MEMORY=2048 # Minimum memory in MB
    FREE_MEMORY=$(free -m | awk '/^Mem:/ { print $7 }') # Get available memory in MB

    if (( FREE_MEMORY < MIN_MEMORY )); then
        echo "Error: Not enough memory. Minimum ${MIN_MEMORY}MB required."
        exit 1
    else
        echo "Memory check passed: ${FREE_MEMORY} MB available."
    fi
}

# Function to check required environment variables
check_env_variables() {
    REQUIRED_VARS=("API_KEY" "DB_HOST" "DB_PORT")
    for VAR in "${REQUIRED_VARS[@]}"; do
        if [[ -z "${!VAR}" ]]; then
            echo "Error: Environment variable $VAR is not set."
            exit 1
        else
            echo "Environment variable $VAR is set."
        fi
    done
}

# Function to validate access to an external service
check_service_access() {
    SERVICE_HOST="api.example.com"
    if ! ping -c 1 "$SERVICE_HOST" &>/dev/null; then
        echo "Error: Unable to reach $SERVICE_HOST. Check your network or /etc/hosts configuration."
        exit 1
    else
        echo "Access to $SERVICE_HOST validated."
    fi
}

# Main script execution
echo "Validating system prerequisites..."
check_disk_space
check_memory
check_env_variables
check_service_access

echo "All checks passed. System is ready."
