.syntax unified

.global _start
_start:
	ldr r1, =DIGITTABLE
	ldr r2, =0xff200020				@ Address of the seven-segment display (memory-mapped IO)
	
again:
	mov r0, #0

loop:
	ldrb r3, [r1, r0]
	str r3, [r2]
	bl delay
	add r0, r0, #1
	cmp r0, #10

	bne loop
	b again
	
delay:
        ldr r4,=1000000				@ Duration of delay in iterations
delay_loop:
        cmp r4, #0
        beq delay_done
        sub r4,r4, #1
        b delay_loop
delay_done:
        bx lr						@ Return from function call 

.type DIGITTABLE,%object
DIGITTABLE:
	.byte 0b00111111				@ 0x3F
	.byte 0b00000110
	.byte 0b01011011
	.byte 0b01001111
	.byte 0b01100110
	.byte 0b01101101
	.byte 0b01111101
	.byte 0b00000111
	.byte 0b01111111
	.byte 0b01101111
DIGITTABLEEND:
	