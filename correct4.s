	    .global correct4

correct4:   push    {R1-R12}            @ Save contents of registers R1 through R12

	    mov     R1,#1		@ Used to mask off 1 bit at a time
            and     R2,R1,R0,lsr #0     @ Store D0 in R2
            and     R3,R1,R0,lsr #1     @ Store D1 in R3
            and     R4,R1,R0,lsr #2     @ Store D2 in R4
            and     R5,R1,R0,lsr #3     @ Store D3 in R5
            and     R6,R1,R0,lsr #4     @ Store first parity bit in R6
            and     R7,R1,R0,lsr #5     @ Store second parity bit in R7
            and     R8,R1,R0,lsr #6     @ Store third parity bit in R8
            mov     R0,#0               @ Reset R0 value to 0

            eor     R9,R6,R5            @ First XOR operation inside "Even_Parity_4" for part A between first parity bit and D3
            eor     R9,R4               @ Second XOR operation inside "Even_Parity_4" for part A between the result of the first XOR operation and D2
            eor     R9,R2               @ Third XOR operation inside "Even_Parity_4" for part A between the result of the second XOR operation and D0

            eor     R10,R7,R5           @ First XOR operation inside "Even_Parity_4" for part B between second parity bit and D3
            eor     R10,R4              @ Second XOR operation inside "Even_Parity_4" for part B between the result of the first XOR operation and D2
            eor     R10,R3              @ Third XOR operation inside "Even_Parity_4" for part B between the result of the second XOR operation and D1

            eor     R11,R8,R5           @ First XOR operation inside "Even_Parity_4" for part C between third parity bit and D3
            eor     R11,R4              @ Second XOR operation inside "Even_Parity_4" for part C between the result of the first XOR operation and D2
            eor     R11,R2              @ Third XOR operation inside "Even_Parity_4" for part C between the result of the second XOR operation and D0

            cmp     R10,#0              @ Check if the result of R10 is 0, because first AND operation requires R10 to be inversed
            moveq   R6,#1               @ If R10 is 0, change the value of R6 to be the inverse value of R10, in this case 1
            movne   R6,#0               @ If R10 is 1, change the value of R6 to be the inverse value of R10, in this case 0
            and     R6,R9               @ First AND operation inside the first AND gate
            and     R6,R11              @ Second AND operation inside the first AND gate
            eor     R2,R6               @ XOR operation to determine the value of D0
            cmp     R2,#1               @ Check if the result of XOR operation is 1
            addeq   R0,#0b1             @ If the result of XOR operation is 1, add 1 to R0

            cmp     R9,#0               @ Check if the result of R9 is 0, because second AND operation requires R9 to be inversed
            moveq   R7,#1               @ If R9 is 0, change the value of R7 to be the inverse value of R9, in this case 1
            movne   R7,#0               @ If R9 is 1, change the value of R7 to be the inverse value of R9, in this case 0
            and     R7,R10              @ First AND operation inside the second AND gate
            and     R7,R11              @ Second AND operation inside the second AND gate
            eor     R3,R7               @ XOR operation to determine the value of D1
            cmp     R3,#1               @ Check if the result of XOR operation is 1
            addeq   R0,#0b10            @ If the result of XOR operation is 1, add 2 to R0

            cmp     R11,#0              @ Check if the result of R11 is 0, because first AND operation requires R11 to be inversed
            moveq   R8,#1               @ If R11 is 0, change the value of R8 to be the inverse value of R11, in this case 1
            movne   R8,#0               @ If R11 is 1, change the value of R8 to be the inverse value of R11, in this case 0
            and     R8,R10              @ First AND operation inside the third AND gate
            and     R8,R9               @ Second AND operation inside the third AND gate
            eor     R4,R8               @ XOR operation to determine the value of D2
            cmp     R4,#1               @ Check if the result of XOR operation is 1
            addeq   R0,#0b100           @ If the result of XOR operation is 1, add 4 to R0

            and     R12,R9,R10          @ First AND operation inside the fourth AND gate
            and     R12,R11             @ Second AND operation inside the fourth AND gate
            eor     R5,R12              @ XOR operation to determine the value of D3
            cmp     R5,#1               @ Check if the result of XOR operation is 1
            addeq   R0,#0b1000          @ If the result of XOR operation is 1, add 8 to R0

		

	    pop	    {R1-R12}	        @ Restore saved register contents
	    bx	    LR			@ Return to the calling program
		
	    .end