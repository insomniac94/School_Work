TITLE Add or Sub   (AddOrSub.asm)

; Brandon Hough
; CPEN 3710
; August 29, 2018
; this program will add or subtract 80-bit numbers in memory depending
; on if the control flag is a 0 (will add) or a non-zero (will subtract)
; will also print out all four 80-bit numbers plus the two result 
; that we calcualted through addition and subtraction 80-bit numbers

include Irvine32.inc	     					       ; import Irvinve32 library

.data  
myArray TBYTE 48C2E4C377F535D9607Bh, 1157249592C6ED40C392h, 
              10792731164E24C2F0ABh, 086234E523243C7F1265h, ?,?        ; myArray that holds 6 80-bit numbers
.code
main proc
     mov esi, OFFSET myArray        					; esi points to the memory offset of the first operand
     mov edi, OFFSET myArray + 10   					; edi points to the memory offset of the second operand
     mov edx, OFFSET myArray + 40   					; edx is the offset of the location where the result of the addition will be stored
     mov bl, 0                     					; control flag to specify doing addition of the first and second 80-bit integers
     call findAnswer							; call findAnswer procedure

	 mov bl, 1                      				; change the control flag to specify doing subtraction of the third and forth 80-bit integers
	 mov esi, OFFSET myArray + 20   				; esi points to the memory offset of the third operand
     mov edi, OFFSET myArray + 30   					; edi points to the memory offset of the forth operand
     mov edx, OFFSET myArray + 50   					; edx is the offset of the location where the result of the subtraction will be stored
     call findAnswer							; call findAnswer procedure

	 ;call DumpRegs							; dumps contents of registers
     mov esi, OFFSET myArray						; beginning offset of first number
     mov ecx, 10							; number of bytes the first number is 10
     mov ebx, TYPE myArray						; stores the type of bytes
     call DumpMem							; dumps memory for first number
	 
	 ;call DumpRegs							; dumps contents of registers
     mov esi, OFFSET myArray + 10   					; beginning offset of second number
     mov ecx, 10							; number of bytes the second number is 10
     mov ebx, TYPE myArray						; stores the type of bytes
     call DumpMem							; dumps memory for second number
	 
	 ;call DumpRegs							; dumps contents of registers
     mov esi, OFFSET myArray + 20  					; beginning offset of third number
     mov ecx, 10							; number of bytes the third number is 10
     mov ebx, TYPE myArray						; stores the type of bytes
     call DumpMem							; dumps memory for third number
	 
	 ;call DumpRegs							; dumps contents of registers
     mov esi, OFFSET myArray + 30   					; beginning offset of forth number
     mov ecx, 10							; number of bytes the forth number is 10
     mov ebx, TYPE myArray						; stores the type of bytes
     call DumpMem							; dumps memory for forth number
	 
	 ;call DumpRegs							; dumps contents of registers
     mov esi, OFFSET myArray + 40   					; beginning offset of addtion result number
     mov ecx, 10							; number of bytes of addition result is  is 10
     mov ebx, TYPE myArray						; stores the type of bytes
     call DumpMem							; dumps memory for addtion result number

	 ;call DumpRegs							; dumps contents of registers
     mov esi, OFFSET myArray + 50   					; beginning offset of addition result number
     mov ecx, 10							; number of bytes of addition result is  is 10
     mov ebx, TYPE myArray						; stores the type of bytes
     call DumpMem							; dumps memory for addtion result number

    call DumpRegs
    call ReadInt							; keeps up the cmd window to see results of CallMem
    exit 
main endp

;--------------------------------------------------------------
; findAnswer
; calculates either addition or subtracion of two 80-bit
; numbers depending on the value of the control flag (bl register)
; Receives: esi = memory offset of the first operand
;		    edi = memory offset of the second operand
;			edx = offset of the location where the result of the operation is to be stored
;			bl = control flag to specify the desired operation (addition: 0, subtraction: non-zero)
; Returns: eax = sum or diffrence of two 80-bit numbers
;-------------------------------------------------------------

findAnswer proc
	 CMP bl,0							; compare the contents of the bl register to 0
	 JE doAdd							; if bl is equal to 0 then jump to doAdd
	 JNE doSub							; if bl is not equal to 0 then jump to doSub

	 ; add the two register values
	 doAdd:							
	 mov eax, [esi]							; move first numbers first 32-bits to eax		
	 add eax, [edi]							; add the first numbers first 32-bits to the second numbers first 32-bits	
	 mov [edx],eax							; move the result of the addition of the first 32-bits to edx register
	 
	 mov eax, [esi+4]						; move first numbers next 32-bits to eax	
	 adc eax, [edi+4]						; add first numbers next 32-bits to the second numbers next 32-bits	
	 mov [edx+4], eax						; move the result of the addition of the 32-bits to edx register

	 mov ax, [esi+8]						; move first numbers next 16-bits to eax
	 adc ax, [edi+8]						; add first numbers next 16-bits to the second numbers next 16-bits
	 mov [edx+8],ax							; move the result of the addition of next 16-bits to edx register
	 ret								; return to main procedure

	 ; subtract the two register values
	 doSub:							
	 mov eax, [esi]							; move third numbers first 32-bits to eax		
	 sub eax, [edi]							; subtract the third numbers first 32-bits from the second numbers first 32-bits	
	 mov [edx],eax							; move the result of the subtraction of the first 32-bits to edx register
	 
	 mov eax, [esi+4]						; move third numbers next 32-bits to eax	
	 sbb eax, [edi+4]						; subtract the third numbers next 32-bits from the second numbers next 32-bits	
	 mov [edx+4], eax						; move the result of the subtraction of the 32-bits to edx register

	 mov ax, [esi+8]						; move third numbers next 16-bits to eax
	 sbb ax, [edi+8]						; subtract the third numbers next 16-bits from the forth numbers next 16-bits	
	 mov [edx+8],ax							; move the result of the subtraction of the 16-bits to edx register
     ret								; return to main procedure	
findAnswer endp
end main
