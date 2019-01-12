TITLE Fibonacci Series   (Template.asm)

; Brandon Hough
; CPEN 3710
; August 18, 2016
; Generates the Fibonacci series of the first 32 integers


include Irvine32.inc	      ; import Irvinve32 library

.data ; set up variables and constants to use      

firstFib DWORD 0001h           ; intilize first fibonacci number variable
secondFib DWORD 0000h          ; intilize second fibonacci number variable
resultFib DWORD ?              ; stores the result of each fib sequence

fibArray DWORD 32 DUP(?)       ; uninitialized  array  of  32  doublewords  in  memory

.code
main proc

mov eax, firstFib              ; move the first fibonacci number into eax register
mov ebx, secondFib             ; move the second fibonacci number into ebx register
mov edx, resultFib             ; move the result into the edx register
mov ecx, 32                    ; initialize loop count to 32
mov esi, 0                     ; array index 

fibLoop:

     mov edx, eax             ; move the first fibonacci number to the result edx register
     add edx, ebx             ; add the second fibonacci number to the result edx register
     call DumpRegs            ; dump the contents of the registers
     mov eax, ebx             ; move the second fibonacci number to the first fibonacci eax register
     mov ebx, edx             ; move the result fibonacci number to the second fibonacci ebx register
     mov fibArray[esi] , edx  ; move the result fibonacci number into the fibArray of the current index esi

     add esi, 4               ; increment the array index of esi register by 4 since we are using doublewords

loop fibLoop

mov esi, OFFSET fibArray      ; starting offset
mov ecx, LENGTHOF fibArray    ; number of units
mov ebx, TYPE fibArray        ; doubleword format
call DumpMem                  ; dump the contents of the fibArray

exit
main endp
end main