#!/bin/bash

# Function to decrypt using Caesar Cipher
caesar_decrypt() {
    local encrypted_text=$1
    local shift=$2
    local decrypted_text=""

    for (( i=0; i<${#encrypted_text}; i++ )); do
        char="${encrypted_text:$i:1}"
        case $char in
            [A-Za-z])
                ascii_val=$(printf "%d" "'$char")
                if [ "$char" == "${char^^}" ]; then
                    ascii_val=$(( (ascii_val - 65 - shift + 26) % 26 + 65 ))
                else
                    ascii_val=$(( (ascii_val - 97 - shift + 26) % 26 + 97 ))
                fi
                decrypted_text+="$(printf \\$(printf '%03o' "$ascii_val"))"
                ;;
            *)
                decrypted_text+="$char"
                ;;
        esac
    done

    echo "$decrypted_text"
}

# Main script
echo "Caesar Cipher Decryption"
read -p "Enter encrypted text: " encrypted_text
read -p "Enter shift: " shift

decrypted_text=$(caesar_decrypt "$encrypted_text" "$shift")

echo "Decrypted text: $decrypted_text"
