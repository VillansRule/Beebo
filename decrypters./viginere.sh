#!/bin/bash

# Function to decrypt Vigenère Cipher
decrypt_vigenere_cipher() {
    local encrypted_text="$1"
    local key="$2"

    local decrypted_text=""
    local key_length=${#key}
    local key_index=0

    for (( i=0; i<${#encrypted_text}; i++ )); do
        char="${encrypted_text:$i:1}"
        if [[ "$char" =~ [A-Za-z] ]]; then
            key_char="${key:$key_index:1}"
            shift=$(ord "$key_char")
            shift=$((shift - 65))
            decrypted_char=$(decrypt_caesar_char "$char" "$shift")
            decrypted_text+="$decrypted_char"
            ((key_index++))
            ((key_index=key_index%key_length))
        else
            decrypted_text+="$char"
        fi
    done

    echo "Decrypted text: $decrypted_text"
}

# Function to decrypt Caesar Character
decrypt_caesar_char() {
    local char="$1"
    local shift="$2"

    if [[ "$char" =~ [A-Za-z] ]]; then
        ascii_val=$(ord "$char")
        ascii_val=$((ascii_val - shift))
        if [[ "$char" =~ [A-Z] && $ascii_val -lt 65 ]]; then
            ascii_val=$((ascii_val + 26))
        elif [[ "$char" =~ [a-z] && $ascii_val -lt 97 ]]; then
            ascii_val=$((ascii_val + 26))
        fi
        decrypted_char=$(chr "$ascii_val")
        echo "$decrypted_char"
    else
        echo "$char"
    fi
}

# Function to convert character to ASCII value
ord() {
    LC_CTYPE=C printf '%d' "'$1"
}

# Function to convert ASCII value to character
chr() {
    [ "$1" -lt 256 ] || return 1
    printf "\\$(printf '%03o' "$1")"
}

# Main script
if [ $# -eq 2 ]; then
    encrypted_text="$1"
    key="$2"
    decrypt_vigenere_cipher "$encrypted_text" "$key"
else
    echo "Usage: ./vigenere_cipher_decrypter.sh <encrypted_text> <key>"
fi
