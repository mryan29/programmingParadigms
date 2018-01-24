;; JAN 22 NOTES ;;;;;;;;;;;;;;;;;

; check piazza for example, rushed in class
; qewu : virtual machine
; monitor = way of accessing the backend of the vm
	; access dif mem vals, pause/stop machine
	; not an actual screen
	; xp /16xb 0x07C00
	; shows 16 bytes which are in mem at that location
	; binary image read in from binary file dropped in mem at that lctn
	;

; below code is built from colors_lec.asm

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

	mov cx, ss
	mov es, cx ; sets heap in same area as stack, uses ss as es
	mov si, 0h ; sets offset to 0 bc want to start at top of ss and grow downwards
	mov al, 44h
	stosb

	;; this code is used to wait for keyboard input, store in heap space, and display it
	; https://en.wikipedia.org/wiki/INT_16H
	mov ah, 0h ; 'read key press' = 0h from above link
	int 16h ; should read whatevers in buffer into al

	mov ah, 0Eh
	int 10h ; if buffer is empty, it will wait

	; on hw, will use these ingredients to write prompt into our mini os
	; will have os we cna put on usb and boot

	; code below prints a lower case c after getting input
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
