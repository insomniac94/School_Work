TITLE sortArrays(sortArrays.asm)

; Name: Brandon Hough
; CPEN 3710
; Date: October 22, 2018

; Procedure to sort (in its place in memory, without making a copy elsewhere in memory) an array of n unsigned 
; doubleword integers starting at address m into ascending numerical order.

; Will print out the two unsorted arrays, the largest un-signed value of the first array, the first and second
; arrays (only the first being sorted), the largest un-signed value of the second array, then finally each the
; two arrays printed out sorted.

include Irvine32.inc

.data

; initizize array contents for the first array
firstArray DWORD  0C0D12AFh, 00030256h, 0FFAABBCCh, 0F700F70h, 
                  00000000h, 0E222111Fh, 0ABCDEF01h, 01234567h 

; initizize array contents for the second array
secondArray DWORD 61A80000h, 024F4A37h, 0EC010203h, 0FAEEDDCCh,
                  2C030175h, 84728371h, 63AA5678h, 0CD454443h,
                  22222222h, 61B1C2D3h, 7A4E96C2h, 81002346h,
                  0FDB2726Eh, 65432100h, 0FFFFFFFFh

; initilize each prompt text that will be outputed to console
prompt1 BYTE 'Array 1: Unsorted, Array 2: Unsorted',0
prompt2 BYTE 'The largest unsigned value in the first array is: ', 0
prompt3 BYTE 'Array 1: Sorted, Array 2: Unsorted',0
prompt4 BYTE 'The largest unsigned value in the second array is: ', 0
prompt5 BYTE 'Array 1: Sorted, Array 2: Sorted',0

.code
main proc

mov edx, OFFSET prompt1            ; store a pointer to the first byte of the prompt1('Array 1: Unsorted, Array 2: Unsorted')
call WriteString                   ; write that previous string of bytes to the command prompt
call Crlf                          ; character return

mov esi, OFFSET firstArray         ; esi points to the memory offset of the first array
mov ecx, LENGTHOF firstArray       ; number of elements in the first array
mov ebx, TYPE firstArray           ; stores the type of bytes in the first array
call DumpMem                       ; dumps memory for first array from Irvine number

mov esi, OFFSET secondArray        ; esi points to the memory offset of the second array
mov ecx, LENGTHOF secondArray      ; number of elements in the second array
mov ebx, TYPE secondArray          ; stores the type of bytes in the second array
call DumpMem                       ; dumps memory for second array from Irvine number
call Crlf                          ; character return

mov esi, OFFSET firstArray         ; esi stores the pointer to the beginning of the array
mov ecx, LENGTHOF firstArray       ; ecx stores how many elements are in the array 
call bubbleSort                    ; call sortingProc on first array

mov edx, OFFSET prompt2            ; store a pointer to the first byte of the prompt2('The largest unsigned value in the first array is: ')
call WriteString                   ; write that previous string of bytes to the command prompt
mov eax, ebx                       ; move largest value that is stored in ebx to eax
call WriteHex                      ; print out largest value to screen, WriteHex prints uses eax register

call Crlf                          ; character return
call Crlf                          ; character return
mov edx, OFFSET prompt3            ; store a pointer to the first byte of the prompt3('Array 1: Sorted, Array 2: Unsorted')
call WriteString                   ; write that previous string of bytes to the command prompt
call Crlf                          ; character return

mov esi, OFFSET firstArray         ; esi points to the memory offset of the first array
mov ecx, LENGTHOF firstArray       ; number of elements in the first array
mov ebx, TYPE firstArray           ; stores the type of bytes in the first array
call DumpMem                       ; dumps memory for first array from Irvine number

mov esi, OFFSET secondArray        ; esi points to the memory offset of the second array
mov ecx, LENGTHOF secondArray      ; number of elements in the second array
mov ebx, TYPE secondArray          ; stores the type of bytes in the second array
call DumpMem                       ; dumps memory for second array from Irvine number
call Crlf                          ; character return

mov esi, OFFSET secondArray        ; esi stores the pointer to the beginning of the array
mov ecx, LENGTHOF secondArray      ; ecx stores how many elements are in the array 
call bubbleSort                    ; call sortingProc on second array

mov edx, OFFSET prompt4            ; store a pointer to the first byte of the prompt4('The largest unsigned value in the second array is: ')
call WriteString                   ; write that previous string of bytes to the command prompt
mov eax, ebx                       ; move largest value that is stored in ebx to eax
call WriteHex                      ; print out largest value to screen, WriteHex prints uses eax register

call Crlf                          ; character return
call Crlf                          ; character return
mov edx, OFFSET prompt5            ; store a pointer to the first byte of the prompt3('Array 1: Sorted, Array 2: Sorted')
call WriteString                   ; write that previous string of bytes to the command prompt
call Crlf                          ; character return

mov esi, OFFSET firstArray         ; esi points to the memory offset of the first array
mov ecx, LENGTHOF firstArray       ; number of elements in the first array
mov ebx, TYPE firstArray           ; stores the type of bytes in the first array
call DumpMem                       ; dumps memory for first array from Irvine number

mov esi, OFFSET secondArray        ; esi points to the memory offset of the second array
mov ecx, LENGTHOF secondArray      ; number of elements in the second array
mov ebx, TYPE secondArray          ; stores the type of bytes in the second array
call DumpMem                       ; dumps memory for second array from Irvine number
call Crlf                          ; character return

call ReadInt					             ; keeps up the cmd window to see results of CallMem

exit
main endp

; ------------------------------------------------------
; This sub-program will sort an array using Bubble Sort
; Recieves: esi = pointer to an array
;           ecx = array size
; Returns: highest value of array in ebx

bubbleSort proc

dec ecx                         ; ecx must be one less than the length of the array
mov ebx, [esi]				          ; assume first value is the largest value
mov dl, 1                       ; set dl to 1 to ensure at least one pass through array

outerLoop:
     cmp dl, 0                  ; compare dl flag to zero
     je endSort                 ; jump to endSort if flag is zero
     mov dl, 0                  ; else set dl to zero
   
     push ecx                   ; push ecx count to the stack
     push esi                   ; push esi memory location to the stack (first values location)

innerLoop:
     mov eax, [esi]             ; get array value
     cmp eax, [esi + 4]         ; compare a pair of values
     jbe nextPair               ; if esi <= esi + 4, next pair will be looked at
     ja changePositions         ; else esi > esi + 4, pair of values will be switched 

changePositions:
     xchg eax, [esi + 4]        ; exchange positions of the two values in memory
     mov [esi], eax    
     mov dl, 1                  ; set flag that this pass through array had changes occur
     
nextPair:
     .if (ebx <= [esi + 4])     ; if ebx is less or equal to then the value at esi + 4
     mov ebx, [esi + 4]         ; then make ebx that value at esi + 4
     .endif

     add esi, 4                 ; move esi to the next value in memory (4 = DWORD)
     loop innerLoop             ; reapeat the inner loop
     pop esi                    ; pop esi memory location of the first value from the stack
     pop ecx                    ; pop the ecx count from the stack

     loop outerLoop             ; reapeat the outer loop

endSort:
     ret                        ; return to main

bubbleSort endp
end main
