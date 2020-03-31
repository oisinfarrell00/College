	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011 -- 2019.

	EXPORT	start
start

IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
IO1PIN	EQU	0xE0028010		; address of pins (leds)
	

		ldr	r1,=IO1DIR
		ldr	r2,=0x000f0000	; select P1.19--P1.16
		str	r2,[r1]			; make them outputs
		ldr	r1,=IO1SET		; r1 points to the SET register
		str	r2,[r1]			; set them to turn the LEDs off
		ldr	r2,=IO1CLR		; r2 points to the CLEAR register
		ldr r8, =0			; init input val to 0
		ldr r9, =0			; init answer val to 0
		ldr r10, =0			; flag to say first input made (1 for made)
		ldr r11, =0			; inc/ dec value flag
		ldr	r12, =-1
wloop	bl pins				; branch w/ link to pins sub
		mov r5, r0
		cmp	r11, #1
		beq	inc
		cmp r5, #0x0
		beq	wloop
inc		str	r3, [r1]		; set the bit -> turn off the LED
		cmp r5, #0x00000008 ; rightmost button pressed (increment no)
		beq inc_sub
		cmp r5, #0x00000004	; 2nd right button pressed (decrement no)
		beq dec_sub	
ops		cmp r5, #0x00000002	; 2nd left button pressed (+)
		beq add_sub
		cmp r5, #0x00000001	; leftmost button pressed (-)
		beq sub_sub
cont	b	dis_sub
next	b	wloop

stop	b	stop

; increment sub - increments inputted value (r8)
inc_sub	ldr	r11, =1
		add r8, r8, #1		; increment inputted value
		cmp r8, #16			; no input values > 15
		bne incEnd	
		ldr r8, =0			; reset input if > 15
incEnd	b	ops

; decrement sub - decrements inputted value (r8)
dec_sub	ldr	r11, =1
		sub r8, r8, #1		; decrement inputted value
		cmp r8, #-1			; no negative input vals
		bne decEnd
		ldr r8, =0			; reset input if < 0
decEnd	b	ops

; addition sub - performs addition operation
add_sub	ldr	r11, =0
		add r9, r9, r8		; pushing inputted value into answer
		ldr r8, =0			; reset input value
		b	dis_ans
		
; subtract sub - performs subtraction operation
sub_sub	ldr	r11, =0
		cmp	r10, #1
		beq	jump
		mov	r9, r8
		b	over
jump	sub r9, r9, r8		; pushing inputted value into answer
over	ldr r8, =0			; reset input value
		b	dis_ans
		
; display sub - visualisation of inputted number
dis_sub	mov r3, r8
		bl	rev_sub
		mov	r3, r0			; move answer from rev sub to r3
		mov r3, r3, lsl #16
		str r3, [r2]		; display on leds
		ldr	r4, =2000000	; delay for about a half second
dloop	subs r4, r4, #1
		bne	dloop
		str	r3, [r1]		; set the bit -> turn off the LED
		b	next
		
; display answer sub - flashes the answer to the leds for ~2 secs
dis_ans	cmp	r10, #1
		bne	skip
		;cmp r9, #0			; check if negative
		;bge	not_neg
		;mul	r12, r9, r12
		;orr r12, r12, #0x8
		;mov	r3, r12
		;ldr	r12, =-1
		;b	go
not_neg	mov	r3, r9			
go		bl	rev_sub
		mov	r3, r0			; move answer from rev sub to r3
		mov r3, r3, lsl #16
		str r3, [r2]		; display on leds
skip	ldr r10, =1			; flag set 
		b	next
		
; reverse sub - reverses bits in r3, returns in r0
rev_sub	push{r3-r4, lr}
		ldr	r0, =0			; init returned val
		ldr r4, =0			; init counter
rloop	movs r3, r3, lsr #1
		adc	r0, r0, #0
		add r4, r4, #1
		cmp	r4, #4			
		bge	rev_fin
		mov	r0, r0, lsl #1
		b	rloop
rev_fin	pop{r3-r4, pc}

; pins sub - returns value in r0
pins	push{r3-r4, lr}
		ldr	r3,=IO1PIN		; start with P1.16.
		ldr r3, [r3]		; loading the memory add in r3
		mvn r3, r3
		ldr r4, =0x00f00000
		and r3, r3, r4
		mov r0, r3, lsr #20	; select the right bits
		pop{r3-r4, pc}
		
		END