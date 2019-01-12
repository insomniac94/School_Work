#Author: 

flags = [67108864,16777216,8388608,4194304,2097152,1048576,524288,262144,131072,65536,8192,4096,2048,512,256,128,64,32,16,8,2,1]

userInput = int(input("What is the user flag? "))
print("You entered:",userInput,"\nFlag numbers associated:")

for div in flags:
    if userInput >= div:
        userInput = userInput - div
        if(div == 1):
            print(div, ":SCRIPT")
        if(div == 2):
            print(div, ":ACCOUNTDISABLE")
        if(div == 8):
            print(div, ":HOMEDIR_REQUIRED")
        if(div == 16):
            print(div, ":LOCKOUT")
        if(div == 32):
            print(div, ":PASSWD_NOTREQD")
        if(div == 64):
            print(div, ":PASSWD_CANT_CHANGE")
        if(div == 128):
            print(div, ":ENCRYPTED_TEXT_PWD_ALLOWED")
        if(div == 256):
            print(div, ":TEMP_DUPLICATE_ACCOUNT")
        if(div == 512):
            print(div, ":NORMAL_ACCOUNT")
        if(div == 2048):
            print(div, ":INTERDOMAIN_TRUST_ACCOUNT")
        if(div == 4096):
            print(div, ":WORKSTATION_TRUST_ACCOUNT")
        if(div == 8192):
            print(div, ":SERVER_TRUST_ACCOUNT")     
        if(div == 65536):
            print(div, ":DONT_EXPIRE_PASSWORD") 
        if(div == 131072):
            print(div, ":MNS_LOGON_ACCOUNT") 
        if(div == 262144):
           print(div, ":SMARTCARD_REQUIRED")
        if(div == 524288):
            print(div, ":TRUSTED_FOR_DELEGATION") 
        if(div == 1048576):
            print(div, ":NOT_DELEGATED") 
        if(div == 2097152):
            print(div, ":USE_DES_KEY_ONLY") 
        if(div == 4194304):
            print(div, ":DONT_REQ_PREAUTH") 
        if(div == 8388608):
            print(div, ":PASSWORD_EXPIRED") 
        if(div == 16777216):
            print(div, ":TRUSTED_TO_AUTH_FOR_DELEGATION")
        if(div == 67108864):
            print(div, ":PARTIAL_SECRETS_ACCOUNT")