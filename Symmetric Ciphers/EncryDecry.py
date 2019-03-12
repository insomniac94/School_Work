#!/usr/bin/env python2.7.15rc1
# =============================================================
# Created By       : Brandon Hough
# Created Date	   : 03/07/2019
# Last Modifed Date: 03/11/2019 
# =============================================================
"""This python script will implement DES3 and AES
encryption and decryption. Will also be able to test
for pattern presevation and error propgation"""
# =============================================================
# Imports OFB
# =============================================================
from Crypto.Cipher import DES3
from Crypto.Cipher import AES
from Crypto import Random
import random
import sys
import os

def encrypt_using_AES(mode,plaintext):
	#Get a random set of 16 characters for the key
	key = ''.join(chr(random.randint(0, 0xFF)) for i in range(16))

	#Get a random set of 16 characters for the initialization vector
	iv = ''.join([chr(random.randint(0, 0xFF)) for i in range(16)])

	print("Encrypted Message")
	print("="*24)
	
	if (mode == "ECB"):	
		aes = AES.new(key, AES.MODE_ECB, iv)
	if (mode == "CBC"):
		aes = AES.new(key, AES.MODE_CBC, iv)
	if (mode == "CFB"):
		aes = AES.new(key, AES.MODE_CFB, iv)
	if (mode == "OFB"):
		aes = AES.new(key, AES.MODE_OFB, iv)
	if (mode == "CTR"):
		aes = AES.new(key, AES.MODE_OFB, iv)

	encrypted_msg = aes.encrypt(plaintext)

	#print out the hex for each decrypted letter
	for letter in encrypted_msg:
		sys.stdout.write((hex(ord(letter))[2:]))
		sys.stdout.write("h ")

	print("\n" + encrypted_msg)

	output4 = ''
	output4 = encrypted_msg
	f = open('project3.txt','w')
	f.write(output4 + "\n")
	f.close()

	decrypt_using_AES(encrypted_msg,key,iv,mode)
	change_random_hex(encrypted_msg,key,iv,mode)

def decrypt_using_AES(encrypted_msg,key,iv,mode):	
	print("Decrypted Message")
	print("="*24) 

	mode = mode.upper()

	if (mode == "ECB"):	
		aes = AES.new(key, AES.MODE_ECB, iv)
	if (mode == "CBC"):
		aes = AES.new(key, AES.MODE_CBC, iv)
	if (mode == "CFB"):
		aes = AES.new(key, AES.MODE_CFB, iv)
	if (mode == "OFB"):
		aes = AES.new(key, AES.MODE_OFB, iv)
	if (mode == "CTR"):
		secret = os.urandom(8)
		aes = AES.new(key, AES.MODE_CTR, iv, counter=lambda: secret)
	
	decrypted_msg = aes.decrypt(encrypted_msg)

	#print out the hex for each decrypted letter
	for letter in decrypted_msg:
		sys.stdout.write((hex(ord(letter))[2:]))
		sys.stdout.write("h ")
	print('\n')
	print(decrypted_msg)

	output5 = ''
	output5 = decrypted_msg
	f = open('project3.txt','a+')
	f.write(output5 + "\n")
	f.close()

def change_random_hex(encrypted_msg,key,iv,mode):

	print("\nChanging Random Bit...")
	index_num = random.randint(1,len(encrypted_msg)-1)
	new_num = random.randint(0,99)
	
	encrypted_list = []
	for letter in encrypted_msg:
		encrypted_list.append((hex(ord(letter))[2:]))
	
	encrypted_list.pop(index_num )
	encrypted_list.insert(index_num ,str(new_num))

	print("Encrypted Message")
	print("="*24) 

	encrypted_msg = ''
	for l in encrypted_list:
		encrypted_msg = encrypted_msg + l

	encrypt_msg = ''
	for m in encrypted_list:
		encrypt_msg = encrypt_msg + ' ' + m + 'h'
	print(encrypt_msg)

	encrypted_msg = encrypted_msg.decode("hex")
	print('\n' + encrypted_msg)

	output3 = ''
	output3 = encrypted_msg
	f = open('project3.txt','a+')
	f.write(output3 + "\n")
	f.close()

	#decrypt_using_DES3(encrypted_msg,iv,key,mode)
	decrypt_using_AES(encrypted_msg,iv,key,mode)

def encrypt_using_DES3(mode, msg):
	key = 'thisismykeyhomie'
	iv = Random.new().read(DES3.block_size)
	mode = mode.upper()

	if (mode == "ECB"):	
		cipher_encrypt = DES3.new(key,DES3.MODE_ECB,iv)
	if (mode == "CBC"):
		cipher_encrypt = DES3.new(key,DES3.MODE_CBC,iv)
	if (mode == "CFB"):
		cipher_encrypt = DES3.new(key,DES3.MODE_CFB,iv)
	if (mode == "OFB"):
		cipher_encrypt = DES3.new(key,DES3.MODE_OFB,iv)

	encrypted_msg = cipher_encrypt.encrypt(msg)
	print("Encrypted Message")
	print("="*24)
	
	#print out the hex for each encrypted letter
	for letter in encrypted_msg:
		sys.stdout.write((hex(ord(letter))[2:]))
		sys.stdout.write("h ")

	print("\n" + encrypted_msg)

	output = ''
	output = encrypted_msg
	f = open('project3.txt','a+')
	f.write(output + "\n")
	f.close()

	decrypt_using_DES3(encrypted_msg,iv,key,mode)
	change_random_hex(encrypted_msg,key,iv,mode)

def decrypt_using_DES3(encrypted_msg,iv,key,mode):

	print("\nDecrypted Message")
	print("="*24)

	mode = mode.upper()

	if (mode == "ECB"):	
		cipher_decrypt = DES3.new(key, DE.MODE_ECB, iv)
	if (mode == "CBC"):
		cipher_decrypt = DES3.new(key, DES3.MODE_CBC, iv)
	if (mode == "CFB"):
		cipher_decrypt = DES3.new(key, DES3.MODE_CFB, iv)
	if (mode == "OFB"):
		cipher_decrypt = DES3.new(key, DES3.MODE_OFB, iv)
	if (mode == "CTR"):
		secret = os.urandom(8)
		cipher_encrypt = DES3.new(key,DES3.MODE_CTR, counter=lambda: secret)

	decrypted_msg = cipher_decrypt.decrypt(encrypted_msg)
	
	#print out the hex for each decrypted letter
	for letter in decrypted_msg:
		sys.stdout.write((hex(ord(letter))[2:]))
		sys.stdout.write("h ")
	print("\n")
	print(decrypted_msg)

	output2 = ''
	output2 = decrypted_msg
	f = open('project3.txt','a+')
	f.write(output2 + "\n")
	f.close()

def validate_input_des3(msg):
	if(len(msg) % 8 != 0):
		print('Please enter a block of 8 characters next time!')
		sys.exit()

def validate_input_aes(msg):
	if(len(msg) % 16 != 0):
		print('Please enter a block of 16 characters next time!')
		sys.exit()

def main():
	#Get intput from user for DES3 encryption
	mode = raw_input('What algorithm mode would you want to use (ECB, CBC, CFB, OFB, or CTR)? ')	
	#msg = raw_input('\nPlease input text to encrypt (8 characters): ')

	#Validate and encrypt input based on mode chosen
	#validate_input_des3(msg)
	#encrypt_using_DES3(mode, msg)

	#Get input from user for AES encryption
	msg = raw_input('\nPlease input text to encrypt (16 characters): ')
	validate_input_aes(msg)
	encrypt_using_AES(mode,msg)

if __name__ == '__main__':
	main()
