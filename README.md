# Beebo
# Cipher Decrypter

This Bash script allows you to decrypt encrypted text using different cipher techniques such as Caesar cipher, Substitution cipher, and Vigenere cipher.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/VillansRule/Beebo.git
    ```

2. Navigate to the directory containing the script:

    ```bash
    cd cipher-decrypter
    ```

3. Run the script:

    ```bash
    ./beebo.sh
    ```

4. Enter the encrypted text when prompted.

## Directory Structure

- `beebo.sh`: Main script that identifies the cipher type and decrypts the text.
- `decrypters/`: Directory containing decrypter scripts for different cipher types.
- `identifier/`: Directory containing scripts to identify the cipher type.

## Dependencies

- Bash shell environment.

## Examples

Here's an example of how to use the script:

```bash
Enter the cipher text: svool dliow
Identified cipher type: Caesar
Decrypted text: hello world
