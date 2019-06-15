title findQuadraticFormula (findQuadraticFormula.asm)

; Name: Brandon Hough
; CPEN 3710-0
; Date: November 14, 2018

; This program calculates the root(s) of a quadratic function.

; import Irvine32 library
include Irvine32.inc

; import macro library
include Macros.inc

.data

    varA real4 ?                ; variable to store a
    varB real4 ?                ; variable to store b
    varC real4 ?                ; variable to store c

    setNum real4 4.0            ; variable to store set value of '4' used in quadratic equation
    setNum2 real4 2.0           ; variable to store set value of '2' used in quadratic equation

    determinate real4 ?         ; variable to store the determinate

    root1 real4 ?               ; variable to store the first root
    root2 real4 ?               ; variable to store the second root

.code

; ---------------------------------------------------------------------
; This main procedure calcluates  the roots or root of a quadratic equation
; Recieves: float values for a, b, c, as well as root1ptr and root2ptr 
; which holds the address of where the roots will be stored in memory
; Returns: eax, if eax = -1, complex number is found
;                else if eax = 1, no complex number is found
; Modifies: eax, ebx, and ecx

calculateQuadFormula  proc c 
	int 3
    push ebp                    ; save the base pointer on the stack
    mov ebp, esp                ; set the base pointer equal to stack pointer

    mov eax, [ebp + 8]          ; grab value 'a' from the stack
    mov varA, eax               ; move the 'a' value into a variable varA
   
    mov ebx, [ebp + 12]         ; grab value 'b' from the stack
    mov varB, ebx               ; move the 'b' value into a variable varB

    mov ecx, [ebp + 16]         ; grab value 'c' from the stack
    mov varC, ecx               ; move the 'c' value into a variable varC

calculateDeterminant:
    fld varB                    ; push B onto FPU register stack
    fld varB                    ; push B onto FPU register stack
	fmul                    ; calculates B^2 and stores answer in ST(0)
		
    fld varA                    ; push A onto FPU register stack
    fld varC                    ; push C onto FPU register stack
    fmul                        ; multiply (a)(c) and stores answer in ST(0)
							    ; ST(1) will contain B^2 now

    fld setNum                  ; push setNum onto FPU register stack (setNum = 4)
    fmul                        ; calculates 4(a)(c) and stores answer in ST(0) 

    fsub                        ; result in ST(0) will store (B^2 - 4(a)(c))

    fstp determinate            ; pop ST(0) off of FPU register stack and store 
                                ; determinate into a variable

	;fstp edx
      
    cmp determinate, 0          ; compare determinate to 0
    jl complexRoots             ; if the determinate is complex jump to complexRoots label
                                ; else go to calculateRoots label

calculateRoots:
    fld determinate             ; push determinate onto the stack
	fsqrt                   ; calcualte the square root of determinate
                                ; ST(0) stores sqrt(determinate)

    fld varB                    ; push varB to the FPU stack, ST(0)
                                ; ST(0) stores sqrt(determinate)
                              
    fchs                        ; flip the sign of varB in ST(0) (-b)

    fadd                        ; calculates (-b) + sqrt(determinate), answer in ST(0)

    fld setNum2                 ; push setNum2 onto FPU register stack (setNum2 = 2)
    fld varA                    ; push a to the FPU regiser stack 
    fmul                        ; calculate 2(a) answer will be in ST(0)
                                ; ST(0) stores numerator 
    
    fdiv                        ; divide numerator by denominator, answer stored in ST(0)

    fstp root1                  ; pop ST(0) off the FPU register stack and store root1 into a variable

    mov eax, root1              ; move root1 into eax register
    mov edi, [ebp + 20]         ; have edi point to where root1ptr is in memeory
    mov [edi], eax		; store root1 into the address of root1ptr 

    fld varB                    ; push varB to the FPU stack, ST(0)
                     
    fchs                        ; flip the sign of varB in ST(0)

    fld determinate             ; push determinate onto the stack
	fsqrt                   ; calcualte the square root of determinate

    fsub                        ; calculates (-b) - sqrt(determinate)

    fld setNum2                 ; push setNum2 onto FPU register stack (setNum2 = 2)
    fld varA                    ; push a to the FPU regiser stack 
    fmul                        ; calculate 2(a) answer will be in ST(0)
                                ; ST(1) stores numerator 
    
    fdiv                        ; divide numerator by denominator, answer stored in ST(0)

    fstp root2                  ; pop ST(0) off the FPU register stack and store root2 into a variable

    mov eax, root2              ; move root2 into eax register
    mov edi, [ebp + 24]         ; have edi point to where root2ptr is in memeory
    mov [edi], eax		; store root2 into the address of root2ptr

    mov eax, 0                  ; move 0 to eax since the input was not a complex number                  

    jmp dummy                   ; jump to dummy since we did not have a complex number

complexRoots:   
    mov eax, -1                 ; move -1 to eax since the input was a complex number  

dummy:
    mov esp, ebp                ; restore stack pointer
    pop ebp                     ; restore base pointer
    ret                         ; return to cpp program

calculateQuadFormula endp
end
