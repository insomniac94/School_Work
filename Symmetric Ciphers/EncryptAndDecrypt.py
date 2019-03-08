#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# =============================================================
# Created By  : Brandon Hough
# Created Date: 03/07/2019
# =============================================================
"""This application will implement encryption of a plaintext 
series of bytes, and decryption of the created cipher text"""
# =============================================================
# Imports
# =============================================================
import base64
import os
from cryptography.fernet import Fernet
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
import pyDes

def encrypt_decrypt_des(input_str):

    print("\nDES ENCRYPTION")
    print("="*24)

    key = pyDes.des("DESCRYPT", pyDes.CBC, "\0\0\0\0\0\0\0\0", pad=None, padmode=pyDes.PAD_PKCS5)
    decrypted_msg = key.encrypt(input_str)
    #print("Key: %r" % key)
    print("Encrypted: %r" % decrypted_msg)
    print("Decrypted: %r" % key.decrypt(decrypted_msg))

    '''
    salt = os.urandom(16)
    kdf = PBKDF2HMAC(
        algorithm = hashes.SHA256(),
        length = 32,
        salt = salt,
        iterations = 100000,
        backend = default_backend()
    )

    password = b'testpassword'
    key = base64.urlsafe_b64encode(kdf.derive(password))

    print("Key: ")
    print(key)
    
    f = Fernet(key)

    token = f.encrypt(input_str)
    print("\nEncrypted Message: ")
    print(token)

    print("\nDecrypted Message: ")
    print(f.decrypt(token))
    '''

def encrypt_decrypt_aes(input_str):
    print("\nAES ENCRYPTION")
    print("="*24)


def main():
    plain_text_msg = input('\nPlease input text to encrypt: ')
    plain_text_msg = str.encode(plain_text_msg)
    encrypt_decrypt_des(plain_text_msg)
    encrypt_decrypt_aes(plain_text_msg)

if __name__ == '__main__':
    main()