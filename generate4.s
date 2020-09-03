		.global generate4

generate4:	push	{R1-R12}		@ Save contents of registers R1 through R12
		mov	R3,R0			@ R3 will hold a copy of binary value to be displayed.
		mov	R4,#1			@ Used to mask off 1 bit at a time
		and	R8,R4,R3,lsr #0		@ Store D0 in R8
		and	R9,R4,R3,lsr #1		@ Store D1 in R9
		and	R10,R4,R3,lsr #2	@ Store D2 in R10
		and	R11,R4,R3,lsr #3	@ Store D3 in R11

		eor	R12,R8,R11		@ Check if the value of D0 and D3 is even and store the result in the place of the first parity bit
		eor	R12,R12,R10		@ Check if the current value of the first parity bit and D2 is even and determine the final value of the first parity bit
		cmp	R12,#0			@ Check if the the value of the first parity bit is 0
		addne	R5,#0b1			@ If the value of the first parity bit is not 0, add 1 to R5

		eor	R12,R10,R11		@ Check if the value of D2 and D3 is even and store the result in the place of the second parity bit
		eor	R12,R12,R9		@ Check if the current value of the second parity bit and D1 is even and determine the final value of the second parity bit
		cmp	R12,#0			@ Check if the the value of the second parity bit is 0
		addne	R5,#0b10		@ If the value of the second parity bit is not 0, add 2 to R5

		eor	R12,R8,R11		@ Check if the value of D0 and D3 is even and store the result in the place of the third parity bit
		eor	R12,R12,R9		@ Check if the current value of the third parity bit and D1 is even and determine the final value of the third parity bit
		cmp	R12,#0			@ Check if the the value of the third parity bit is 0
		addne	R5,#0b100		@ If the value of the third parity bit is not 0, add 4 to R5

		add	R0,R5,lsl #4		@ Shift the parity bits by 4 to the left and store it in front of the original value

		pop	{R1-R12}		@ Restore saved register contents
		bx	LR			@ Return to the calling program
		
		.end
