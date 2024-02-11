#!/bin/bash

# Function to identify Affine Cipher
identify_affine_cipher() {
    local encrypted_text=$1

    # Check if the length of the encrypted text is compatible with the Affine Cipher
    if (( ${#encrypted_text} % 2 == 0 )); then
        # Check if every character in the encrypted text is a letter
        if [[ $encrypted_text =~ ^[A-Za-z]+$ ]]; then
            # Calculate the greatest common divisor of all character positions differences
            local gcd=$(gcd_of_differences "$encrypted_text")
            # The greatest common divisor for an Affine Cipher should be greater than 1
            if (( gcd > 1 )); then
                echo "Affine Cipher"
                return
            fi
        fi
    fi
}

# Function to calculate the greatest common divisor of all character positions differences
gcd_of_differences() {
    local text=$1
    local diffs=()
    local num_chars=${#text}

    # Calculate the differences between the positions of adjacent characters
    for (( i=0; i<num_chars-1; i++ )); do
        local diff=$(( (ord "${text:i+1:1}") - (ord "${text:i:1}") ))
        diffs+=($diff)
    done

    # Calculate the greatest common divisor of all differences
    local result=${diffs[0]}
    for (( i=1; i<${#diffs[@]}; i++ )); do
        result=$(gcd $result ${diffs[i]})
    done

    echo $result
}
