#!/bin/bash

# Function to identify Transposition Cipher
identify_transposition_cipher() {
    local encrypted_text=$1

    local num_columns=${#encrypted_text}
    local num_rows=$(( (num_columns + 1) / 2 ))

    for (( key=2; key<=num_rows; key++ )); do
        decrypted_text=$(./transposition_decrypt.sh "$encrypted_text" "$key")
        if [[ "$decrypted_text" =~ [A-Za-z]{2,} ]]; then
            echo "Transposition Cipher"
            return
        fi
    done
}
