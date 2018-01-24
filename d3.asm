BITS 16

;; Meg Ryan
;; Jan 22nd, 2017

start:
		;; PRELUDE  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        cli ; turn off interrupts for the prelude
			; if interrupts are on, a hardware device
			; could alter a register and prevent the
			; computer from booting any further

        mov ax, 07C0h  	; this moves the number 07c0h (where the bootloader starts) into the ax register,
        				; starting the program at the address 07c0h
        mov ds, ax      ; this copies the contents of ax into ds,
        				; putting the start of the data segment (ds) at segment 07c0h

        add ax, 0020h  	; this adds the number 0020h to the contents of ax,
        mov ss, ax      ; and then copies the new contents of ax into ss.
        				; this puts the start of the stack segment (ss) at segment number 07c0h + 0020h

        mov sp, 1000h   ; this sets the stack pointer (sp) to 1000h,
        				; meaning the top of the stack is now 1000h bytes past the start of the stack segment,
        				; thus allocating 100h bytes for the stack

        sti             ; turn the interrupts back on

		;; BEGINNING of DAILY 3 ASSIGNMENT ;;;;;;;;;;;;;;;;;;;;
		; reference https://en.wikipedia.org/wiki/INT_16H

		promptloop:

			mov ah, 0	; move 0 into the ah register for below
			int 16h		; when ah=0 (according to table at link above),
						; 16h reads irq from keyboard input and stores it in al register

			cmp al, 0h	; check if return key is hit, if yes, set zf flag=1, otherwise =0
			je .promptloopexit	; jump to .promptloopexit if al register is null (zf=1)
								; otherwise do nothing

			mov ah, 0Eh	; denote teletype mode
			int 10h		; prints contents of al register, which has just been set by 16h

			jmp promptloop		; loop and continue writing along same line
		.promptloopexit:
		int 10h		; print newline and continue accepting input
		ret

	jmp $

	; the lines below are nasm (the assembler) directives, NOT x86 instructions
	; they tell nasm to fill the rest of the space from our
	; current location to 510 bytes with zeros
	; then set the last two bytes (dw = define word) to AA55
	; this is by convention, since the firmware validates the bootloader
	; by reading the last two bytes and confirming that they are AA55
	; the firmware will not execute the bootloader without it
	times 510-($-$$) db 0
	dw 0xAA55	; BIOS looks for AA55 at the end of the sector

