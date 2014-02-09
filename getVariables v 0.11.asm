$MODDE2

dseg at 30H

x: ds 2
BCD: ds 3
soakTemp: ds 1
soakTempBCD: ds 2
soakTimeSec: ds 1
soakTimeMin: ds 1
reflowTemp: ds 1
reflowTempBCD: ds 2	
reflowTimeSec: ds 1
reflowTimeMin: ds 1

cseg

org 0000H
ljmp start

myLUT:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 099H        ; 0 TO 4
    DB 092H, 082H, 0F8H, 080H, 090H        ; 4 TO 9
    
Display Mac		;the macro used to display 2 BCD digits
	mov a, %0
	mov dptr, #myLUT
	anl a, #0fh
	movc a, @a+dptr
	mov %1, a 
	mov dptr, #myLUT
	mov a, %0
	swap a
	anl a, #0fh
	movc a, @a+dptr
	mov %2, a 
ENDMAC

DisplayBCD MAC
	mov dptr, #myLUT
	; Display Digit 0
    mov A, %0
    anl a, #0fh
    movc A, @A+dptr
    mov HEX0, A
	; Display Digit 1
    mov A, %0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov HEX1, A
    ; Display Digit 0
    mov A, %1
    anl a, #0fh
    movc A, @A+dptr
    mov HEX2, A
	; Display Digit 1
   ; mov A, bcd+1
    ;swap a
    ;anl a, #0fh
    ;movc A, @A+dptr
    ;mov HEX3, A
  ENDMAC
    

TempSelect MAC
	mov a, swa
	jnb acc.0, noInc1%L
noFlip1%L:
	mov a, swa
	jb acc.0, noFlip1%L
	mov a, %0
	inc a
	mov %0, a
	mov a, swa
noInc1%L:
	jnb acc.1, noDec1%L
noFlip1d%L:
	mov a, swa
	jb acc.1, noFlip1d%L
	clr c
	mov a, %0
	dec a
	mov %0, a
	mov a, swa
noDec1%L:
	jnb acc.2, noInc5%L
noFlip5%L:
	mov a, swa
	jb acc.2, noFlip5%L
	mov a, %0
	add a, #5
	mov %0, a
	mov a, swa
noInc5%L:
	jnb acc.3, noDec5%L
noFlip5d%L:
	mov a, swa
	jb acc.3, noFlip5d%L
	clr c
	mov a, %0
	subb a, #5
	mov %0, a
	mov a, swa
noDec5%L:
	jnb acc.4, noInc10%L
noFlip10%L:
	mov a, swa
	jb acc.4, noFlip10%L
	mov a, %0
	add a, #10
	mov %0, a
	mov a, swa
noInc10%L:
	jnb acc.5, noDec10%L
noFlip10d%L:
	mov a, swa
	jb acc.5, noFlip10d%L
	clr c
	mov a, %0
	subb a, #10
	mov %0, a
	mov a, swa
noDec10%L:
ENDMAC

changeTime:
	mov LEDRA, #10101010b	
	mov a, swa
	jnb acc.0, noInc1
switchOff1:
	mov a, swa	
	jb acc.0, switchOff1	
	mov a, r1
	add a, #1
	da a
	mov r1,a 
	cjne a, #01100000b, norollUP
	mov r1, #0
norollUP:	
noInc1:
	mov a, swa
	jnb acc.1, noDec1
switchOff1d:
	mov a, swa	
	jb acc.1, switchOff1d
	mov a, r1
	dec a
	mov r1,a 
	cjne a, #11111111b, noRollDown
	mov r1, #01011001b
	sjmp noManualDA
noRollDown:	
	anl a, #0fh
	cjne a, #00001111b, noManualDA
	clr c
	mov a, r1
	subb a, #06
	mov r1, a 
noManualDA:
;	mov a, swa
noDec1: 
	mov a, swa
	jnb acc.2, noInc5
switchOff5:
	mov a, swa	
	jb acc.2, switchOff5	
	mov a, r1
	add a, #5
	da a
	mov r1,a 
	cjne a, #01100000b, norollUP5
	mov r1, #0
norollUP5:	
noInc5:
	mov a, swa
	jnb acc.3, noDec5
switchOff5d:
	mov a, swa	
	jb acc.3, switchOff5d
	mov a, r1
	clr c
	mov r2, a
	subb a, #05
	mov r1,a 
	clr c 
	subb a, #01100000b
	jc norollDown5
	mov a, #01010101b
	add a, r2
	mov r1, a
	sjmp noManualDA5
noRollDown5:	
	anl a, #0fh
	clr c
	subb a, #00001001b
	jc noManualDA5
	clr c
	mov a, r1
	subb a, #06
	mov r1, a 
noManualDA5:
noDec5: 
	mov a, swa
	jnb acc.4, noInc10
switchOff10:
	mov a, swa	
	jb acc.4, switchOff10	
	mov a, r1
	add a, #10
	da a
	mov r1,a 
	clr c 
	subb a, #01100000b
	jc norollUP10
	mov r1, a
norollUP10:	
noInc10:
	mov a, swa
	jnb acc.5, noDec10
switchOff10d:
	mov a, swa	
	jb acc.5, switchOff10d
	mov a, r1
	clr c
	mov r2, a
	subb a, #00010000b
	mov r1,a 
	jnc noRollDown10
	mov a, #01010000b
	add a, r2
	mov r1, a
	sjmp noManualDA10
noRollDown10:	
noManualDA10:
noDec10: 

mov LEDRA, #0
ret

start:
	mov SP, #7FH	;setting stackpointer
	clr a
	mov LEDRA,a	;clear LEDS
	mov LEDRB,a
	mov LEDRC,a
	mov LEDG,a
	
	mov soakTemp, #150
	mov soakTimeSec, #00110000b
	mov soakTimeMin, #00000001b
	mov reflowTemp, #225
	mov reflowTimeSec, #00000000b
	mov reflowTimeMin, #00000001b

selectSoakTemp: 
	lcall clear_screen
	LCD_send_character('E',#80H)
	LCD_send_character('n',#81H)
	LCD_send_character('t',#82H)
	LCD_send_character('e',#83H)
	LCD_send_character('r',#84H)
	LCD_send_character('t',#86H)
	LCD_send_character('h',#87H)
	LCD_send_character('e',#88H)
	LCD_send_character('n',#8AH)
	LCD_send_character('e',#8BH)
	LCD_send_character('w',#8CH)
	
	LCD_send_character('s',#0C0H)
	LCD_send_character('o',#0C1H)
	LCD_send_character('a',#0C2H)
	LCD_send_character('k',#0C3H)
	LCD_send_character('t',#0C5H)
	LCD_send_character('e',#0C6H)
	LCD_send_character('m',#0C7H)
	LCD_send_character('p',#0C8H)
	LCD_send_character(':',#0C9H)
	
	LCD_send_number(soakTemp,#0CBH,#3,#1)
	jb key.3, nodebounceToSoakTime
	jnb key.3, $
	ljmp selectSoakTime
noDebounceToSoakTime:
    tempSelect(soakTemp)
    mov x+0, soakTemp
    mov x+1, #0
    lcall hex2bcd
    mov soakTempBCD+0, BCD+0
    mov soakTempBCD+1, BCD+1 
    displayBCD(SoakTempBCD+0, soaktempBCD+1)
    ljmp selectSoakTemp

selectSoakTime:
	lcall clear_screen
	LCD_send_character('E',#80H)
	LCD_send_character('n',#81H)
	LCD_send_character('t',#82H)
	LCD_send_character('e',#83H)
	LCD_send_character('r',#84H)
	LCD_send_character('t',#86H)
	LCD_send_character('h',#87H)
	LCD_send_character('e',#88H)
	LCD_send_character('n',#8AH)
	LCD_send_character('e',#8BH)
	LCD_send_character('w',#8CH)
	
	LCD_send_character('s',#0C0H)
	LCD_send_character('o',#0C1H)
	LCD_send_character('a',#0C2H)
	LCD_send_character('k',#0C3H)
	LCD_send_character('s',#0C5H)
	LCD_send_character('e',#0C6H)
	LCD_send_character('c',#0C7H)
	LCD_send_character('s',#0C8H)
	LCD_send_character(':',#0C9H)
	
	LCD_send_number(soakTimeMin,#0CBH,#2,#0)
	LCD_send_number(soakTimeSec,#0CDH,#2,#0)
	jb key.3, nodebounceToSoakTimeMin
	jnb key.3, $
	ljmp selectSoakTimeMin
noDebounceToSoakTimeMin:
	mov r1, soakTimeSec
	lcall changeTime
	mov soakTimeSec, r1
	lcall waitTime
	Display(soakTimeSec, HEX0, HEX1)
	Display(soakTimeMin, HEX2, HEX3)
	ljmp selectSoakTime
	
selectSoakTimeMin:
	lcall clear_screen
	LCD_send_character('E',#80H)
	LCD_send_character('n',#81H)
	LCD_send_character('t',#82H)
	LCD_send_character('e',#83H)
	LCD_send_character('r',#84H)
	LCD_send_character('t',#86H)
	LCD_send_character('h',#87H)
	LCD_send_character('e',#88H)
	LCD_send_character('n',#8AH)
	LCD_send_character('e',#8BH)
	LCD_send_character('w',#8CH)
	
	LCD_send_character('s',#0C0H)
	LCD_send_character('o',#0C1H)
	LCD_send_character('a',#0C2H)
	LCD_send_character('k',#0C3H)
	LCD_send_character('m',#0C5H)
	LCD_send_character('i',#0C6H)
	LCD_send_character('n',#0C7H)
	LCD_send_character('s',#0C8H)
	LCD_send_character(':',#0C9H)
	
	LCD_send_number(soakTimeMin,#0CBH,#2,#0)
	LCD_send_number(soakTimeSec,#0CDH,#2,#0)
	jb key.3, nodebounceToReflowTemp
	jnb key.3, $
	ljmp selectReflowTemp
noDebounceToReflowTemp:
	mov r1, soakTimeMin
	lcall changeTime
	mov soakTimeMin, r1
	lcall waitTime
	Display(soakTimeSec, HEX0, HEX1)
	Display(soakTimeMin, HEX2, HEX3)
	ljmp selectSoakTimeMin
	
selectReflowTemp:
	lcall clear_screen
	LCD_send_character('E',#80H)
	LCD_send_character('n',#81H)
	LCD_send_character('t',#82H)
	LCD_send_character('e',#83H)
	LCD_send_character('r',#84H)
	LCD_send_character('t',#86H)
	LCD_send_character('h',#87H)
	LCD_send_character('e',#88H)
	LCD_send_character('n',#8AH)
	LCD_send_character('e',#8BH)
	LCD_send_character('w',#8CH)
	
	LCD_send_character('r',#0C0H)
	LCD_send_character('f',#0C1H)
	LCD_send_character('l',#0C2H)
	LCD_send_character('w',#0C3H)
	LCD_send_character('t',#0C5H)
	LCD_send_character('e',#0C6H)
	LCD_send_character('m',#0C7H)
	LCD_send_character('p',#0C8H)
	LCD_send_character(':',#0C9H)
	
	LCD_send_number(reflowTemp,#0CBH,#3,#1)
	jb key.3, nodebounceToReflowTime
	jnb key.3, $
	ljmp selectReflowTime
noDebounceToReflowTime:
    tempSelect(reflowTemp)
    mov x+0, reflowTemp
    mov x+1, #0
    lcall hex2bcd
    mov reflowTempBCD+0, BCD+0
    mov reflowTempBCD+1, BCD+1 
    displayBCD(reflowTempBCD+0, reflowtempBCD+1)
    ljmp selectReflowTemp

selectReflowTime:
	lcall clear_screen
	LCD_send_character('E',#80H)
	LCD_send_character('n',#81H)
	LCD_send_character('t',#82H)
	LCD_send_character('e',#83H)
	LCD_send_character('r',#84H)
	LCD_send_character('t',#86H)
	LCD_send_character('h',#87H)
	LCD_send_character('e',#88H)
	LCD_send_character('n',#8AH)
	LCD_send_character('e',#8BH)
	LCD_send_character('w',#8CH)
	
	LCD_send_character('r',#0C0H)
	LCD_send_character('f',#0C1H)
	LCD_send_character('l',#0C2H)
	LCD_send_character('w',#0C3H)
	LCD_send_character('s',#0C5H)
	LCD_send_character('e',#0C6H)
	LCD_send_character('c',#0C7H)
	LCD_send_character('s',#0C8H)
	LCD_send_character(':',#0C9H)
	
	LCD_send_number(reflowTimeMin,#0CBH,#2,#0)
	LCD_send_number(reflowTimeSec,#0CDH,#2,#0)
	jb key.3, nodebounceToReflowTimeMin
	jnb key.3, $
	ljmp selectReflowTimeMin
noDebounceToReflowTimeMin:
	mov r1, reflowTimeSec
	lcall changeTime
	mov reflowTimeSec, r1
	lcall waitTime
	Display(reflowTimeSec, HEX0, HEX1)
	Display(reflowTimeMin, HEX2, HEX3)
	ljmp selectReflowTime
	
selectReflowTimeMin:
	lcall clear_screen
	LCD_send_character('E',#80H)
	LCD_send_character('n',#81H)
	LCD_send_character('t',#82H)
	LCD_send_character('e',#83H)
	LCD_send_character('r',#84H)
	LCD_send_character('t',#86H)
	LCD_send_character('h',#87H)
	LCD_send_character('e',#88H)
	LCD_send_character('n',#8AH)
	LCD_send_character('e',#8BH)
	LCD_send_character('w',#8CH)
	
	LCD_send_character('r',#0C0H)
	LCD_send_character('f',#0C1H)
	LCD_send_character('l',#0C2H)
	LCD_send_character('w',#0C3H)
	LCD_send_character('m',#0C5H)
	LCD_send_character('i',#0C6H)
	LCD_send_character('n',#0C7H)
	LCD_send_character('s',#0C8H)
	LCD_send_character(':',#0C9H)
	
	LCD_send_number(reflowTimeMin,#0CBH,#2,#0)
	LCD_send_number(reflowTimeSec,#0CDH,#2,#0)
	jb key.3, nodebounceToActual
	jnb key.3, $
	ljmp actual
noDebounceToActual:
	mov r1, reflowTimeMin
	lcall changeTime
	mov reflowTimeMin, r1
	lcall waitTime
	Display(reflowTimeSec, HEX0, HEX1)
	Display(reflowTimeMin, HEX2, HEX3)
	ljmp selectReflowTimeMin
	
		
Actual: ;aka setting of variables is done!
	sjmp actual
waitTime: 
	mov r7, #250
L0:
	mov r6, #250
L1:	djnz r6, L1
	djnz r7, L0
ret
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
end	
	
