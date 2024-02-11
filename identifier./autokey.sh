#!/bin/bash

# Function to identify Autokey Cipher
identify_autokey_cipher() {
    local encrypted_text=$1

    # Check if the encrypted text contains only uppercase letters
    if [[ $encrypted_text =~ ^[A-Z]+$ ]]; then
        # Check if the second letter of the encrypted text is repeated throughout
        local second_letter="${encrypted_text:1:1}"
        if [[ $(tr -d "$second_letter" <<< "$encrypted_text") == "" ]]; then
            echo "Autokey Cipher"
        fi
    fi
}
