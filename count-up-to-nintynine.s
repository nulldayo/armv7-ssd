.syntax unified

.global _start
_start:
	mov r0, #0							@ Offset for Pointer
	ldr r1, =DIGITTABLE					@ Pointer for digittable
	ldr r2, =0xff200020					@ Address of the seven-segment display (memory-mapped IO)
	mov r3, #0							@ Counter for first digit
	mov r4, #1							@ Counter for second digit
	mov r5, #0							@ Counter for delay function
	mov r6, #0							@ Temporary register

loop:
	ldrb r3, [r1, r0]
	lsr r6, #8
	lsl r6, #8
	add r6, r6, r3
	str r6, [r2]
	
@	bl delay
	add r0, r0, #1
	cmp r0, #10
	bne loop
	
	ldrb r6, [r1, r4]
	add r4, r4, #1
	cmp r4, #10
	movgt r4, #0
	lsl r6, #8
	
	mov r0, #0
	ldrb r3, [r1, r0]
	add r6, r6, r3
	
	str r6, [r2]
	b loop
	
@delay:
@        ldr r5,=1000000				@ Duration of delay in iterations
@delay_loop:
@        cmp r5, #0
@        beq delay_done
@        sub r5,r5, #1
@        b delay_loop
@delay_done:
@        bx lr							@ Return from function call 

.type DIGITTABLE,%object
DIGITTABLE:
	.byte 0b00111111					@ 0x3F
	.byte 0b00000110					@ 0x06
	.byte 0b01011011					@
	.byte 0b01001111
	.byte 0b01100110
	.byte 0b01101101
	.byte 0b01111101
	.byte 0b00000111
	.byte 0b01111111
	.byte 0b01101111
DIGITTABLEEND: