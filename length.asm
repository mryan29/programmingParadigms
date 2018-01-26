;; JAN24 NOTES

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

	mov si, msg	; move some string into si
	call length ; call length func
	
	; still need to print length when we are done
	; this method below would interpret dh as an ascii character
	mov ah, 0EH
	mov al, dh
	int 10h	


	jmp $	; just loops around around around
			; function goes after bc if it was before, the function would just run without
			; ever having to call it - huge bug
			; structure of program


;; PROCEDURE AREA - LENGTH FUNCTION ;;;;;;;;;;
length:
	mov dh, 0
.loop1:
	lodsb
	cmp al, 0h ; check if each char is a 0
	je .exit1
	inc dh		; dh is arbitrary, just picked a reg that we werent using
				; dh will eventually equal the length of the string
	jmp .loop1
.exit1:
	ret

	msg db 'hello', 0	; define string with a null byte at the end

	times 510-($-$$) db 0
	dw 0xAA55	; BIOS looks for AA55 at the end of the sector
