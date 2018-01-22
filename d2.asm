BITS 16

;; Meg Ryan
;; Jan 22nd, 2017


; purpose of the prelude: set up the data and stack segments for waking up the operating system
; binary file will be 512 bytes long bc bootloaders will all be 512 bytes


start:
        cli             ; turn off interrupts for the prelude
			; if interrupts are on, a hardware device
			; could alter a register and prevent the
			; computer from booting any further

        mov ax, 07C0h   ; this moves the number 07c0h (where the bootloader starts) into the ax register,
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


;		move si, thestring ; remember si is source index
						; takes whereever this location is and takes that mem address of thestring and puts that addr into 
						; si reguister
;		lodsb ; load stored byte: copies from mem lctn ds:si (segment:offset) offset from strt of location set in prelude
;		lodsb ; should display C, one before this should display m

		;talking abuot functions, reference https://en.wikipedia.org/wiki/BIOS_interrupt_call
		mov ah, 0Eh ; sets function code to teletype mode according to table for ah=0eh
		mov al, 43h ; al is char register, 43h is ASCII for 'C'
		mov bh, 0h	; bh is page number, which we want to be 0
		mov bl, 0h
		int 10h		; issue interrupt
		mov al, 44h ; adds a D after the C
		int 10h ; int is a (BiOS?) *software interrupt*: tells cpu to stop and go do something else (whatever is at 10h)
				; *interrupt vector table*: cpu looks here and sees 10h is the *interrupt vector*
				; 10h -> mem location (i.e. dx...
				; 11h -> mem location
				; 12h -> memlocation

;		jmp foo


; doing a loop
;.loopstart:
;	cmp al, 0h ; first part of loop, given a register and val (0h checks for null byte) sets zf to 0 if true 1 if false
;	je .loopexit ; jump equals: if zf=1, jumps there
;.loopexit:

;	call foo ; takes current instruction location and puts it on stack and then jumps to that location and executes
	jmp $

;	foo: ; what does having a . infront of foo do? something about it being a function? and when you do jmp above?

	mov ah, 0Eh
	mov bh, 0h
	mov bl, 0h
	int 10h
	ret ; pull off stack and jump back to that instruction


;	thestring db 'mcduck', 0
	; db is directive to assembler to define bytes, puts this mcduck at end of program



	; the lines below are nasm (the assembler) directives, NOT x86 instructions
	; they tell nasm to fill the rest of the space from our
	; current location to 510 bytes with zeros
	; then set the last two bytes (dw = define word) to AA55
	; this is by convention, since the firmware validates the bootloader
	; by reading the last two bytes and confirming that they are AA55
	; the firmware will not execute the bootloader without it
	times 510-($-$$) db 0
	dw 0xAA55	; BIOS looks for AA55 at the end of the sector

