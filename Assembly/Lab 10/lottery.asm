title lottery (lottery.asm)

; Name: Brandon Hough
; CPEN 3710-0
; Date: November 14, 2018

; This program will simulate a drawing of the Mega Millions lottery.
; User will select 5 white balls (non-duplicates) and one yellow ball
; for a chance to win the jackpot

; import Irvine32 library
include Irvine32.inc

; import Macros library
include Macros.inc

; macro that will create a random number, number is required
randomNumberGen macro number:req
    mov eax, number         				; get random 0 to number 
    call RandomRange		
    inc eax
endm

; macro when a duplicate number is entered
duplicateNumber macro
	mWriteString OFFSET message8			; prints 'You can not enter duplicates!'
	call crlf					; character return
endm

.data

; structure of users numbers
usersBalls struct
    whiteBall1 DWORD ?      				 ; stores first white ball number
    whiteBall2 DWORD ?      				 ; stores second white ball number
    whiteBall3 DWORD ?      				 ; stores third white ball number
    whiteBall4 DWORD ?     			 	 ; stores forth white ball numbera
    whiteBall5 DWORD ?     			 	 ; stores fifth white ball number
    yellowBall DWORD ?     				 ; stores yellow ball number
usersBalls ends

; initializing user input structures
userPicks usersBalls <>    

; structure of lottery winning numbers
winningBalls struct
    whiteBall1 DWORD ?      				   ; stores first white ball number
    whiteBall2 DWORD ?     			  	   ; stores second white ball number
    whiteBall3 DWORD ?     			   	   ; stores third white ball number
    whiteBall4 DWORD ?      				   ; stores forth white ball numbera
    whiteBall5 DWORD ?      				   ; stores fifth white ball number
    yellowBall DWORD ?      				   ; stores yellow ball number
winningBalls ends

 ; initializing winnng lottery number structures
winningPicks winningBalls <>     

; initilize each messaage printed to screen
message1 BYTE 'Mega Millions drawing results: ',0
message2 BYTE 'White balls ',0
message3 BYTE ' ... ',0
message4 BYTE 'Yellow ball ',0
message8 BYTE 'You can not enter duplicates! Renter last ball choice!',0


; initilize each prompt printed to screen
prompt1 BYTE 'Please enter your first white number: ',0
prompt2 BYTE 'Please enter your second white number: ',0
prompt3 BYTE 'Please enter your third white number: ',0
prompt4 BYTE 'Please enter your forth white number: ',0
prompt5 BYTE 'Please enter your fifth white number: ',0
prompt6 BYTE 'Please enter your yellow number: ',0

matchedWhiteBalls DWORD 0				   ; inital matched balls count of 0
yellowBallMatch DWORD 0					   ; inital matched yellow ball found count of 0

.code
main proc
	call Randomize					   ; re-seed generator with curr time

    mWriteString OFFSET message1           		   ; print 'Mega Millions drawing results: ' to console

	getRandomW1:
        randomNumberGen 70				   ; get a random number from 0 to 70
	    mov winningPicks.whiteBall1, eax		   ; move random number into winning structure
	    call WriteDec				   ; write first random number to the screen
	    mWriteSpace					   ; insert a space

    getRandomW2:
	    randomNumberGen 70				   ; get a random number from 0 to 70

        cmp eax, winningPicks.whiteBall1                   ; compare second winning number to first
        je getRandomW2                     		   ; if they are equal get another second ball number

	    mov winningPicks.whiteBall2, eax	 	   ; move random number into winning structure
	    call WriteDec				   ; write second random number to the screen
	    mWriteSpace					   ; insert a space

    getRandomW3:
	    randomNumberGen 70			 	   ; get a random number from 0 to 70
   
        cmp eax, winningPicks.whiteBall1    		   ; compare third winning number to first
        je getRandomW3                     		   ; if they are equal get another third ball number

        cmp eax, winningPicks.whiteBall2    		   ; compare third winning number to second
        je getRandomW3                      		   ; if they are equal get another third ball number

	    mov winningPicks.whiteBall3, eax		   ; move random number into winning structure
	    call WriteDec				   ; write third random number to the screen
	    mWriteSpace					   ; insert a space

    getRandomW4:
        randomNumberGen 70			  	   ; get a random number from 0 to 70

        cmp eax, winningPicks.whiteBall1    		   ; compare forth winning number to first
        je getRandomW4                      		   ; if they are equal get another forth ball number

        cmp eax, winningPicks.whiteBall2    		   ; compare forth winning number to second
        je getRandomW4                     		   ; if they are equal get another forth ball number

        cmp eax, winningPicks.whiteBall3    		   ; compare forth winning number to third
        je getRandomW4                      		   ; if they are equal get another forth ball number

	    mov winningPicks.whiteBall4, eax		   ; move random number into winning structure
	    call WriteDec				   ; write forth random number to the screen
	    mWriteSpace					   ; insert a space

    getRandomW5:
	    randomNumberGen 70				   ; get a random number from 0 to 70

        cmp eax, winningPicks.whiteBall1    		   ; compare fifth winning number to first
        je getRandomW5                      		   ; if they are equal get another fifth ball number

        cmp eax, winningPicks.whiteBall2    		   ; compare fifth winning number to second
        je getRandomW5                      		   ; if they are equal get another fifth ball number

        cmp eax, winningPicks.whiteBall3   		   ; compare fifth winning number to third
        je getRandomW5                     		   ; if they are equal get another fifth ball number

        cmp eax, winningPicks.whiteBall4    		   ; compare fifth winning number to forth
        je getRandomW5                      		   ; if they are equal get another fifth ball number

	    mov winningPicks.whiteBall5, eax		   ; move random number into winning structure
	    call WriteDec				   ; write fifth random number to the screen
	    mWriteSpace					   ; insert a space

    mWriteString OFFSET message2           		   ; print 'White balls ' to console
    mWriteString OFFSET message3            		   ; print ' ... ' to console
    mWriteString OFFSET message4            		   ; print 'Yellow ball ' to console

	randomNumberGen 25				   ; get a random number from 0 to 70
	mov winningPicks.yellowBall, eax	   	   ; move random number into winning structure
	call WriteDec					   ; write yellow ball random number to the screen
	mWriteSpace					   ; insert a space
    call crlf                               		   ; character return

	promptW1:
		mWriteString OFFSET prompt1                ; print 'Please enter your first white number: ' to console
		call ReadDec                               ; read user input from console, stores in eax

        ; if invalid input is entered then eax = 0
        .IF(eax == 0  || eax > 70)
        mWriteLn 'Invalid Input! Enter a number between 1-70'
        jmp promptW1                                	  ; prompt user for another first white ball number
        .ENDIF

		mov userPicks.whiteBall1, eax      	  ; move users first white ball number into variable whiteBall1

	promptW2:
		mWriteString OFFSET prompt2         	  ; print 'Please enter your second white number: ' to console
		call ReadDec                        	  ; read user input from console, stores in eax

        ; if invalid input is entered then eax = 0
        .IF(eax == 0  || eax > 70)
        mWriteLn 'Invalid Input! Enter a number between 1-70'
        jmp promptW2                       		  ; prompt user for another second white ball number
        .ENDIF

		mov userPicks.whiteBall2, eax       	  ; move users second white ball number into variable whiteBall2

		.IF(eax == userPicks.whiteBall1)	  ; if first ball = second ball
		call printDuplicates			  ; then go to sub-proc print duplicates

		jmp promptW2				  ; prompt user for another second white ball

		.ENDIF

	promptW3:
		mWriteString OFFSET prompt3         	 ; print 'Please enter your third white number: ' to console
		call ReadDec                        	 ; read user input from console, stores in eax

        ; if invalid input is entered then eax = 0
        .IF(eax == 0  || eax > 70)
        mWriteLn 'Invalid Input! Enter a number between 1-70'
        jmp promptW3                        		; prompt user for another third white ball number
        .ENDIF

		mov userPicks.whiteBall3, eax       	; move users third white ball number into variable whiteBall3
		

        ; if the third user number ball is equal to any previous ball, call print duplicates sub proc
		.IF(eax == userPicks.whiteBall1 || eax == userPicks.whiteBall2)
		call printDuplicates

		jmp promptW3				; prompt for another first white ball number
		.ENDIF

	promptW4:
		mWriteString OFFSET prompt4             ; print 'Please enter your forth white number: ' to console
		call ReadDec                            ; read user input from console, stores in eax

        ; if invalid input is entered then eax = 0
        .IF(eax == 0  || eax > 70)
        mWriteLn 'Invalid Input! Enter a number between 1-70'
        jmp promptW4                        		; prompt user for another forth white ball number
        .ENDIF

		mov userPicks.whiteBall4, eax      	; move users forth white ball number into variable whiteBall4
		

        ; if the forth user number ball is equal to any previous ball, call print duplicates sub proc
		.IF(eax == userPicks.whiteBall1 || eax == userPicks.whiteBall2 || eax == userPicks.whiteBall3)
		call printDuplicates

		jmp promptW4				; prompt for another first white ball number
		.ENDIF

	promptW5:
		mWriteString OFFSET prompt5             ; print 'Please enter your fifth white number: ' to console
		call ReadDec                            ; read user input from console, stores in eax

        ; if invalid input is entered then eax = 0
        .IF(eax == 0  || eax > 70)
        mWriteLn 'Invalid Input! Enter a number between 1-70'
        jmp promptW5                        		; prompt user for another fifth white ball number
        .ENDIF

		mov userPicks.whiteBall5, eax           ; move users fifth white ball number into variable 

        ; if the fifth user number ball is equal to any previous ball, call print duplicates sub proc
		.IF(eax == userPicks.whiteBall1 || eax == userPicks.whiteBall2 || eax == userPicks.whiteBall3 || eax == userPicks.whiteBall4)
		call printDuplicates

		jmp promptW5				; prompt for another first white ball number
		.ENDIF

	promptY1:
		mWriteString OFFSET prompt6         	; print 'Please enter your yellow number: ' to console
		call ReadDec                        	; read user input from console, stores in eax

        ; if invalid input is entered then eax = 0
        .IF(eax == 0  || eax > 25)
        mWriteLn 'Invalid Input! Enter a number between 1-25'
        jmp promptY1                        		; prompt user for another yellow ball number
        .ENDIF

		mov userPicks.yellowBall, eax      	; move users yellow ball number into variable yellowBall

	checkW1:        
        mov eax, userPicks.whiteBall1       		; move the first users white ball number into eax
        cmp eax, winningPicks.whiteBall1    		; compare users first white ball to winning first white ball
        je incrementCountW1                 		; if users first ball = winning first ball, jump to increment count W1

        cmp eax, winningPicks.whiteBall2    		; compare users first white ball to winning second white ball
        je incrementCountW1                 		; if users first ball = winning second ball, jump to increment count W1

        cmp eax, winningPicks.whiteBall3    		; compare users first white ball to winning third white ball
        je incrementCountW1                 		; if users first ball = winning third ball, jump to increment count W1

        cmp eax, winningPicks.whiteBall4    		; compare users first white ball to winning forth white ball
        je incrementCountW1                 		; if users first ball = winning forth ball, jump to increment count W1

        cmp eax, winningPicks.whiteBall5    		; compare users first white ball to winning fifth white ball
        je incrementCountW1                 		; if users first ball = winning fifth ball, jump to increment count W1
        jmp checkW2                         		; if no users ball numbers = winning balls number, jump to next users number

    incrementCountW1:
        inc matchedWhiteBalls               		; increment the number of matched white balls found when match is found

	checkW2:    
        mov eax, userPicks.whiteBall2       		; move the second users white ball number into eax
        cmp eax, winningPicks.whiteBall1    		; compare users second white ball to winning first white ball
        je  incrementCountW2                		; if users second ball = winning first ball, jump to increment count W1
        
        cmp eax, winningPicks.whiteBall2    		; compare users second white ball to winning second white ball
        je  incrementCountW2                		; if users second ball = winning second ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall3    		; compare users second white ball to winning third white ball
        je  incrementCountW2                		; if users second ball = winning third ball, jump to increment count W1       
       
        cmp eax, winningPicks.whiteBall4    		; compare users second white ball to winning forth white ball
        je  incrementCountW2                		; if users second ball = winning forth ball, jump to increment count W1

        cmp eax, winningPicks.whiteBall5    		; compare users second white ball to winning fifth white ball
        je  incrementCountW2                		; if users second ball = winning fifth ball, jump to increment count W1
        jmp checkW3                         		; if no users ball numbers = winning balls number, jump to next users number

    incrementCountW2:
        inc matchedWhiteBalls               		; increment the number of matched white balls found when match is found

	checkW3:
        mov eax, userPicks.whiteBall3       		; move the third users white ball number into eax
        cmp eax, winningPicks.whiteBall1    		; compare users third white ball to winning first white ball
        je incrementCountW3                 		; if users third ball = winning first ball, jump to increment count W1
        
        cmp eax, winningPicks.whiteBall2    		; compare users third white ball to winning second white ball
        je incrementCountW3                 		; if users third ball = winning second ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall3    		; compare users third white ball to winning third white ball
        je incrementCountW3                 		; if users third ball = winning third ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall4    		; compare users third white ball to winning forth white balla
        je incrementCountW3                 		; if users third ball = winning forth ball, jump to increment count W1

        cmp eax, winningPicks.whiteBall5    		; compare users third white ball to winning fifth white ball
        je incrementCountW3                 		; if users third ball = winning fifth ball, jump to increment count W1
        jmp checkW4                         		; if no users ball numbers = winning balls number, jump to next users number

    incrementCountW3:
        inc matchedWhiteBalls               		; increment the number of matched white balls found when match is found

	checkW4:
        mov eax, userPicks.whiteBall4       		; move the forth users white ball number into eax
        cmp eax, winningPicks.whiteBall1    		; compare users forth white ball to winning first white ball
        je incrementCountW4                 		; if users forth ball = winning first ball, jump to increment count W1
        
        cmp eax, winningPicks.whiteBall2    		; compare users forth white ball to winning second white ball        
        je incrementCountW4                 		; if users forth ball = winning second ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall3    		; compare users forth white ball to winning third white ball
        je incrementCountW4                 		; if users forth ball = winning third ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall4    		; compare users forth white ball to winning forth white ball
        je incrementCountW4                 		; if users forth ball = winning forth ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall5    		; compare users forth white ball to winning fifth white ball
        je incrementCountW4                 		; if users forth ball = winning fifth ball, jump to increment count W1
        jmp checkW5                         		; if no users ball numbers = winning balls number, jump to next users number
            
    incrementCountW4:
        inc matchedWhiteBalls              		; increment the number of matched white balls found when match is found

	checkW5:
        mov eax, userPicks.whiteBall5       		; move the fifth users white ball number into eax
        cmp eax, winningPicks.whiteBall1    		; compare users fifth white ball to winning first white ball
        je incrementCountW5                 		; if users fifth ball = winning first ball, jump to increment count W1
            
        cmp eax, winningPicks.whiteBall2   		; compare users fifth white ball to winning second white ball
        je incrementCountW5                		; if users fifth ball = winning second ball, jump to increment count W1            
       
        cmp eax, winningPicks.whiteBall3    		; compare users fifth white ball to winning third white ball
        je incrementCountW5                 		; if users fifth ball = winning third ball, jump to increment count W1     
       
        cmp eax, winningPicks.whiteBall4    		; compare users fifth white ball to winning forth white ball
        je incrementCountW5                 		; if users fifth ball = winning forth ball, jump to increment count W1
       
        cmp eax, winningPicks.whiteBall5    		; compare users fifth white ball to winning fifth white ball
        je incrementCountW5                 		; if users fifth ball = winning fifth ball, jump to increment count W1
        jmp checkYellowBall                 		; all white balls have been checked now, jump to checkYellowBall

    incrementCountW5:
    inc matchedWhiteBalls                   		; increment the number of matched white balls found when match is found

	checkYellowBall:
		mov eax, userPicks.yellowBall           ; move the users yellow ball number into eax
        cmp eax, winningPicks.yellowBall    		; compare users yellow ball to winning yellow ball
        je incrementYellowCount             		; if users yellow ball = winning yellow ball, jump to increment yellow count
        jmp printOutcome

    incrementYellowCount:
        mov yellowBallMatch, 1              		; move 1 into yellow ball match signifying user guessed yellow ball correct

printOutcome:

	; case 1: 0 white ball, 0 yellow
	.IF(matchedWhiteBalls == 0 && yellowBallMatch == 0)
	mWriteLn 'You have matched 0 white numbers but not the yellow number. Your ticket wins $0!'
	.ENDIF
	
	 ;case 2: 0 white ball, 1 yellow
	.IF(matchedWhiteBalls == 0 && yellowBallMatch == 1)
	mWriteLn 'You have matched 0 white numbers and the yellow number. Your ticket wins $2!'
	.ENDIF

	; case 3: 1 white ball, 0 yellow
	.IF(matchedWhiteBalls == 1 && yellowBallMatch == 0)
	mWriteLn 'You have matched 1 white numbers but not the yellow number. Your ticket wins $0!'
	.ENDIF

	 ; case 4: 1 white ball, 1 yellow
	.IF(matchedWhiteBalls == 1 && yellowBallMatch == 1)
	mWriteLn 'You have matched 1 white numbers and the yellow number. Your ticket wins $4!'
	.ENDIF

	; case 5: 2 white ball, 0 yellow
	.IF(matchedWhiteBalls == 2 && yellowBallMatch == 0)
	mWriteLn 'You have matched 2 white numbers but not the yellow number. Your ticket wins $0!'
	.ENDIF

	; case 6: 2 white ball, 1 yellow
	.IF(matchedWhiteBalls == 2 && yellowBallMatch == 1)
	mWriteLn 'You have matched 2 white numbers and the yellow number. Your ticket wins $10!'
	.ENDIF

	; case 7: 3 white ball, 0 yellow
	.IF(matchedWhiteBalls == 3 && yellowBallMatch == 0)
	mWriteLn 'You have matched 3 white numbers but not the yellow number. Your ticket wins $10!'
	.ENDIF

	; case 8: 3 white ball, 1 yellow
	.IF(matchedWhiteBalls == 3 && yellowBallMatch == 1)
	mWriteLn 'You have matched 3 white numbers and the yellow number. Your ticket wins $200!'
	.ENDIF

	; case 9: 4 white ball, 0 yellow
	.IF(matchedWhiteBalls == 4 && yellowBallMatch == 0)
	mWriteLn 'You have matched 4 white numbers but not the yellow number. Your ticket wins $500!'
	.ENDIF

	; case 10: 4 white ball, 1 yellow
	.IF(matchedWhiteBalls == 4 && yellowBallMatch == 1)
	mWriteLn 'You have matched 4 white numbers and the yellow number. Your ticket wins $10,000!'
	.ENDIF

	; case 11: 5 white ball, 0 yellow
	.IF(matchedWhiteBalls == 5 && yellowBallMatch == 0)
	mWriteLn 'You have matched 5 white numbers but not the yellow number. Your ticket wins $1,000,000!'
	.ENDIF

	; case 12: 5 white ball, 1 yellow
	.IF(matchedWhiteBalls == 5 && yellowBallMatch == 1)
	mWriteLn 'You have matched 5 white numbers and the yellow number. Your ticket wins the Jackpot!'
	.ENDIF	

	jmp testingProc							  ; used for testing purposes

exit
main endp

; added this sub proc for testing purposes
testingProc proc
	mov matchedWhiteBalls, 0
	mov yellowBallMatch, 0
	call crlf
	jmp main
testingProc endp

printDuplicates proc
	duplicateNumber		; call duplicate number macro
	ret
printDuplicates endp

end main
