#!/usr/bin/env python2.7.15rc1
# =============================================================
# Created By         : Brandon Hough
# Created Date       : 03/07/2019
# Last Modified Date : 03/20/2019 
# =============================================================
'''This python script will implement DES3 and AES encryption
and decryption using the modes ECB, CBC, CFB, OFB, and CTR. 
It will  also be able to test for pattern preservation and 
error propagation.'''
# =============================================================
# Imports
# =============================================================
from Crypto.Cipher import DES3
from Crypto.Cipher import AES
from Crypto import Random
import random
import sys
import os
# =============================================================
# Global Variables - get random numbers for the secret_aes,
# secret_des, key, and IV (initialization vector)
# =============================================================
secret_aes = os.urandom(16)
secret_des = os.urandom(8)
key = ''.join([chr(random.randint(0, 0xFF)) for i in range(16)])
iv_aes  = ''.join([chr(random.randint(0, 0xFF)) for i in range(16)])
iv_des  = ''.join([chr(random.randint(0, 0xFF)) for i in range(8)])
 
def encrypt_using_AES(mode, msg, encrypt_std):
    print('Encrypted Message')
    print('='*24)
     
    if (mode == 'ECB'): 
        aes = AES.new(key, AES.MODE_ECB)
    if (mode == 'CBC'):
        aes = AES.new(key, AES.MODE_CBC, iv_aes)
    if (mode == 'CFB'):
        aes = AES.new(key, AES.MODE_CFB, iv_aes)
    if (mode == 'OFB'):
        aes = AES.new(key, AES.MODE_OFB, iv_aes)
    if (mode == 'CTR'):
        aes = AES.new(key, AES.MODE_CTR, counter=lambda: secret_aes)
 
    encrypted_msg = aes.encrypt(msg)
 
    #print out the hex for each decrypted letter
    for letter in encrypted_msg:
        sys.stdout.write((hex(ord(letter))[2:]))
        sys.stdout.write('h ')
 
    print('\n' + encrypted_msg)
 
    #output to file
    output4 = ''
    output4 = encrypted_msg
    f = open('project3.txt','w')
    f.write(output4 + '\n')
    f.close()
 
    decrypt_using_AES(encrypted_msg, mode, encrypt_std)
    change_hex(encrypted_msg, mode, encrypt_std)
 
def decrypt_using_AES(encrypted_msg, mode, encrypt_std):    
    print('Decrypted Message')
    print('='*24) 
 
    mode = mode.upper()
 
    if (mode == 'ECB'): 
        aes = AES.new(key, AES.MODE_ECB)
    if (mode == 'CBC'):
        aes = AES.new(key, AES.MODE_CBC, iv_aes)
    if (mode == 'CFB'):
        aes = AES.new(key, AES.MODE_CFB, iv_aes)
    if (mode == 'OFB'):
        aes = AES.new(key, AES.MODE_OFB, iv_aes)
    if (mode == 'CTR'):
        aes = AES.new(key, AES.MODE_CTR, counter=lambda: secret_aes)
     
    decrypted_msg = aes.decrypt(encrypted_msg)
 
    #print out the hex for each decrypted letter
    for letter in decrypted_msg:
        sys.stdout.write((hex(ord(letter))[2:]))
        sys.stdout.write('h ')
    print('\n')
    print(decrypted_msg)
 
    #output to file
    output5 = ''
    output5 = decrypted_msg
    f = open('project3.txt','a+')
    f.write(output5 + '\n')
    f.close()
 
def change_hex(encrypted_msg, mode, encrypt_std):
 
    print('\nChanging Random Bit...')
    index_num = len(encrypted_msg)-10
    new_num = random.randint(0,99)
     
    encrypted_list = []
    for letter in encrypted_msg:
        encrypted_list.append((hex(ord(letter))[2:]))
     
    encrypted_list.pop(index_num )
    encrypted_list.insert(index_num ,str(new_num))
 
    print('Encrypted Message')
    print('='*24) 
 
    encrypted_msg = ''
    for l in encrypted_list:
        encrypted_msg = encrypted_msg + l
 
    encrypt_msg = ''
    for m in encrypted_list:
        encrypt_msg = encrypt_msg + ' ' + m + 'h'
    print(encrypt_msg)
 
    #encrypted_msg = encrypted_msg.decode('hex')
    #print('\n' + encrypted_msg)
 
    output3 = ''
    output3 = encrypted_msg
    f = open('project3.txt','a+')
    f.write(output3 + '\n')
    f.close()
 
    if(encrypt_std == 'DES3'):
        decrypt_using_DES3(encrypted_msg, mode, encrypt_std)
 
    if(encrypt_std == 'AES'):
        decrypt_using_AES(encrypted_msg, mode, encrypt_std)
 
def encrypt_using_DES3(mode, msg, encrypt_std):
    #key = 'thisismykeyhomie'
    iv = Random.new().read(DES3.block_size)
    mode = mode.upper()
 
    if (mode == 'ECB'): 
        des = DES3.new(key, DES3.MODE_ECB)
    if (mode == 'CBC'):
        des = DES3.new(key, DES3.MODE_CBC, iv_des)
    if (mode == 'CFB'):
        des = DES3.new(key, DES3.MODE_CFB, iv_des)
    if (mode == 'OFB'):
        des = DES3.new(key, DES3.MODE_OFB, iv_des)
    if (mode == 'CTR'):
        des = DES3.new(key, DES3.MODE_CTR, counter=lambda: secret_des)
 
    encrypted_msg = des.encrypt(msg)
    print('Encrypted Message')
    print('='*24)
     
    #print out the hex for each encrypted letter
    for letter in encrypted_msg:
        sys.stdout.write((hex(ord(letter))[2:]))
        sys.stdout.write('h ')
 
    print('\n' + encrypted_msg)
 
    #output to file
    output = ''
    output = encrypted_msg
    f = open('project3.txt','a+')
    f.write(output + '\n')
    f.close()
     
    decrypt_using_DES3(encrypted_msg, mode, encrypt_std)
    change_hex(encrypted_msg, mode, encrypt_std)
 
def decrypt_using_DES3(encrypted_msg, mode, encrypt_std):
 
    print('\nDecrypted Message')
    print('=' * 24)
 
    if (mode == 'ECB'): 
        des = DES3.new(key, DES3.MODE_ECB)
    if (mode == 'CBC'):
        des = DES3.new(key, DES3.MODE_CBC, iv_des)
    if (mode == 'CFB'):
        des = DES3.new(key, DES3.MODE_CFB, iv_des)
    if (mode == 'OFB'):
        des = DES3.new(key, DES3.MODE_OFB, iv_des)
    if (mode == 'CTR'):
        des = DES3.new(key, DES3.MODE_CTR, counter=lambda: secret_des)
 
    decrypted_msg = des.decrypt(encrypted_msg)
     
    #print out the hex for each decrypted letter
    for letter in decrypted_msg:
        sys.stdout.write((hex(ord(letter))[2:]))
        sys.stdout.write('h ')
    print('\n' + decrypted_msg)
 
    #output to file
    output2 = ''
    output2 = decrypted_msg
    f = open('project3.txt','a+')
    f.write(output2 + '\n')
    f.close()
 
def validate_input_des3(msg):
	if(len(msg) % 8 != 0):
		pad = 8 - len(msg) % 8
		msg = msg + ('0' * pad)
		return msg
        #print('Please enter a block of 8 characters next time!')
        #sys.exit()
 
def validate_input_aes(msg):
	if(len(msg) % 16 != 0):
		pad = 16 - len(msg) % 16
		msg = msg + ('0' * pad)
		return msg
        #print('Please enter a block of 16 characters next time!')
        #sys.exit()
 
def main():
    encrypt_std = raw_input('Would you like to encrypt with AES or DES3? ')
    encrypt_std.upper()
 
    if(encrypt_std == 'AES'):
        mode = raw_input('What algorithm mode would you want to use (ECB, CBC, CFB, OFB, or CTR)? ')
        mode = mode.upper()
        msg = raw_input('Please input text to encrypt (16 characters): ')
        msg = validate_input_aes(msg)
        encrypt_using_AES(mode, msg, encrypt_std)
     
    if(encrypt_std == 'DES3'):
        mode = raw_input('What algorithm mode would you want to use (ECB, CBC, CFB, OFB, or CTR)? ')
        mode = mode.upper()
        msg = raw_input('Please input text to encrypt (8 characters): ')
        validate_input_des3(msg)
        encrypt_using_DES3(mode, msg, encrypt_std)
 
if __name__ == '__main__':
    main()