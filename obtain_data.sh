#!/bin/bash

# Colors for highlighting messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check for root permissions
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Error: This script must be run as root. Use sudo.${NC}"
    exit 1
fi

# Verify required dependencies
for cmd in nmap dirb smbclient enum4linux; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}Error: $cmd is not installed. Please install it to continue.${NC}"
        exit 1
    fi
done

# Function to validate an IP address
function validate_ip() {
    local ip="$1"
    local regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    # Check the basic format of the IP
    if [[ ! $ip =~ $regex ]]; then
        echo -e "${RED}Error: Invalid IP address format: $ip${NC}"
        exit 1
    fi

    # Split the IP into octets and validate their range (0-255)
    IFS="." read -r -a octets <<< "$ip"
    for octet in "${octets[@]}"; do
        if ((octet < 0 || octet > 255)); then
            echo -e "${RED}Error: Invalid IP address: $ip (octets must be between 0-255).${NC}"
            exit 1
        fi
    done
}

# Check for the correct number of arguments
if [ $# -ne 1 ]; then
    echo -e "${YELLOW}Usage: sudo $0 <ip_address>${NC}"
    exit 1
fi

# Validate the provided IP address
validate_ip "$1"
echo -e "${GREEN}Valid IP address: $1${NC}"

# Run Nmap scan
echo "--------------------------"
echo -e "${CYAN}Running Nmap Scan...${NC}"
echo "--------------------------"
nmap_output=$(sudo nmap -sS -sV -A -O -p- "$1")
echo "$nmap_output"

# Check for HTTP services in the Nmap output
echo "--------------------------"
echo -e "${CYAN}Checking for HTTP Services...${NC}"
echo "--------------------------"
http_ports=$(echo "$nmap_output" | grep -iE "http" | awk '{print $1}' | sed 's/[^0-9]*//g')

if [[ -n "$http_ports" ]]; then
    echo -e "${GREEN}HTTP services detected on the following ports:${NC}"
    echo "$http_ports"
    for port in $http_ports; do
        echo "--------------------------"
        echo -e "${CYAN}Running Dirb on http://$1:$port...${NC}"
        echo "--------------------------"
        dirb "http://$1:$port" -w -r -N 404
    done
else
    echo -e "${YELLOW}No HTTP services detected.${NC}"
fi

# Check for SMB services in the Nmap output
echo "--------------------------"
echo -e "${CYAN}Checking for SMB Services...${NC}"
echo "--------------------------"
smb_ports=$(echo "$nmap_output" | grep -iE "netbios|smb" | awk '{print $1}' | sed 's/[^0-9]*//g')

if [[ -n "$smb_ports" ]]; then
    echo -e "${GREEN}SMB services detected on the following ports:${NC}"
    echo "$smb_ports"
    echo "--------------------------"
    echo -e "${CYAN}Running smbclient on $1...${NC}"
    echo "--------------------------"
    smbclient -L "$1" -N
    echo "--------------------------"
    echo -e "${CYAN}Running enum4linux on $1...${NC}"
    echo "--------------------------"
    enum4linux -a "$1"
else
    echo -e "${YELLOW}No SMB services detected.${NC}"
fi

# Script finished
echo "--------------------------"
echo -e "${GREEN}Script execution completed successfully.${NC}"
echo "--------------------------"
