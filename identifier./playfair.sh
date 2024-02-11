#!/bin/bash

# Function to identify Playfair Cipher
identify_playfair_cipher() {
    local encrypted_text=$1

    if [[ $encrypted_text =~ ^[A-Za-z]{2}([A-Za-z]{2}[A-Za-z]{2})+$ ]]; then
        echo "Playfair Cipher"
    fi
}
