#!/bin/bash
#--------------------------------------------------------------------+
# Color picker definitions
BLK='\e[30m'; blk='\e[90m'; BBLK='\e[40m'; bblk='\e[100m'
RED='\e[31m'; red='\e[91m'; BRED='\e[41m'; bred='\e[101m'
GRN='\e[32m'; grn='\e[92m'; BGRN='\e[42m'; bgrn='\e[102m'
YLW='\e[33m'; ylw='\e[93m'; BYLW='\e[43m'; bylw='\e[103m'
BLU='\e[34m'; blu='\e[94m'; BBLU='\e[44m'; bblu='\e[104m'
MGN='\e[35m'; mgn='\e[95m'; BMGN='\e[45m'; bmgn='\e[105m'
CYN='\e[36m'; cyn='\e[96m'; BCYN='\e[46m'; bcyn='\e[106m'
WHT='\e[37m'; wht='\e[97m'; BWHT='\e[47m'; bwht='\e[107m'
DEF='\e[0m'; BLD='\e[1m'; CUR='\e[3m'; UND='\e[4m'; COF='\e[?25l'; CON='\e[?25h'
#--------------------------------------------------------------------+

# Function to position text in the terminal
XY() {
    printf "\e[$2;${1}H$3"
}

# Function to display a styled header
display_header() {
    local header_text=$1
    local line="======="

    # Top border
    XY 1 1 "${BLD}${GRN}${line}${DEF}"

    # Header text
    XY 10 2 "${BLD}${BLU}${header_text}${DEF}"

    # Bottom border
    XY 1 3 "${BLD}${GRN}${line}${DEF}"
}

# Function to display an RGB loading bar
rgb_loading_bar() {
    local pid=$1
    local total_width=30
    local colors=($RED $YLW $GRN $BLU $MGN $CYN)
    local delay=0.1

    XY 1 5 "${BLD}Uploading: ["
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        for color in "${colors[@]}"; do
            printf "${color}#${DEF}"
            sleep $delay
        done
    done
    printf "${BLD}]${DEF}\n"
}

# Function to upload a file
upload_file() {
    local file=$1
    local remote_path=$2

    # Display header for file upload
    display_header "Uploading File"

    # Display file details
    XY 1 4 "${BLD}${BLU}File:${DEF} ${file}"
    XY 1 5 "${BLD}${BLU}Destination:${DEF} ${remote_path}"
    XY 1 6 "${BLD}${GRN}-----------------------------------------------${DEF}"

    # Simulate upload process
    sleep 5 &  # Replace with actual upload command
    local pid=$!

    # Display RGB loading bar while uploading
    rgb_loading_bar $pid

    # Display success message
    XY 1 7 "${BLD}${GRN}✔ Upload Complete!${DEF} File: ${file} -> ${remote_path}"
    XY 1 8 "${BLD}${GRN}===============================================${DEF}"
}

# Function to detect and upload files
detect_and_upload() {
    # Simulated file list
    local files=(
        "index.html"
        "js/app.js"
        "css/styles.css"
    )
    local remote_root="ftps://www.adrianbueno.com/public_html"

    # Display the main script header
    display_header "Script Uploader"

    # Process each file
    for file in "${files[@]}"; do
        local remote_path="${remote_root}/${file}"
        upload_file "${file}" "${remote_path}"
    done
}

# Start the process
detect_and_upload

