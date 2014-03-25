;==================================================
; Setting the variables for soak and reflow time/temp
;====================================================
TempSelect MAC	;this is the macro for selecting reflow temp and soak temp
;switch 0 increments temp by one, switch1 = dec by one, switch2= inc by 5, switch3 = dec by 5, switch4 = inc 10, switch5 = dec10
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

;this routine changes r1. put your sec/min variable in r1 before using 
;and copy the results from r1 back into desired variable after calling this
;switch0=inc 1, switch1 = dec1, switch2 = inc5, switch3 = dec5, switch4 = inc 10, switch5 = dec10
changeTime:
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
	sjmp noManualDA1
noRollDown:	
	anl a, #0fh
	cjne a, #00001111b, noManualDA1
	clr c
	mov a, r1
	subb a, #06
	mov r1, a 
noManualDA1:
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
	ret

;the loop for soakTemp changing. Press key3 to go onto next loop
VarSelect:
selectSoakTemp: 
	lcall clear_screen
selectSoakTemp1:
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
    ljmp selectSoakTemp1
   
;the loop for soakTimeSec changing. Press key3 to go onto next loop
selectSoakTime:
	lcall clear_screen
selectSoakTime1:
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
	LCD_send_character(':',#0CDH)
	LCD_send_number(soakTimeSec,#0CEH,#2,#0)
	
	jb key.3, nodebounceToSoakTimeMin
	jnb key.3, $
	ljmp selectSoakTimeMin
noDebounceToSoakTimeMin:
	mov r1, soakTimeSec
	lcall changeTime
	mov soakTimeSec, r1
	ljmp selectSoakTime1	
	
;the loop for soakTimeMin changing. Press key3 to go onto next loop
selectSoakTimeMin:
	lcall clear_screen
selectSoakTimeMin1:
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
	LCD_send_character(':',#0CDH)
	LCD_send_number(soakTimeSec,#0CEH,#2,#0)
	jb key.3, nodebounceToReflowTemp
	jnb key.3, $
	ljmp selectReflowTemp
noDebounceToReflowTemp:
	mov r1, soakTimeMin
	lcall changeTime
	mov soakTimeMin, r1
	ljmp selectSoakTimeMin1
	
;The loop for selecting reflow temp
selectReflowTemp:
	lcall clear_screen
selectReflowTemp1:
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
    ljmp selectReflowTemp1

;the loop for reflowTimeSec changing. Press key3 to go onto next loop
selectReflowTime:
	lcall clear_screen
selectReflowTime1:
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
	LCD_send_character(':',#0CDH)
	LCD_send_number(reflowTimeSec,#0CEH,#2,#0)
	jb key.3, nodebounceToReflowTimeMin
	jnb key.3, $
	ljmp selectReflowTimeMin
noDebounceToReflowTimeMin:
	mov r1, reflowTimeSec
	lcall changeTime
	mov reflowTimeSec, r1
	ljmp selectReflowTime1
	
;the loop for reflowTimeMin changing. Press key3 to go onto next loop
selectReflowTimeMin:
	lcall clear_screen
selectReflowTimeMin1:
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
	LCD_send_character(':',#0CDH)
	LCD_send_number(reflowTimeSec,#0CEH,#2,#0)
	jb key.3, nodebounceToReturn
	jnb key.3, $
	ret
noDebounceToReturn:
	mov r1, reflowTimeMin
	lcall changeTime
	mov reflowTimeMin, r1
	ljmp selectReflowTimeMin1
;====================================================
;End of variable selection
;=====================================================
