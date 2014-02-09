;-------------
; Currently a standalone file
; TODO: Display for changing 4 variables, change variable names to fit main.asm
;
;-------------

; ----------------------
;| CODE FOR LCD DISPLAY |
; ----------------------
Wait40us:
	mov R0, #149
Wait40us_L0: 
	nop
	nop
	nop
	nop
	nop
	nop
	djnz R0, Wait40us_L0 ; 9 machine cycles-> 9*30ns*149=40us
    ret
		
LCD_command:
	mov LCD_DATA, a
	clr LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr LCD_EN
	lcall wait40us
	ret
	
LCD_put:
	mov LCD_DATA, a
	setb LCD_RS
	nop
	nop
	setb LCD_EN
	nop
	nop
	nop
	nop
	nop
	nop
	clr LCD_EN
	lcall wait40us
	reti
	
start_LCD:
	setb LCD_ON
	clr LCD_EN
	lcall wait40us
	mov LCD_MOD,#0FFH
	
	clr LCD_RW
	mov a, #0ch ; Display on command
	lcall LCD_command
	mov a, #38H ; 8-bits interface, 2 lines, 5x7 characters
	lcall LCD_command
clear_screen:
	push acc
	push AR1
	mov a, #01H ; Clear screen (Warning, very slow command!)
	lcall LCD_command
    
    ; Delay loop needed for 'clear screen' command above (1.6ms at least!)
    mov R1, #40
Clr_loop:
	lcall Wait40us
	djnz R1, Clr_loop
	pop AR1
	pop acc
	ret
; --------------------------
;| END CODE FOR LCD DISPLAY |
; --------------------------

; -----------------------------------------------------------------------------
;|   							 LCD DISPLAY MACROS							   |												
;| send_number: displays the HEX num         send_char: displays the ASCII char|
;| in the first argument, to position		 in the first argument to the pos. |
;| in second argument. Prints 1-3    	  	 in the second argument.		   |
;| digits based on 3rd argument.											   |
;| Automatically prints spaces 												   |
;| instead of zeroes.(Except for LSD)										   |
; -----------------------------------------------------------------------------
LCD_send_number MAC (%0,%1,%2,%3) ; %0 is num, %1 is position, %2 is # of digits (1-3) sends an 8-bit number to LCD
	push Acc
	push psw
	mov bcd+1, #0
	mov a, %3
	cjne A, #0, space_%L
	clr spaces
	jz BCD%L
space_%L:
	setb spaces
	mov x, %0
	mov x+1, #0
	lcall hex2bcd
	sjmp LCD_Done%L
BCD%L:
	mov bcd, %0
	
LCD_Done%L:
	mov A, %1
	lcall LCD_command
	mov digits, %2
	lcall LCD_send_num
	
	pop psw
	pop Acc
ENDMAC

LCD_send_num:	
	mov A, digits
	clr c
	subb A, #1
	jz LCD_send_number_L0 ;only 1 digit, so display without spaces
	mov A, digits
	clr c
	subb A, #2
	jz LCD_send_number_L3 ; 2 digits
	
	jnb spaces, LCD_send_number_L2
	mov A, bcd+1
	anl A, #0FH
	cjne A, #0, LCD_send_number_L2  ; jumps if BCD+1 is not zero
	mov A, #' '
	lcall LCD_put
	
LCD_send_number_L3:
	jnb spaces, LCD_send_number_L1
	mov A, bcd+0
	swap A
	anl A, #0FH
	cjne A, #0, LCD_send_number_L1  ; jumps if MSD of BCD+0 is not zero
	mov A, #' '
	lcall LCD_put
	
	sjmp LCD_send_number_L0
	
LCD_send_number_L2:
	mov A, bcd+1
	anl A, #0FH
	orl A, #30h
	lcall LCD_put
LCD_send_number_L1:
	mov A, bcd+0
	swap A
	anl A, #0FH
	orl A, #30h
	lcall LCD_put
LCD_send_number_L0:
	mov A, bcd+0
	anl A, #0FH
	orl A, #30h
	lcall LCD_put
	ret

LCD_send_character MAC (%0,%1) ; %0 is char, %1 is position
	push Acc
	mov A, %1
	lcall LCD_command
	mov A, #%0
	lcall LCD_put
	pop Acc
ENDMAC

; ---------------------
;| END LCD DISPLAY MAC |
; ---------------------

; -----------------------------------------------------
;|		     	DISPLAY_LCD FUNCTION                   |
;| A function that can be called in any state, and	   |
;| will put up the proper display depending on said    |
;| state.  (TODO: Display for changing the 4 values)   |
;| This function depends on the value of the variable  |
;| "state" as follows:								   |
;| state=0  => IDLE									   |
;| state=1  => ACTIVATION							   |
;| state=2  => SOAKING								   |
;| state=3  => RAMPUP								   |
;| state=4  => REFLOW								   |
;| state=5  => OPEN OVEN DOOR  (saw this from video,   |
;|             not sure if it should be a state)       |
;| state=6  => ACTIVATION                              |
;| NOTE: Do not call this function too often, or the   |
;| screen will refresh too fast and will be unreadable.|
; -----------------------------------------------------
	
Display_LCD: ;Display the common values among all the states
	LCD_send_character('T',#80H)
	LCD_send_character('o',#81H)
	LCD_send_character('=',#82H)
	LCD_send_number(temperature,#83H,#3, #1)
	LCD_send_character('C',#86H)
	
	mov a, tskSec
	jnz display_job_time
	mov a, tskMin
	jnz display_job_time
	
	LCD_send_character('T',#89H)
	LCD_send_character('j',#8AH)
	LCD_send_character('=',#8BH)
	LCD_send_number(desiredTemp,#8CH,#3, #1)
	LCD_send_character('C',#8FH)
	ret
	
Display_job_time:
	LCD_send_number(tskMin, #89H, #1, #0)
	LCD_send_character(':',#8AH)
	LCD_send_number(tskSec, #8BH, #2, #0)
	ret
	
Display_LCD_L0: ;idle state
	LCD_send_character('S',#080H)
	LCD_send_character('o',#081H)
	LCD_send_character('a',#082H)
	LCD_send_character('k',#083H)
	LCD_send_character(':',#084H)
	LCD_send_number(soakTemp,#086H,#3, #1)
	LCD_send_character('C',#089H)
	LCD_send_number(soakTimeMin, #08Bh, #1, #0)
	LCD_send_character(':',#08CH)
	LCD_send_number(soakTimeSec,#08DH,#2, #0)
	
	LCD_send_character('R',#0C0H)
	LCD_send_character('f',#0C1H)
	LCD_send_character('l',#0C2H)
	LCD_send_character('w',#0C3H)
	LCD_send_character(':',#0C4H)
	LCD_send_number(reflowTemp,#0C6H,#3, #1)
	LCD_send_character('C',#0C9H)
	LCD_send_number(reflowTimeMin, #0CBh, #1, #0)
	LCD_send_character(':',#0CCH)
	LCD_send_number(reflowTimeSec,#0CDH,#2, #0)
	ret
	
Display_LCD_DOOR: ;OPEN OVEN DOOR
	LCD_send_character('O',#0C1H)
	LCD_send_character('p',#0C2H)
	LCD_send_character('e',#0C3H)
	LCD_send_character('n',#0C4H)
	LCD_send_character('O',#0C6H)
	LCD_send_character('v',#0C7H)
	LCD_send_character('e',#0C8H)
	LCD_send_character('n',#0C9H)
	LCD_send_character('D',#0CBH)
	LCD_send_character('o',#0CCH)
	LCD_send_character('o',#0CDH)
	LCD_send_character('r',#0CEH)
	ret
	
Display_LCD_time: ; display the time, which is common among the next 5 states
	LCD_send_number(uniMin, #0C0h, #1, #0)
	LCD_send_character(':',#0C1H)
	LCD_send_number(uniSec,#0C2H,#3, #0)
	
Display_LCD_L1: ; ramp to soak
	LCD_send_character('S',#0C6H)
	LCD_send_character('o',#0C7H)
	LCD_send_character('a',#0C8H)
	LCD_send_character('k',#0C9H)
	LCD_send_character('R',#0CBH)
	LCD_send_character('a',#0CCH)
	LCD_send_character('m',#0CDH)
	LCD_send_character('p',#0CEH)
	ret
	
Display_LCD_L2: ; preheat/soak
	LCD_send_character('S',#0C6H)
	LCD_send_character('o',#0C7H)
	LCD_send_character('a',#0C8H)
	LCD_send_character('k',#0C9H)
	LCD_send_character('H',#0CBH)
	LCD_send_character('o',#0CCH)
	LCD_send_character('l',#0CDH)
	LCD_send_character('d',#0CEH)
	ret
	
Display_LCD_L3: ; ramp to peak
	LCD_send_character('R',#0C5H)
	LCD_send_character('e',#0C6H)
	LCD_send_character('f',#0C7H)
	LCD_send_character('l',#0C8H)
	LCD_send_character('o',#0C9H)
	LCD_send_character('w',#0CAH)
	LCD_send_character('R',#0CCH)
	LCD_send_character('a',#0CDH)
	LCD_send_character('m',#0CEH)
	LCD_send_character('p',#0CFH)
	ret
	
Display_LCD_L4: ; reflow
	LCD_send_character('R',#0C5H)
	LCD_send_character('e',#0C6H)
	LCD_send_character('f',#0C7H)
	LCD_send_character('l',#0C8H)
	LCD_send_character('o',#0C9H)
	LCD_send_character('w',#0CAH)
	LCD_send_character('H',#0CCH)
	LCD_send_character('o',#0CDH)
	LCD_send_character('l',#0CEH)
	LCD_send_character('d',#0CFH)
	ret
	
Display_LCD_L5: ; cooling
	LCD_send_character('C',#0C6H)
	LCD_send_character('o',#0C7H)
	LCD_send_character('o',#0C8H)
	LCD_send_character('l',#0C9H)
	LCD_send_character('i',#0CAH)
	LCD_send_character('n',#0CBH)
	LCD_send_character('g',#0CCH)
	ret

; --------------------------
;| END DISPLAY_LCD FUNCTION |
; --------------------------