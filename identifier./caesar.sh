#!/bin/bash

# Function to identify Caesar Cipher
identify_caesar_cipher() {
    local encrypted_text=$1

    local decrypted_text=""
    local count=0
    local max_count=0

    for (( shift=1; shift<=25; shift++ )); do
        decrypted_text=$(echo "$encrypted_text" | tr "$(printf %${shift}s | tr ' ' '.')" 'A-Z' | tr "$(printf %${shift}s | tr ' ' '.')" 'a-z')
        count=$(echo "$decrypted_text" | grep -ioE '\b(the|and|of|to|in)\b' | wc -l)
        if [ $count -gt $max_count ]; then
            max_count=$count
        fi
    done

    if [ $max_count -gt 1 ]; then
        echo "Caesar Cipher"
    fi
}
