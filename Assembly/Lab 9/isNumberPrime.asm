title isNumberPrime (isNumberPrime.asm)

; Name: Brandon Hough
; CPEN 3710-0
; Date: November 7, 2018

; This program will repeatly ask the user for a non-negative integer
; and will display if the number they entered is prime and if the 
; number entered is not prime, it will display that the number is not
; prime and show which other number it is divisable by. Also will display
; the time it took for the computation in milliseconds for valid inputs. If
; a negative number or character is entered then it'll prompt "Invalid Input!"
; and ask for another input.

; test cases: -11, 1, 2, 3, 13, 43, 48, 169, 240, 241, 487, 489, 65535, 65536, 333667, 
;              3626149, 10619863, 715827883, 715827887, 4000000001, 4000000007, 0

include Irvine32.inc

.data
 
; initilize each prompt text that will be outputed to console
prompt1 BYTE 'Enter a non-negative integer (0 to exit): ',0
prompt2 BYTE ' is a prime number.',0
prompt3 BYTE 'This computation took  ',0
prompt4 BYTE ' milliseconds.',0
prompt5 BYTE ' is not a prime number; it is divisible by ',0
prompt6 BYTE '1 is not prime by definition.',0
prompt7 BYTE 'Invalid Input!',0
prompt8 BYTE 'This computation took ',0
prompt9 BYTE ' miliseconds.',0

userInput DWORD ?                        ; variable to store users input
totalMili DWORD ?                        ; variable to store total 
startTime DWORD ?                        ; variable to store start time
endTime DWORD ?                          ; variable to store end time

.code
main proc

repeatUserInput:
    mov edx, OFFSET prompt1              ; store a pointer to the first byte of the prompt1
    call WriteString                     ; write that previous string of bytes to the command prompt
    xor eax, eax
    call MyReadInt                       ; call MyReadInt to process user input for value input   
                                         ; user input get stored in eax

    js validInput                        ; jump if sign, valid input

    invalidInput:
        push userInput                   ; push the users input to the stack
        mov edx, OFFSET prompt7          ; store a pointer to the first byte of the prompt7
        call WriteString                 ; write that previous string of bytes to the command prompt
        jmp dummy

    validInput:
        cmp eax, 0                       ; compare eax to 0
        je terminate                     ; if user input = 0, we will terminatea
        mov userInput, eax               ; stores users input into a variable
        
        call GetMseconds                 ; get inital start time in ms
        mov startTime, eax               ; store inital start time in startTime variable

        push userInput                   ; push the users input to the stack
        call analyzeNumber               ; call procedure to analyze users input
        
        push eax                         ; push eax to the stack
        call GetMseconds                 ; get end time in ms
        mov endTime, eax                 ; store end time in variable endTime
        pop eax                          ; pop eax

    done:
        cmp eax, 1                       ; compare eax to 1            
        jg printComposite                ; if eax > 1 print the composite (not prime)

        cmp eax, 0                       ; compare eax to 0
        je printPrime                    ; if eax = 0, print prime

    printSpecialCase:
            mov edx, OFFSET prompt6      ; store a pointer to the first byte of the prompt6
            call WriteString             ; write that previous string of bytes to the command prompt

            call crlf                    ; character return
            mov edx, OFFSET prompt8      ; store a pointer to the first byte of the prompt8
            call WriteString             ; write that previous string of bytes to the command prompt 

            mov eax, endTime             ; move end time to eax
            sub eax, startTime           ; subtract end time from start time
            mov totalMili, eax           ; store the time diffrence in variable totalMili

            call WriteDec                ; print out decimal of eax to console 

            mov edx, OFFSET prompt9      ; store a pointer to the first byte of the prompt9
            call WriteString             ; write that previous string of bytes to the command prompt

            jmp dummy

    printComposite:
            push eax                     ; push user input to the stack
            pop ebx                      ; pop divisor
            mov eax, userInput           ; store userInput into eax register
            call WriteDec                ; print out the userInput to the screen
            mov edx, OFFSET prompt5      ; store a pointer to the first byte of the prompt5
            call WriteString             ; write that previous string of bytes to the command prompt
            mov eax, ebx                 ; move divisor of composite number from ebx to eax
            call WriteDec                ; print out decimal of eax to console 

            call crlf                    ; character return
            mov edx, OFFSET prompt8      ; store a pointer to the first byte of the prompt8
            call WriteString             ; write that previous string of bytes to the command prompt

            ;pop eax                      ; pop user input from the stack

            mov eax, endTime             ; move end time to eax
            sub eax, startTime           ; subtract end time from start time
            mov totalMili, eax           ; store the time diffrence in variable totalMili

            call WriteDec                ; print out decimal of eax to console 

            mov edx, OFFSET prompt9      ; store a pointer to the first byte of the prompt9
            call WriteString             ; write that previous string of bytes to the command prompt
            
            jmp dummy

    printPrime:
            mov eax, userInput           ; move user input to eax 
            call WriteDec                ; print out decimal of eax to console 
            mov edx, OFFSET prompt2      ; store a pointer to the first byte of the prompt2
            call WriteString             ; write that previous string of bytes to the command prompt
            
            call crlf                    ; character return
            mov edx, OFFSET prompt8      ; store a pointer to the first byte of the prompt8
            call WriteString             ; write that previous string of bytes to the command prompt

            mov eax, endTime             ; move end time to eax
            sub eax, startTime           ; subtract end time from start time
            mov totalMili, eax           ; store the time diffrence in variable totalMili

            call WriteDec                ; print out decimal of eax to console

            mov edx, OFFSET prompt9      ; store a pointer to the first byte of the prompt9
            call WriteString             ; write that previous string of bytes to the command prompt

     dummy:
        call crlf                         ; character return
        jmp repeatUserInput               ; ask user for another input

     terminate:
        exit

main endp

; --------------------------------------------------
; This sub-program will analyze user input integers
; to determine if they are prime or not and what number
; they are divisible by if they are composite
; Recieves: nothing
; Returns: eax, if eax = 0, input number prime
;                else if eax = divisor of the composite number (ebx)
; Modifies: ebx, edx

analyzeNumber proc uses ebx edx
    push ebp                    ; push base pointer to the stack
    mov ebp, esp                ; store the stack pointer in base pointer
    mov eax, [ebp + 16]         ; store users input into eax        
    mov ebx, 2                  ; inital divisor will be 2, base case
    
    cmp eax, 1                  ; compare users input to 1
    jne calculateRemainder      ; if eax != 1

    specialCase:
        mov eax, 1              ; store 1 into eax
        jmp stop

    calculateRemainder:
        mov eax, [ebp + 16]     ; store users input into eax
        xor edx, edx            ; remainder is stored in edx
        
        cmp ebx, eax            ; check if the divisor is equal to the users input
        je isPrime

        div ebx                 ; divide eax by ebx

        cmp edx, 0              ; compare the remainder to zero
        je isNotPrime

        inc ebx                 ; increment divisor in ebx

        jmp calculateRemainder

    isNotPrime:
        mov eax, ebx            ; move last divisor into eax
        jmp stop

    isPrime:
        mov eax, 0              ; move 0 to eax
        jmp stop                ; keep console up on screen 
        
    stop:
        mov esp, ebp            ; move the base pointer into the stack pointer
        pop ebp                 ; pop ebp from stack
        ret 4                   ; return to main and clean up stack

analyzeNumber endp

MyReadInt PROC uses ebx ecx edx esi

; Modified from Irvine32.asm by Dr. Joe Dumas
; Reads a 32-bit unsigned decimal integer from standard
; input, stopping when the Enter key is pressed.
; All valid digits occurring before a non-numeric character
; are converted to the integer value. Leading spaces are
; ignored, and an optional leading + sign is permitted.

; Receives: nothing
; Returns: If PL=1, the integer is valid, and EAX = binary value.
;    If PL=0, the integer is invalid and EAX = 0

.data
    LMAX_DIGITS = 80
    Linputarea    BYTE  LMAX_DIGITS dup(0),0
    overflow_msgL BYTE  "Caused a 32-bit integer overflow! ",0
    invalid_msgL  BYTE  "Invalid integer! ",0
    neg_msg       BYTE  "Negative numbers not allowed! ",0

.code
; Input a string of digits using ReadString.

    mov   edx,offset Linputarea
    mov   esi,edx               ; save offset in ESI
    mov   ecx,LMAX_DIGITS
    call  ReadString
    mov   ecx,eax               ; save length in ECX
    cmp   ecx,0                 ; greater than zero?
    jne   L1                    ; yes: continue
    mov   eax,0                 ; no: set return value
    jmp   L9                    ; and exit

; Skip over any leading spaces.

L1:    
    mov   al,[esi]              ; get a character from buffer
    cmp   al,' '                ; space character found?
    jne   L2                    ; no: check for a sign
    inc   esi                   ; yes: point to next char
    loop  L1
    jcxz  L8                    ; quit if all spaces

; Check for a leading sign.

L2:    
    cmp   al,'-'                 ; minus sign found?
    jne   L3                     ; no: look for plus sign
    mov   edx, offset neg_msg    ; tell user negative numbers not allowed
        jmp   L8
L3:    
    cmp   al,'+'                 ; plus sign found?
    jne   L4                     ; no: must be a digit
    inc   esi                    ; yes: skip over the sign
    dec   ecx                    ; subtract from counter

; Test the first digit, and exit if it is nonnumeric.

L3A:
    mov  al,[esi]                ; get first character
    call IsDigit                 ; is it a digit?
    jnz  L7A                     ; no: show error message

; Start to convert the number.

L4:    
    mov   eax,0                   ; clear accumulator
    mov   ebx,10                  ; EBX is the divisor

; Repeat loop for each digit.

L5:    
    mov  dl,[esi]                ; get character from buffer
    cmp  dl,'0'                  ; character < '0'?
    jb   L9
    cmp  dl,'9'                  ; character > '9'?
    ja   L9
    and  edx,0Fh                 ; no: convert to binary
    push edx
    mul  ebx                     ; EDX:EAX = EAX * EBX
    pop  edx

    jo   L6                      ; quit if result too big for 32 bits
    add  eax,edx                 ; add new digit to AX
    jo   L6                      ; quit if result too big for 32 bits
    inc  esi                     ; point to next digit
    jmp  L5                      ; get next digit

; Carry out of 32 bits has occured, choose "integer overflow" messsage.

L6:    
    mov  edx,OFFSET overflow_msgL
    jmp  L8

; Choose "invalid integer" message.

L7A:
    mov  edx,OFFSET invalid_msgL

; Display the error message pointed to by EDX.

L8:    
    call WriteString
    stc                       ; set Carry flag
    mov  eax,0                ; set return value to zero and exit
L9:    
    ret

MyReadInt ENDP
end main