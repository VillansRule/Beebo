#!/bin/bash

# Function to identify Bifid Cipher
identify_bifid_cipher() {
    local encrypted_text=$1

    # Check if the encrypted text contains only uppercase letters
    if [[ $encrypted_text =~ ^[A-Z]+$ ]]; then
        echo "Bifid Cipher"
    fi
}
