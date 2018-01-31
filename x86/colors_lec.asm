BITS 16

start:

	; the prelude: set up the data and stack segments
	cli	
	mov ax, 07C0h
	mov ds, ax
	add ax, 0020h
	mov ss, ax
	mov sp, 1000h
	sti	

	mov si, thestring
	lodsb
	lodsb

	
	call foo

	jmp $

foo:
	mov ah, 0Eh
	mov bh, 0h
	mov bl, 0h
	int 10h
	ret

	thestring db 'mcduck', 0

	times 510-($-$$) db 0
	dw 0xAA55	; BIOS looks for AA55 at the end of the sector

