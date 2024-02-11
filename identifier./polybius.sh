#!/bin/bash

# Function to identify Polybius Square
identify_polybius_square() {
    local encrypted_text=$1

    # Check if the encrypted text contains only digits and spaces
    if [[ $encrypted_text =~ ^[0-9\ ]+$ ]]; then
        # Check if the encrypted text has a length that is a perfect square
        local text_length=${#encrypted_text}
        local square_root=$(echo "sqrt($text_length)" | bc)
        local square_root_int=${square_root%.*}
        local square_root_square=$((square_root_int * square_root_int))
        if [ $square_root_square -eq $text_length ]; then
            echo "Polybius Square"
        fi
    fi
}
