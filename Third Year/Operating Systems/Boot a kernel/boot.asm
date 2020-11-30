	bits 16

start:
	mov ax, 0x07C0		; 0x07C0 is where we are
	add ax, 0x20		; add 0x20 (when shifted 512)
	mov ss, ax		; set the stack segment
	mov sp, 0x1000		; set the stack pointer

	mov ax, 0x07C0
	mov ds, ax

	mov si, msg		; pointer to message
	mov ah, 0x0E

.next:
	lodsb
	cmp al, 0
	je  .done
	int 0x10
	jmp .next

.done:
	jmp $

msg:	 db 'Hello', 0

	times 510-($-$$) db 0
	dw 0xAA55
