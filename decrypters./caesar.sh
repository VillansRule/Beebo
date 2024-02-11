#!/bin/bash

# Function to decrypt Caesar Cipher
decrypt_caesar_cipher() {
    local encrypted_text="$1"
    local shift="$2"

    decrypted_text=$(echo "$encrypted_text" | tr "$(printf %${shift}s | tr ' ' '.')" 'A-Z' | tr "$(printf %${shift}s | tr ' ' '.')" 'a-z')
    echo "Decrypted text: $decrypted_text"
}

# Main script
if [ $# -eq 2 ]; then
    encrypted_text="$1"
    shift="$2"
    decrypt_caesar_cipher "$encrypted_text" "$shift"
else
    echo "Usage: ./caesar_cipher_decrypter.sh <encrypted_text> <shift>"
fi
