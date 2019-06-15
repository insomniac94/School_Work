# Ceasars Cipher Decryption
This python script will crack long ceasar cipher encryption and and print out the key for the encrption.

# Prerequites
You must install the pyenchant Python package with the following in line command
```
pip install enchant

```
If that command does not work, try this one
```
pip install --user pyenchant
```

# Code Breakdown
1. We will clear the screen and prompt the user for input
```python
def main():
    os.system('cls')
    decrypted_msg = input("Enter string to decipher: ")
```
2. For each letter in the decrypted message we will first call the caesar() function followed by the print_deciphered_msg() function
```python
    for i in range(len(string.ascii_uppercase)):
        msg = caesar(decrypted_msg, i)
        print_deciphered_msg(msg, i) 
```
3. With the caesar() function, we will rotate each letter by forward (A --> B, B --> C, etc.) and the new character
will be returned to main to run the print_deciphered_msg() function
```python
def caesar(decrypted_msg, number_to_rotate_by):
    upper = collections.deque(string.ascii_uppercase)
    upper.rotate(number_to_rotate_by)
    upper = ''.join(list(upper))
    return decrypted_msg.translate(str.maketrans(string.ascii_uppercase, upper))
```
4.1 This function will read each rotated message to see if the message is a word in the English dictionary. 
This will help so that the output doesn't show every possible rotation. We only want to see the decyrpted message.
```python
def print_deciphered_msg(decrypted_msg, i):
 ```
 4.2 First we want to start by looking at the first (start variable) and second character (end variable). 
 ```python
     start = 0
     end = 2
 ```
 4.3 Then establish that we will be using the English dictionary.
 ```python
    dictionary = enchant.Dict("en_US")
```
4.4 Put the length of the encrypted rotated string into a variable length.
```python
    length = len(decrypted_msg) 
```
4.5 In this while loop, we will interate across the whole string till the full string is an English word. Let's say we have th
decrypted string SDVV 

![alt texthttps://ibb.co/r37YpPR)

```python
while end <= length:
        word_catch = dictionary.check(decrypted_msg[start:end])
        
        if word_catch:
            start = end
            end += 2
        else:
            end += 1
        length -= end

        if end >= length:
            if word_catch:
                print("Deciphered string:",decrypted_msg)
            else:
                break
```
