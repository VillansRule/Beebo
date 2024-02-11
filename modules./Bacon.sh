#!/bin/bash

# Function to decrypt using Bacon's Cipher
bacon_decrypt() {
    local encrypted_text=$1
    local decrypted_text=""

    # Define Bacon's cipher alphabet
    local bacon_alphabet="abcdefghijklmnopqrstuvwxyz"

    # Convert encrypted text to lowercase
    encrypted_text=$(echo "$encrypted_text" | tr '[:upper:]' '[:lower:]')

    # Iterate through the encrypted text
    while [ -n "$encrypted_text" ]; do
        # Extract the first 5 characters
        group="${encrypted_text:0:5}"
        encrypted_text="${encrypted_text:5}"

        # Decode the group using Bacon's cipher alphabet
        decoded_char=""
        for ((i=0; i<5; i++)); do
            case "${group:$i:1}" in
                a) decoded_char+="a" ;;
                b) decoded_char+="b" ;;
            esac
        done

        # Convert the decoded group to the corresponding plaintext character
        decrypted_text+="${bacon_alphabet%$decoded_char*}"
    done

    echo "$decrypted_text"
}

# Main script
echo "Bacon's Cipher Decryption"
read -p "Enter encrypted text: " encrypted_text

decrypted_text=$(bacon_decrypt "$encrypted_text")

echo "Decrypted text: $decrypted_text"
