# You must install enchant for python before this script will work

import string
import collections
import enchant

def caesar(decrypted_msg, number_to_rotate_by):
    upper = collections.deque(string.ascii_uppercase)
    upper.rotate(number_to_rotate_by)
    upper = ''.join(list(upper))
    return decrypted_msg.translate(str.maketrans(string.ascii_uppercase, upper))

def get_key_for_cipher(rotation_num):
    alphabet = collections.deque(string.ascii_uppercase)
    alphabet.rotate(rotation_num)
    print("Key:",alphabet,"\n")
    

def letter_counter(find_top_four_letters):
    print("Top four letters for the string '",find_top_four_letters,"'are:")
    count = 0
    while count < 4:
        print(collections.Counter(find_top_four_letters).most_common(count+1)[count])
        count += 1

def print_deciphered_msg(decrypted_msg, i):
    start = 0
    end = 2
    dictionary = enchant.Dict("en_US")
    length = len(decrypted_msg)

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

def main():
    decrypted_msg = input("Enter string to decipher: ")
    for i in range(len(string.ascii_uppercase)):
        msg = caesar(decrypted_msg, i)
        print_deciphered_msg(msg, i) 
        
    print("\n")
    get_key_for_cipher(8)

    msg = 'MKLAJZHAIUQWKHJABZNXBVHAGKFASDFGALQPIWRYIOQYWIERMASVZMNBZXCKJASDFGLKJFHWQERYIOQWTYIOASUDYFLASKJDHFZMZVBCXMVQLWERYIQRASDFQIWUERYIHKMFMAKHLSDFYUIOQWYREIORYIWQEUFHAKDFHLKASHFKVBBBNASMDFSADFWQEUYRUUEYRUUUQKASJHFKJDSHFSNBNBNBNBABABAAASKJFHLKJSADHFIDUASFOYDASIYFQWERBQWBRKLJLKASSADFDFDASDA'
    letter_counter(msg)

if __name__ == '__main__':
    main()