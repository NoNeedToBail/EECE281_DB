$MODDE2
org 0000H
	ljmp myprogram
	
DSEG at 30H
bcd:	ds 3
x:    ds 2
state:	ds 1
Temp_oven:	ds 1
Temp_junc:	ds 1
digits:		ds 1
s_temp:		ds 1
s_time:		ds 1
r_temp:		ds 1
r_time:		ds 1
time:		ds 1


CSEG

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
	mov a, #01H ; Clear screen (Warning, very slow command!)
	lcall LCD_command
    
    ; Delay loop needed for 'clear screen' command above (1.6ms at least!)
    mov R1, #40
Clr_loop:
	lcall Wait40us
	djnz R1, Clr_loop
	ret
; --------------------------
;| END CODE FOR LCD DISPLAY |
; --------------------------

; ----------------
;| HEX2BCD 16-BIT |
; ----------------
hex2bcd:
	push acc
	push psw
	push AR0
	
	clr a
	mov bcd+0, a ; Initialize BCD to 00-00-00 
	mov bcd+1, a
	mov bcd+2, a
	mov r0, #16  ; Loop counter.

hex2bcd_L0:
	; Shift binary left	
	mov a, x+1
	mov c, acc.7 ; This way x remains unchanged!
	mov a, x+0
	rlc a
	mov x+0, a
	mov a, x+1
	rlc a
	mov x+1, a
    
	; Perform bcd + bcd + carry using BCD arithmetic
	mov a, bcd+0
	addc a, bcd+0
	da a
	mov bcd+0, a
	mov a, bcd+1
	addc a, bcd+1
	da a
	mov bcd+1, a
	mov a, bcd+2
	addc a, bcd+2
	da a
	mov bcd+2, a

	djnz r0, hex2bcd_L0

	pop AR0
	pop psw
	pop acc
	ret

; -------------
;| END HEX2BCD |
; -------------
	
; -----------------------------------------------------------------------------
;|   							 LCD DISPLAY MACROS							   |												
;| send_number: displays the HEX num         send_char: displays the ASCII char|
;| in the first argument, to position		 in the first argument to the pos. |
;| in second argument. Prints 1-3    	  	 in the second argument.		   |
;| digits based on 3rd argument.											   |
;| Automatically prints spaces 												   |
;| instead of zeroes.(Except for LSD)										   |
; -----------------------------------------------------------------------------
LCD_send_number MAC (%0,%1,%2) ; %0 is num, %1 is position, %2 is # of digits (1-3) sends an 8-bit number to LCD
	push Acc
	push psw
	push AR0
	mov x, %0
	lcall hex2bcd
	
	mov A, %1
	lcall LCD_command
	mov digits, %2
	lcall LCD_send_num
	
	pop AR0
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
	
	mov A, bcd+1
	anl A, #0FH
	cjne A, #0, LCD_send_number_L2  ; jumps if BCD+1 is not zero
	mov A, #' '
	lcall LCD_put
	
LCD_send_number_L3:
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


Wait1s:
	mov R2, #180
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1 
	djnz R1, L2
	djnz R2, L3
	ret
	
myprogram:
	mov SP, #7FH
	clr a
	mov LEDRA, a
	mov LEDRB, a
	mov LEDRC, a
	mov LEDG, a
	lcall start_LCD
	mov temp_oven, #11 ;NOTE: the following 7 variables, in decimal, are just test values, their names and values are subject to change
	mov temp_junc, #0
	mov time, 	#50
	mov s_temp, #150
	mov s_time, #90
	mov r_temp, #210
	mov r_time, #45
	mov state, #3   ;change this for testing the states
forever:
	lcall Display_LCD
	mov A, time
	add A, #1
	mov time, A
	lcall wait1s
	sjmp forever
	
	
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
	lcall clear_screen
	LCD_send_character('T',#80H)
	LCD_send_character('o',#81H)
	LCD_send_character('=',#82H)
	LCD_send_number(temp_oven,#83H,#3)
	LCD_send_character('C',#86H)
	LCD_send_character('T',#89H)
	LCD_send_character('j',#8AH)
	LCD_send_character('=',#8BH)
	LCD_send_number(temp_junc,#8CH,#2)
	LCD_send_character('C',#8EH)
	
Display_LCD_L0: ;idle state
	mov A, state
	clr c
	subb A, #0  
	jz	display_LCD_L0_dontjump   ;too much offset must ljmp
	ljmp Display_LCD_L5
	
display_LCD_L0_dontjump:
	LCD_send_character('s',#0C0H)
	LCD_send_number(s_temp,#0C1H,#3)
	LCD_send_character(',',#0C4H)
	LCD_send_number(s_time,#0C5H,#2)
	LCD_send_character('r',#0C8H)
	LCD_send_number(r_temp,#0C9H,#3)
	LCD_send_character(',',#0CCH)
	LCD_send_number(r_time,#0CDH,#2)
	ret
	
Display_LCD_L5: ;OPEN OVEN DOOR (put here because it doesn't have the time display unlike the other states...)
	mov A, state
	clr c
	subb A, #5   
	jz	display_LCD_L5_dontjump   ;too much offset must ljmp
	ljmp Display_LCD_time
	
display_LCD_L5_dontjump:
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
	LCD_send_character('t',#0C0H)
	LCD_send_number(time,#0C1H,#3)
	
Display_LCD_L1: ; ramp to soak
	mov A, state
	clr c
	subb A, #1   
	jz	display_LCD_L1_dontjump   ;too much offset must ljmp
	ljmp Display_LCD_L2
	
display_LCD_L1_dontjump:
	LCD_send_character('A',#0C6H)
	LCD_send_character('c',#0C7H)
	LCD_send_character('t',#0C8H)
	LCD_send_character('i',#0C9H)
	LCD_send_character('v',#0CAH)
	LCD_send_character('a',#0CBH)
	LCD_send_character('t',#0CCH)
	LCD_send_character('i',#0CDH)
	LCD_send_character('o',#0CEH)
	LCD_send_character('n',#0CFH)
	ret
	
Display_LCD_L2: ; preheat/soak
	mov A, state
	cjne A, #2, display_lcd_L3
	LCD_send_character('S',#0C6H)
	LCD_send_character('o',#0C7H)
	LCD_send_character('a',#0C8H)
	LCD_send_character('k',#0C9H)
	LCD_send_character('i',#0CAH)
	LCD_send_character('n',#0CBH)
	LCD_send_character('g',#0CCH)
	ret
	
Display_LCD_L3: ; ramp to peak
	mov A, state
	cjne A, #3, display_lcd_L4
	LCD_send_character('R',#0C6H)
	LCD_send_character('a',#0C7H)
	LCD_send_character('m',#0C8H)
	LCD_send_character('p',#0C9H)
	LCD_send_character('u',#0CAH)
	LCD_send_character('p',#0CBH)
	ret
	
Display_LCD_L4: ; reflow
	mov A, state
	cjne A, #4, display_lcd_L6
	LCD_send_character('R',#0C6H)
	LCD_send_character('e',#0C7H)
	LCD_send_character('f',#0C8H)
	LCD_send_character('l',#0C9H)
	LCD_send_character('o',#0CAH)
	LCD_send_character('w',#0CBH)
	ret
	
Display_LCD_L6: ; cooling
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
END