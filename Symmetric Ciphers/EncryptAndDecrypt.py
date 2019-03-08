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
import re
from Crypto.Cipher import AES
import base64
import os

def validate_input(input_str):
    if not re.match("^[a-z]*$", input_str):
        print("Please enter only characters!")
    else:
        decrypt_using_des(input_str)

def getUserInput():
    plain_text_string = input()
    validate_input(plain_text_string)

def decrypt_using_des(input_str):
    print("okay..")

def main():
    getUserInput()

if __name__ == '__main__':
    main()
