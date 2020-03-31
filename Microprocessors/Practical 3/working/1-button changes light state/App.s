	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011 -- 2019.

	EXPORT	start
start

IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
IO1PIN	EQU 0xE0028010		;address of pins (leds)
	

		ldr	r1,=IO1DIR
		ldr	r2,=0x000f0000	; select P1.19--P1.16
		str	r2,[r1]			; make them outputs
		ldr	r1,=IO1SET		; r1 points to the SET register
		str	r2,[r1]			; set them to turn the LEDs off
		ldr	r2,=IO1CLR		; r2 points to the CLEAR register
		
		ldr r8, =0			; set first val to 0
		ldr r9, =0			; set second val to 0
		ldr r10, =0x00f00000; mask to get rid of non button info 
		
wloop	bl pins				; branch w/ link to pins sub
		mov r3, r0			; move returned value into r3
		str r3, [r2]		; storing whats in r3 to the memory add of r2
		
		ldr	r4,=2000000		; delay for about a half second
dloop	subs r4, r4, #1
		bne	dloop
		
		str	r3, [r1]		; set the bit -> turn off the LED
		b	wloop
		
stop	b	stop

; pins subroutine 
; params: r3 - address of pins (buttons)
; retuns: value in r0
pins	push{r3, lr}
		ldr	r3,=IO1PIN		; start with P1.16.
		ldr r3, [r3]		; loading the memory add in r3
		mov r3, r3, lsr #4	; select the right bits
		mov r0, r3			; move value into return param
		pop{r3, pc}

		END