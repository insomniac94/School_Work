; TITLE ReverseString (reversestring.asm)

; Brandon Hough
; CPEN 3710
; September 22, 2018
; Reverses the order of a string byte by byte

include Irvine32.inc

.386


.data
source byte "I am CPEN 3710 student Brandon Hough",0   ; stores a stringh of bytes into source
answer byte SIZEOF source DUP(?)                       ; creates another set of bytes called answer with the same size of source and is undefined
                                                      
.code
main PROC
     mov edi, OFFSET source                             ; stores a pointer at the beginning of the source byte
     mov esi, OFFSET answer                             ; stores a pointer at the beginning of the answer byte
     add esi, SIZEOF answer - 2                         ; moves the pointer to the end of the answer byte

     mov eax, SIZEOF source - 1                         ; stores a pointer at the end of the source byte

     reverseString:
          mov bl,[edi]                                  ; indirect addressing to 
          mov [esi],bl                                  ; indirect addressing to move the first byte stored in al into the last byte position
          inc edi                                       ; increment esi register by 1
          dec esi                                       ; decrement edi register by 1
     loop reverseString

     mov edx, OFFSET source
     call WriteString
     mov edx, OFFSET answer
     call WriteString
     
     invoke ExitProcess,0
main ENDP
END main