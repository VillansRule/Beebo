#!/bin/bash

# Function to identify Atbash Cipher
identify_atbash_cipher() {
    local encrypted_text=$1

    # Check if the encrypted text contains only uppercase letters
    if [[ $encrypted_text =~ ^[A-Z]+$ ]]; then
        # Reverse the encrypted text
        local reversed_text=$(echo "$encrypted_text" | rev)
        # Check if the reversed text matches the original encrypted text
        if [[ "$encrypted_text" == $(tr 'A-Z' 'Z-A' <<< "$reversed_text") ]]; then
            echo "Atbash Cipher"
        fi
    fi
}
