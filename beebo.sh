#!/bin/bash

# Function to identify the cipher type
identify_cipher() {
    local encrypted_text="$1"
    local cipher_type=""

    # Check if there are any identifier scripts available
    if [ -z "$(ls -A ./identifier/*.sh 2>/dev/null)" ]; then
        echo "Error: No identifier scripts found in the directory."
        exit 1
    fi

    # Call the identifier scripts one by one to identify the cipher
    for file in ./identifier/*.sh; do
        if output=$("$file" "$encrypted_text"); then
            cipher_type="$output"
            break
        fi
    done

    if [ -z "$cipher_type" ]; then
        echo "Error: Failed to identify the cipher type."
        exit 1
    fi

    echo "$cipher_type"
}

# Function to decrypt the cipher text
decrypt_cipher() {
    local encrypted_text="$1"
    local cipher_type="$2"
    local decrypted_text=""

    # Check if the identifier returned an error
    if [[ "$cipher_type" == "Error"* ]]; then
        echo "$cipher_type"
        exit 1
    fi

    # Call the corresponding decrypter script based on the identified cipher type
    decrypter_script="./decrypter/${cipher_type,,}.sh"
    if [ -x "$decrypter_script" ]; then
        decrypted_text=$("$decrypter_script" "$encrypted_text")
        if [ $? -ne 0 ]; then
            echo "Error: Failed to decrypt the text using $cipher_type cipher."
            exit 1
        fi
    else
        echo "Error: No decrypter found for $cipher_type."
        exit 1
    fi

    echo "$decrypted_text"
}

# Main script
read -p "Enter the cipher text: " encrypted_text

# Identify the cipher type
cipher_type=$(identify_cipher "$encrypted_text")
echo "Identified cipher type: $cipher_type"

# Decrypt the cipher text
decrypted_text=$(decrypt_cipher "$encrypted_text" "$cipher_type")
echo "Decrypted text: $decrypted_text"

