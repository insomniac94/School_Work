TITLE numberAnalysis (numberAnalysis.asm)

; Name: Brandon Hough
; CPEN 3710
; Date: October 9, 2018

; This program will repeatedly prompt the user to enter in a signed integer.
; The program will analyze the number and display if the number is positive/negative,
; whether the absolute values of the signed integer are >,<, or = 10000, and if 
; the number is evenly divisible by 8 for each number, then will terminate 
; when the user enters the value '0'

include Irvine32.inc

.data

	prompt BYTE 'Enter a Signed Number: ',0                     ; prompt of bytes that will displayed on the command prompt to ask user for input
	userValue SDWORD ?                                          ; stores the users input

	negResult BYTE ' is a negative number.',0                   ; prompt of bytes that will displayed on the command prompt when a negative number is displayed     
	posResult BYTE ' is a positive number.',0                   ; prompt of bytes that will displayed on the command prompt when a positive number is displayed  
    
    absVal BYTE 'The absolute value of ',0                      ; prompt of bytes that will displayed on the command prompt when a positivenumber is displayed  
    greaterThan BYTE ' is greater than 10000.',0                ; prompt of bytes that will displayed on the command prompt for absolute value if > 10000
    lessThan BYTE ' is less than 10000.',0                      ; prompt of bytes that will displayed on the command prompt for absolute value if < 10000              
    equalTo BYTE ' is equal to 10000.',0                        ; prompt of bytes that will displayed on the command prompt for absolute value if = 10000

    isNotDiv BYTE ' is not evenly divisible by 8.',0            ; prompt of bytes that will displayed on the command prompt for if number not evenly divisible by 8
    isDiv BYTE ' is evenly divisible by 8.',0                   ; prompt of bytes that will displayed on the command prompt for if number eveny divisible by 8

.code    
main proc

	.repeat                                                    ; will repeat this section of code until user enters '0'. 

	mov edx, OFFSET prompt                                     ; store a pointer to the first byte of the prompt
	call WriteString                                           ; prints out the prompt string to the commmand prompt window
	call ReadInt                                               ; read the 32-bit signed integer into eax register
	mov userValue, eax                                         ; store the user input from the eax register into the SDWORD userValue              

	call analyzeNumberSign                                     ; call procedure to analyze the numbers sign
    call analyzeNumberAbsVal                                   ; call procedure to analyze the numbers value compared to (<,>, or =) 10000
    call analyzeNumberDiv8                                     ; call procedure to analyze if the number is divisble by 8
    call crlf                                                  ; does a character return to the next line

	.until userValue == 0                                      ; needed to ensure these previous lines will run till the user enters '0'

exit
main endp

; --------------------------------------------------
; This sub-program will analyze user input integers
; to determine whether the numbers are +/-

analyzeNumberSign proc
	
	CMP eax, 0                     ; compares the value in eax to 0                       
	JG printPositive               ; will jump to printPositive if eax has a value greater than 0
	JL printNegative               ; will jump to printNegative if eax has a value less than 0
	JE zeroCase                    ; will jump to zeroCase if eax has a value equal to 0

	printPositive:
	call WriteInt                  ; write the user input to the screen
	mov edx, OFFSET posResult      ; store a pointer to the first byte of the posResult (' is a positive number.')
	call WriteString               ; write that previous string of bytes to the command prompt
	call crlf                      ; does a character return to the next line
	ret                            ; return to main

	printNegative:
	call WriteInt                  ; write the user input to the screen
	mov edx, OFFSET negResult      ; store a pointer to the first byte of the negResult (' is a negative number.')
	call WriteString               ; write that previous string of bytes to the command prompt
	call crlf                      ; does a character return to the next line
	ret                            ; return to main

	zeroCase:
	exit                           ; exit program if eax has a value of 0

analyzeNumberSign endp

; -----------------------------------------------------
; This sub-program will analyze user input integers
; to determine whether absolute values >,<, or = 10000

analyzeNumberAbsVal proc

    cdq                             ; copies the sign of the register eax to register edx
    CMP edx, 0                      ; compare the value in edx to '0'
    JE postiveNumAbs                ; will jump to postiveNumAbs if edx has a value equal to 0
    JNE negativeNumAbs              ; will jump to negativeNumAbs if edx has a value not equal to 0

    postiveNumAbs:
    CMP eax, 10000                  ; compare the value in eax to '10000'
    JG printGreaterThan             ; will jump to printGreaterThan if eax has a value greater than '10000'
    JL printLessThan                ; will jump to printLessThan if eax has a value less than '10000'
    JE equalToNum                   ; will jump to equalToNum  if eax has a value equal to '10000'     

    negativeNumAbs:
    NEG eax                        ; negate the negative values to make them postive
    CMP eax, 10000                 ; compare the value in eax to '10000' 
    JE equalToNum                  ; will jump to equalToNum if eax has a value equal to '10000'  
    NEG eax                        ; negate eax back to the negative value
    JG printGreaterThan            ; will jump to printGreaterThan if eax has a value greater than '10000'
    JL printLessThan               ; will jump to printLessThan if eax has a value less than '10000'
    ret                            ; return to main

    printGreaterThan:
    mov edx, OFFSET absVal         ; store a pointer to the first byte of the absVal ('The absolute value of ')
    call WriteString               ; write that previous string of bytes to the command prompt
    call WriteInt                  ; write the user input to the screen
	mov edx, OFFSET greaterThan    ; store a pointer to the first byte of the greaterThan  (' is greater than 10000.')
	call WriteString               ; write that previous string of bytes to the command prompt
	call crlf                      ; does a character return to the next line
	ret                            ; return to main

    printLessThan:
    mov edx, OFFSET absVal         ; store a pointer to the first byte of the absVal ('The absolute value of ')
    call WriteString               ; write that previous string of bytes to the command prompt
    call WriteInt                  ; write the user input to the screen
	mov edx, OFFSET lessThan       ; store a pointer to the first byte of the lessThan (' is less than 10000.')
	call WriteString               ; write that previous string of bytes to the command prompt
	call crlf                      ; does a character return to the next line
	ret                            ; return to main

    equalToNum:
    mov eax, userValue             ; restore the eax register to the users value they entered
    mov edx, OFFSET absVal         ; store a pointer to the first byte of the absVal ('The absolute value of ')
    call WriteString               ; write that previous string of bytes to the command prompt
    call WriteInt                  ; write the user input to the screen
    mov edx, OFFSET equalTo        ; store a pointer to the first byte of the equalTo (' is equal to 10000.')
	call WriteString               ; write that previous string of bytes to the command prompt
	call crlf                      ; does a character return to the next line
	ret                            ; return to main


analyzeNumberAbsVal endp

; -----------------------------------------------------------
; This sub-program will analyze user input integers
; to determine whether the numbers are evenly divisible by 8

analyzeNumberDiv8 proc

    mov edx, 0                     ; reset edx register to '0'
    mov eax, userValue             ; move the users value into the eax register
    mov ebx, 8                     ; move 8 into the ebx register
    idiv ebx                       ; does the computation of the registers ebx/eax and store remainder in edx
    
    CMP edx, 0                     ; compare the remainder in edx to '0'
	JNE printNotDiv                ; will jump to printNotDiv if edx has a value other than '0'
	JE printDiv                    ; will jump to printDiv  if edx has a value of '0'

    printNotDiv:
    mov eax, userValue             ; store the user value into eax
    call WriteInt                  ; write the user input to the screen
	mov edx, OFFSET isNotDiv       ; store a pointer to the first byte of the isNotDiv (' is not evenly divisible by 8.')
	call WriteString               ; write that previous string of bytes to the command prompt
    call crlf                      ; dooes a character return to the next line
	ret                            ; return to main

    printDiv:
    mov eax, userValue             ; store the user value into eax
    call WriteInt                  ; write the user input to the screen
	mov edx, OFFSET isDiv          ; store a pointer to the first byte of the isDiv (' is evenly divisible by 8.')
	call WriteString               ; write that previous string of bytes to the command prompt
    call crlf                      ; does a character return to the next line
    ret                            ; return to main

analyzeNumberDiv8 endp
end main