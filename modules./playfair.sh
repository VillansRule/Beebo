#!/bin/bash

# Function to decrypt using Playfair Cipher
playfair_decrypt() {
    local encrypted_text=$1
    local key=$2
    local decrypted_text=""
    local -A matrix

    # Function to create the Playfair matrix
    create_matrix() {
        local key=$1
        local key_index=0
        local alphabet="ABCDEFGHIKLMNOPQRSTUVWXYZ"  # No J in Playfair

        # Populate the matrix with the key
        for (( i=0; i<${#key}; i++ )); do
            char="${key:$i:1}"
            if [[ "${matrix[$char]}" == "" ]]; then
                matrix[$char]=$key_index
                key_index=$((key_index + 1))
            fi
        done

        # Fill the rest of the matrix with the remaining alphabet characters
        for (( i=0; i<${#alphabet}; i++ )); do
            char="${alphabet:$i:1}"
            if [[ "${matrix[$char]}" == "" ]]; then
                matrix[$char]=$key_index
                key_index=$((key_index + 1))
            fi
        done
    }

    # Create the Playfair matrix
    create_matrix "$key"

    # Function to decrypt using the Playfair algorithm
    decrypt_char() {
        local char1=$1
        local char2=$2

        local row1=$((matrix["$char1"] / 5))
        local col1=$((matrix["$char1"] % 5))
        local row2=$((matrix["$char2"] / 5))
        local col2=$((matrix["$char2"] % 5))

        if [[ "$row1" -eq "$row2" ]]; then
            local decrypted_char1="${matrix[@]:(($row1 * 5 + ($col1 + 4) % 5)):1}"
            local decrypted_char2="${matrix[@]:(($row2 * 5 + ($col2 + 4) % 5)):1}"
        elif [[ "$col1" -eq "$col2" ]]; then
            local decrypted_char1="${matrix[@]:((($row1 + 4) % 5 * 5 + $col1)):1}"
            local decrypted_char2="${matrix[@]:((($row2 + 4) % 5 * 5 + $col2)):1}"
        else
            local decrypted_char1="${matrix[@]:($row1 * 5 + $col2):1}"
            local decrypted_char2="${matrix[@]:($row2 * 5 + $col1):1}"
        fi

        decrypted_text+="$decrypted_char1$decrypted_char2"
    }

    # Remove spaces and convert to uppercase
    encrypted_text=$(echo "$encrypted_text" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

    # Decrypt using the Playfair algorithm
    for (( i=0; i<${#encrypted_text}; i+=2 )); do
        char1="${encrypted_text:$i:1}"
        char2="${encrypted_text:$((i + 1)):1}"
        decrypt_char "$char1" "$char2"
    done

    echo "$decrypted_text"
}

# Main script
echo "Playfair Cipher Decryption"
read -p "Enter encrypted text: " encrypted_text
read -p "Enter key: " key

decrypted_text=$(playfair_decrypt "$encrypted_text" "$key")

echo "Decrypted text: $decrypted_text"
