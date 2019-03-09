#!/usr/bin/env python3
# =============================================================
# Created By  : Brandon Hough
# Created Date: 03/07/2019
# =============================================================
"""This python script will implement DES3 and AES256 
encryption and decryption"""
# =============================================================
# Imports
# =============================================================
from Crypto.Cipher import DES3
from Crypto.Cipher import AES
from Crypto import Random
import base64
import random

def encrypt_using_DES3(plaintext):
	key = 'thisismykeyhomie'
	iv= Random.new().read(DES3.block_size)
	cipher_encrypt = DES3.new(key, DES3.MODE_OFB, iv)
	encrypted_msg = cipher_encrypt.encrypt(plaintext)
	print "Encrypted Message (DES3)"
	print "="*24
	print encrypted_msg
	decrypt_using_DES3(encrypted_msg,iv,key)

def decrypt_using_DES3(encypted_msg,iv,key):
	print "Decrypted Message (DES3)"
	print "="*24
	cipher_decrypt = DES3.new(key, DES3.MODE_OFB, iv)
	decrypted_msg = cipher_decrypt.decrypt(encypted_msg)
	print decrypted_msg
	print '-'*24 

def encrypt_using_AES(plaintext):
	print "Encrypted Message (AES)"
	print "="*24
	
	#Get a random set of 16 characters for the key
	key = ''.join(chr(random.randint(0, 0xFF)) for i in range(16))

	#Get a random set of 16 characters for the initialization vector
	iv = ''.join([chr(random.randint(0, 0xFF)) for i in range(16)])

	aes = AES.new(key, AES.MODE_CBC, iv)
	encrypted_msg = aes.encrypt(plaintext)
	print encrypted_msg
	decrypt_using_AES(encrypted_msg,key,iv)

def decrypt_using_AES(encrypted_msg,key,iv):	
	print "Decrypted Message (AES)"
	print "="*24 
	aes = AES.new(key, AES.MODE_CBC, iv)
	decrypted_msg = aes.decrypt(encrypted_msg)
	print decrypted_msg
	print '\n'
	
def main():
	msg = raw_input('\nPlease input text to encrypt (8 characters): ')
	encrypt_using_DES3(msg)

	msg = raw_input('\nPlease input text to encrypt (16 characters): ')
	encrypt_using_AES(msg)

if __name__ == '__main__':
	main()