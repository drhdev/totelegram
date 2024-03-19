#!/bin/bash

# Script Information
# Name: totelegram.sh
# Version: 1.0
# Author: drhdev
# Description: This script sends files or file contents to a specified Telegram chat using a bot. It supports sending files as attachments or text content of files as messages. It includes logging capabilities and can be run as a cron job.
# License: GNU Public License
# Installation: Download this script, place it in a desired directory. Make it executable with 'chmod +x totelegram.sh'. Ensure 'curl' is installed on your system.
# Usage: Run './totelgram.sh -file <file_path>' to send a file as an attachment, './totelgram.sh -message <file_path>' to send file content as a message. Use './totelgram.sh -help' for more information. For cron job: '0 2 * * * /path/to/totelgram.sh -file <file_path>' to run daily at 2 am.

# Configuration
TOKEN='YOUR_BOT_TOKEN_HERE'
CHAT_ID='YOUR_CHAT_ID_HERE'
LOG_DIR='/var/log/totelegram'
LOG_FILE="${LOG_DIR}/totelgram.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Function to log message
logMessage() {
    local msg="$1"
    local date_time="$(date '+%Y-%m-%d %H:%M:%S')"
    local hostname="$(hostname)"
    echo "${date_time} | ${hostname} | Chat ID: ${CHAT_ID} | ${msg}" >> "${LOG_FILE}"
}

# Function to send message
sendMessage() {
    local message=$(<"$1") # Read file content
    local response=$(curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$message")
    logMessage "Message sent: $(basename "$1")"
    [[ "$verbose" == true ]] && echo "Message sent: $(basename "$1")"
}

# Function to send file
sendFile() {
    local file="$1"
    local response=$(curl -s -X POST -F chat_id=$CHAT_ID -F document=@"$file" https://api.telegram.org/bot$TOKEN/sendDocument)
    logMessage "File sent: $(basename "$file")"
    [[ "$verbose" == true ]] && echo "File sent: $(basename "$file")"
}

# Function to show help
showHelp() {
    cat << EOF
Usage: $0 -file|-message|-help <file_path> [--verbose]

Options:
  -file <file_path>    Send a file as an attachment.
  -message <file_path> Send the content of a file as a message.
  -help                Display this help and exit.
  --verbose            Show operation responses on the screen.

Log File:
  Logs are written to $LOG_FILE.

EOF
}

# Default to silent mode
verbose=false

# Check arguments
if [[ "$1" == "--verbose" ]]; then
    verbose=true
    shift
fi

if [[ "$#" -lt 2 ]]; then
    showHelp
    exit 1
fi

# Process command line arguments
case "$1" in
    -file)
        if [ ! -f "$2" ]; then
            logMessage "Error: File $2 not found."
            [[ "$verbose" == true ]] && echo "Error: File $2 not found."
            exit 1
        fi
        sendFile "$2"
        ;;
    -message)
        if [ ! -f "$2" ]; then
            logMessage "Error: File $2 not found."
            [[ "$verbose" == true ]] && echo "Error: File $2 not found."
            exit 1
        fi
        sendMessage "$2"
        ;;
    -help)
        showHelp
        ;;
    *)
        logMessage "Invalid option: $1"
        showHelp
        exit 1
        ;;
esac

[[ "$verbose" == true ]] && echo "Operation completed."
