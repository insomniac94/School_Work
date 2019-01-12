title findTS	(findTS.asm)

; Brandon Hough
; CPEN 3710
; November 20, 2018

; This 16-bit program will prompt user for a file name then
; print out the last time the file was modified to the console
; Note: TS = timestamp

; import Irvine16 library
include Irvine16.inc    

.data
; prompt user for input of file name
prompt BYTE 'Enter the name of the file: ',0

; messages to print to console
message1 BYTE ' was last modified on ',0
message2 BYTE ' at ',0
message3 BYTE ' does not exist in current directory!',0

TS BYTE ' a.m.',0		   ; stores 'a.m.' in am variable
TS2 BYTE ' p.m.',0		   ; stores 'p.m.' in TS2 variable
TS3 BYTE ':',0			   ; stores ':' in TS3 variable
TS4 BYTE ', ',0			   ; stores ', ' in TS4 variable
zero BYTE '0',0			   ; stores '0' in zero variable

; variables to hold file name and handle
fileName WORD ?
fileHandle WORD ?

; variables to store each timestamp
fileTimeHour WORD ?
fileTimeMinute WORD ?
fileTimeYear WORD ?
fileTimeMonth WORD ?
fileTimeDay WORD ?

; variables to store months
month1 BYTE 'January ',0
month2 BYTE 'February ',0
month3 BYTE 'March ',0
month4 BYTE 'April ',0
month5 BYTE 'May ',0
month6 BYTE 'June ',0
month7 BYTE 'July ',0
month8 BYTE 'August ',0
month9 BYTE 'September ',0
month10 BYTE 'October ',0
month11 BYTE 'November ',0
month12 BYTE 'December ',0

noon BYTE '12:00 p.m.',0

.code
main proc
	mov ax, @data
	mov ds, ax

	; calling each sub-procedure
	call getCommandTail
	;call getFileName
	call openFile
	call getTS
	call closeFile
	call printingTS
	call quit
main endp

;---------------------------------------------------------------------
; Gets a copy of the MS-DOS command tail at PSP:80h
; Recieves: DX which contains the offset of the buffer that
;			recieves a copy of the command tail.
; Returns: CF = 1 if the buffer is empty; otherwise,
;		   CF = 0 and stores the command tail into fileName
; Reference: Chapter 14: 16-bit MS-DOS Programming (14.3.7)
;---------------------------------------------------------------------
getCommandTail proc
	push es					; push es to the stack
	pusha					; push all registers to the stack
	
	mov ah, 62h				; get PSP segment address
	int 21h					; call MS-DOS interrupt
	mov es, bx				; move bx into es register
	
	mov si, dx				; point to buffer
	mov di, 81h				; PSP offset of command tail
	mov cx, 0				; byte count
	mov cl,es:[di-1] 		; get length byte
	cmp cx, 0				; is tail empty?
	je L2					; if so, exit
	cld						; scan in forward direction
	mov al, 20h				; space character
	repz scasb				; scan for non-space
	jz L2					; all space found
	dec di					; non space found
	inc cx					; increment cx by 1
	
	L1:
		mov al, es:[di]		; copy tail to buffer
		mov [si], al		; pointed to by DS:SI
		inc si				; increment si by 1
		inc di				; increment di by 1
		loop L1
		clc					; CF = 0, means tail found
		mov fileName, ax 	; move command tail into fileName
		lea ax, fileName	; move pointer in memory to where fileName is located	
		call WriteString	; print out file name to console
		jmp L3	
	L2:
		stc					; CF = 1 means no command tail
	L3:
		mov BYTE PTR [si],0	; store null byte
		popa				; restore registers
		pop es				; pop es from stack
		ret					; return to main
getCommandTail endp

; -------------------------------------------------------------------
; This getFileName sub-procedure get file name from user
; Recieves: user input
; Returns: stores users file name in variable fileName
; Modifies: none
getFileName proc
	lea dx, prompt 					; move pointer in memory to where prompt is located
	call WriteString 				; print out 'Enter the name of the file: '
	lea dx, fileName				; point in memeory where fileName variable is
	call ReadString					; read input from user
	
	call crlf						; character return
	lea dx, fileName				; move pointer in memory to where file name is located	
	call WriteString				; print file name to console			
	ret								; return to main
getFileName endp

; -------------------------------------------------------------------
; This openFile sub-procedure will open file given by user
; Recieves: name of file given by user 
; Returns: stores nname of file in file handle variable
;		   if file is not found an error message is printed to console
; Modifies: ah and al registers
;---------------------------------------------------------------------
openFile proc
	mov ah, 3Dh						; function to open file
	mov al, 0						; input mode: read only
	lea dx, fileName				; look at file in memory
	int 21h							; call MS-DOS interrupt 
	jc displayError					; jump to display error
	mov fileHandle, ax				; no error so save handle
	ret								; return to main

	displayError:
		lea dx, message3			; move pointer in memory to where message3 is located
		call WriteString 			; print 'Can not open file' to console
		call quit
openFile endp

; -------------------------------------------------------------------
; This closeFile sub-procedure will close the file given by user
; Recieves: name of file given by user in file handle
; Returns: none
; Modifies: ah
;---------------------------------------------------------------------
closeFile proc
	mov ah, 3Eh						; function to close file
	lea bx, fileHandle				; store memory location of file handle in bx
	int 21h							; call MS-DOS interrupt 	
	ret								; return to main
closeFile endp

; -------------------------------------------------------------------
; This printingTS sub-procedure will get the timestamp of the file
; Recieves: name of file given by user in file handle
; Returns: the day, month, year, minute, and hour file specified was
;			last modified in variables
; Modifies: ah, al, and ax 
; Refrenced File I/O in Real-Address Mode written by Irvine pg.11
; http://kipirvine.com/asm/articles/FileIO16.pdf
;---------------------------------------------------------------------
getTS proc
	mov ah, 57h						; get files last written date and time
	mov al, 00h						; gets last modifed date and time
	mov bx, fileHandle				; move file handle into bx register
	int 21h							; call MS-DOS interrupt

	getDay:
		mov ax, dx					; move dx (which has date of file) into ax register	
		and ax, 001Fh				; clear the bits 5-15 in ax
		mov fileTimeDay, ax			; store the day of the file into a variable

	getMonth:
		mov ax, dx					; restore dx back into ax register
		shr ax, 5					; shift bits right by 5
		and ax, 000Fh				; clear the bits 4-15 in ax
		mov fileTimeMonth, ax		; store the month of the file into a variable

	getYear:
		mov ax, dx					; restore dx back into ax register
		shr ax, 9					; shift bits right by 9
		add ax, 1980				; add 1980, since year is relative to 1980
		mov fileTimeYear, ax		; store the year of the file into a variable

	getMinutes:	
		mov ax, cx					; move cx (which holds file time) into ax register
		shr ax, 5					; shift bits right by 5
		and ax, 003Fh				; clear the bits 7-15 in ax
		mov fileTimeMinute, ax		; store the minute of the file into a variable

	getHour:
		mov ax, cx					; move cx (which holds file time) into ax register
		shr ax, 11					; shift bits right by 5
		and ax, 001Fh				; clear the bits 5-15 in ax
		mov fileTimeHour, ax		; store the hour of the file into a variable

	ret								; return to main
getTS endp

; -------------------------------------------------------------------
; This printingTS sub-procedure will print the timestamp of the file
; Recieves: none
; Returns:  prints out time stamp of file given
; Modifies: ax
;---------------------------------------------------------------------
printingTS proc
	lea dx, message1 				; move pointer in memory to where message1 is located
	call WriteString 				; print ' was last modified on ' to console
	
	cmp fileTimeMonth, 1			; compare the month of the file to 1
	je January						; if the month is 1, then jump to January label

	cmp fileTimeMonth, 2			; compare the month of the file to 2
	je February						; if the month is 2, then jump to February label

	cmp fileTimeMonth, 3			; compare the month of the file to 3
	je March						; if the month is 3, then jump to March label

	cmp fileTimeMonth, 4			; compare the month of the file to 4
	je April						; if the month is 4, then jump to April label

	cmp fileTimeMonth, 5			; compare the month of the file to 5
	je May							; if the month is 5, then jump to May label

	cmp fileTimeMonth, 6			; compare the month of the file to 6
	je June							; if the month is 6, then jump to June label

	cmp fileTimeMonth, 7			; compare the month of the file to 7
	je July							; if the month is 7, then jump to July label

	cmp fileTimeMonth, 8			; compare the month of the file to 8
	je August						; if the month is 8, then jump to August label

	cmp fileTimeMonth, 9			; compare the month of the file to 9
	je September					; if the month is 9, then jump to September label

	cmp fileTimeMonth, 10			; compare the month of the file to 10
	je October						; if the month is 10, then jump to October label

	cmp fileTimeMonth, 11			; compare the month of the file to 11
	je November						; if the month is 11, then jump to November label

	cmp fileTimeMonth, 12			; compare the month of the file to 12
	je December						; if the month is 12, then jump to December label

	January:
		lea dx, month1				; move pointer in memory to where month1 is located	
		call WriteString 			; print month1 to console
		jmp printRestOfTS			; jump to print rest of time stamp
		
	February:
		lea dx, month2				; move pointer in memory to where month2 is located	
		call WriteString			; print month2 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	March:
		lea dx, month3				; move pointer in memory to where month3 is located	
		call WriteString			; print month3 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	April:
		lea dx, month4				; move pointer in memory to where month4 is located
		call WriteString			; print month4 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	May:
		lea dx, month5				; move pointer in memory to where month5 is located
		call WriteString			; print month5 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	June:
		lea dx, month6				; move pointer in memory to where month6 is located
		call WriteString			; print month6 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	July:
		lea dx, month7				; move pointer in memory to where month7 is located
		call WriteString			; print month7 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	August:
		lea dx, month8				; move pointer in memory to where month8 is located
		call WriteString			; print month8 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	September:
		lea dx, month9				; move pointer in memory to where month9 is located
		call WriteString			; print month9 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	October:
		lea dx, month10				; move pointer in memory to where month10 is located
		call WriteString			; print month10 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	November:
		lea dx, month11				; move pointer in memory to where month11 is located
		call WriteString			; print month11 to console
		jmp printRestOfTS			; jump to print rest of time stamp

	December:
		lea dx, month12				; move pointer in memory to where month12 is located
		call WriteString			; print month12 to console
	
	printRestOfTS:
        mov ax, fileTimeDay			; move value of fileTimeDay into ax register
		call WriteDec				; print file time day to console

		lea dx, TS4					; move pointer in memory to where TS4 is located
		call WriteString 			; will print ',' to console
		
		mov ax, fileTimeYear		; move pointer in memory to where fileTimeYear is located
		call WriteDec				; print file time year to console

		lea dx, message2			; move pointer in memory to where message2 is located
		call WriteString 			; print ' at ' to console

		cmp fileTimeHour, 12		; compare file time hour to 12, since time stamp hour is stored in military time
		jge printPM					; if the hour is greater than or equal to 12, we are now in pm

	printAM:
		cmp fileTimeHour, 0         ; compare file time hour to zero
		jne printAM2                ; if ax is not equal to 0

        mov ax, 12                  ; move 12 into ax register
		call WriteDec               ; print file time hour to console

		lea dx, TS3                 ; move pointer in memory to where TS3 is located
		call WriteString            ; will print ':' to console

		cmp fileTimeMinute, 10      ; compare minutes to 10
		jge printMinuteAMTS         ; if minutes is greater than or equal to, jump to printMinuteAMTS label

		lea dx, zero                ; move pointer in memory to where zero is located
		call WriteString            ; will print '0' to console

		jmp printMinuteAMTS         ; jump to label to printMinuteAMTS label										

    printAM2:
		mov ax, fileTimeHour
		call WriteDec               ; print hour of file to console
		lea dx, TS3                 ; move pointer in memory to where TS3 is located
		call WriteString            ; will print ':' to console

		cmp fileTimeMinute, 10      ; compare minutes to 10
		jge printMinuteAMTS         ; if minutes is greater than or equal to, jump to printMinuteAMTS label

		lea dx, zero                ; move pointer in memory to where zero is located
		call WriteString            ; will print '0' to console
		jmp printMinuteAMTS         ; jump to label to printMinuteAMTS label

	printPM:
		mov ax, fileTimeHour		; move the time stamp hour to ax
		cmp ax, 12                  ; compare file time hour to 12
		je printPM2                 ; if the hour is 12 then jump to printPM2 label
		sub ax, 12					; subtract 12 since we are in pm now

	printPM2:
		call WriteDec               ; print hour of file to console

		lea dx, TS3                 ; move pointer in memory to where TS3 is located
		call WriteString            ; will print ':' to console

		cmp fileTimeMinute, 10      ; compare minutes to 10
		jge printMinutePMTS         ; if minutes is greater than or equal to, jump to printMinutePMTS label

		lea dx, zero                ; move pointer in memory to where zero is located
		call WriteString            ; will print '0' to console
		jmp printMinutePMTS         ; jump to label to printMinutePMTS label

	printMinutePMTS:
		mov ax, fileTimeMinute      ; move files minute time into ax
		call WriteDec               ; print minute of file to console        

		lea dx, TS2                 ; move pointer in memory to where TS2 is located
		call WriteString            ; will print 'p.m.' to console
		jmp endTS                   ; jump to endTS label

	printMinuteAMTS:
		mov ax, fileTimeMinute      ; move file time minutes to ax register
		call WriteDec               ; print minutes of file to console
		lea dx, TS                  ; move pointer in memory to where TS is located
		call WriteString            ; will print 'a.m.' to console

	endTS:
		ret							; return to main

printingTS endp

; -------------------------------------------------------------------
; This quit sub-procedure will print terminate the program
; Recieves: none
; Returns: none
; Modifies: ax
;---------------------------------------------------------------------
quit proc
	mov ax, 4c00h           		; exit program.
    int 21h							; call MS-DOS interrupt
quit endp
end main