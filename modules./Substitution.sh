#!/bin/bash

# Function to decrypt using Polyalphabetic Cipher with a given key
polyalphabetic_decrypt_with_key() {
    local encrypted_text=$1
    local key=$2
    local decrypted_text=""

    local key_length=${#key}
    local key_index=0

    for (( i=0; i<${#encrypted_text}; i++ )); do
        char="${encrypted_text:$i:1}"
        case $char in
            [A-Za-z])
                shift=$(printf '%d' "'${key:$key_index:1}")
                if [ "$char" == "${char^^}" ]; then
                    ascii_val=$(( ( (printf "%d" "'$char") - 65 - $shift + 26 ) % 26 + 65 ))
                else
                    ascii_val=$(( ( (printf "%d" "'$char") - 97 - $shift + 26 ) % 26 + 97 ))
                fi
                decrypted_text+="$(printf \\$(printf '%03o' "$ascii_val"))"
                key_index=$(( (key_index + 1) % key_length ))
                ;;
            *)
                decrypted_text+="$char"
                ;;
        esac
    done

    echo "$decrypted_text"
}

# Function to brute force decrypt using Polyalphabetic Cipher
polyalphabetic_bruteforce() {
    local encrypted_text=$1
    local decrypted_texts=()

    for (( k=1; k<=26; k++ )); do
        key=""
        for (( j=0; j<$k; j++ )); do
            key+="$(printf "\\$(printf %o "$(( ( (j + 1) % 26 ) + 65 ))")")"
        done
        decrypted_text=$(polyalphabetic_decrypt_with_key "$encrypted_text" "$key")
        decrypted_texts+=("$decrypted_text")
    done

    echo "${decrypted_texts[@]}"
}

# Main script
echo "Polyalphabetic Cipher Decryption"

read -p "Enter encrypted text: " encrypted_text
read -p "Do you have the key? (y/n): " has_key

if [ "$has_key" == "y" ]; then
    read -p "Enter the key: " key
    decrypted_text=$(polyalphabetic_decrypt_with_key "$encrypted_text" "$key")
    echo "Decrypted text: $decrypted_text"
elif [ "$has_key" == "n" ]; then
    decrypted_texts=$(polyalphabetic_bruteforce "$encrypted_text")
    echo "Possible Decrypted texts:"
    for text in "${decrypted_texts[@]}"; do
        echo "$text"
    done
else
    echo "Invalid option. Exiting..."
    exit 1
fi
