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

		;; BEGINNING OF DAILY 2 ASSIGNMENT ;;;;;;;;;;;;;;;;;;;;;;;
		; reference https://en.wikipedia.org/wiki/BIOS_interrupt_call

		; print 'C'
		mov ah, 0Eh ; sets function code to teletype mode according to table for ah=0eh
		mov al, 43h ; al is char register, 43h is ASCII for 'C'
		mov bh, 0h	; bh is page number, which we want to be 0
		int 10h		; issue interrupt

		; print 'D'
		mov al, 44h ; adds a D after the C
		int 10h ; int is a (BIOS) *software interrupt*: tells cpu to stop and go do something else (whatever is at 10h)
				; *interrupt vector table*: cpu looks here and sees 10h is the *interrupt vector*


		mov si, thestring	; point the register si to the string we want to print
		call print			; call instruction causing the CPU to execute instructions
							; at the given label until the ret instruction is hit
							; call puts the current instruction pointer on the stack before
							; it goes to the label
							; ret restores the instruction pointer by reading it from the stack
	jmp $

	;; START OF PROCEDURE AREA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; start of procedure print
	print:
		; set function code to teletype, to prepare for software interrupt
		mov ah, 0Eh
		; loop until we receive null byte
		loop:
			; load byte from DS:SI into the a register
			lodsb 			; copies a byte in mem at address DS:SI into al register
			; check if that register is null or not
			cmp al, 0h		; sets status flag ZF to 1 if values are equal, otherwise sets ZF to 0
			; if null, jump to exit label. else, issue interrupt 10h to print it, then go back to loop label
			je .loopexit	; jumps to .loopexit if at register is null
			int 10h			; issue interrupt to print it
			jmp loop
		.loopexit:
		ret ; ret is CPU instruction for 'return'
	; end of procedure print
	;; END OF PROCEDURE AREA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	;; START OF DATA AREA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	thestring db 'mcduck', 0 ; thestring is name for area of mem defined by db
								; recall db="define byte" to nasm assembler, not CPU
	;; END OF DATA AREA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; the lines below are nasm (the assembler) directives, NOT x86 instructions
	; they tell nasm to fill the rest of the space from our
	; current location to 510 bytes with zeros
	; then set the last two bytes (dw = define word) to AA55
	; this is by convention, since the firmware validates the bootloader
	; by reading the last two bytes and confirming that they are AA55
	; the firmware will not execute the bootloader without it
	times 510-($-$$) db 0
	dw 0xAA55	; BIOS looks for AA55 at the end of the sector

