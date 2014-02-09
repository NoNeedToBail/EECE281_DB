;=============================================================================
; Main.asm
; UI code and runnable file for the reflow oven controller.
; State machine up and running.
; Need code for LCD and 7-seg displays.
;=============================================================================

$modde2

;Universal
CLK EQU 33333333

;Main
BUZZERPIN EQU P0.1
FREQ_1 EQU 2000
TIMER1_RELOAD EQU 65536-(CLK/(12*2*FREQ_1))

;PWM
PWR EQU P0.0
T0_Freq EQU 50
T0_RELOAD EQU 65536-(CLK/(12*T0_Freq))
RANGE EQU 5

;TempDisp
BAUD   EQU 115200
T2LOAD EQU 65536-(CLK/(32*BAUD))
MISO   EQU  P0.0 
MOSI   EQU  P0.1 
SCLK   EQU  P0.2
CE_ADC EQU  P0.3
CE_EE  EQU  P0.4
CE_RTC EQU  P0.5

org 0000H
	ljmp myprogram
	
org 000BH
	ljmp PWMISR
	
org 001BH
	ljmp ISR_timer1
	
org 002Bh
	ljmp ISR_timer2

$include(PWM.asm)
$include(LCD.asm)
$include(math16.asm)
$include(tempDisp.asm)

DSEG at 30h
	x:				ds	2
	y:				ds	2
	bcd:			ds	3
	temperature:	ds	1

	;PWM Variables - don't touch!
	desiredTemp:	ds	1
	timeToReach:	ds	1
	UniMin:			ds	1
	UniSec:			ds	1
	TskMin:			ds	1
	TskSec:			ds	1
	count:			ds	1
	difference:		ds	1
	
	;Main Variables
	soakTemp:		ds	1
	soakTempBCD:	ds	2
	soakTimeSec:	ds	1
	soakTimeMin:	ds	1
	reflowTemp:		ds	1
	reflowTempBCD:	ds	2
	reflowTimeSec:	ds	1
	reflowTimeMin:	ds	1
	state:			ds	1
	
	;LCD Variables
	timer1_count:	ds	1
	digits:			ds	1
	
	;tempDisp Variables
	

BSEG
	PWMdone:	dbit	1
	holding:	dbit	1
	buzzer:		dbit    1		;turn on to get buzzer
	mf:			dbit	1
	emergency:	dbit	1
	spaces:		dbit	1		;for our leading 0's problem
	
CSEG

myprogram:
	mov SP, #7FH
	clr a
	mov LEDRA, a
	mov LEDRB, a		;clears leds
	mov LEDRC, a
	mov LEDG, a
	mov a, #1111111B
	mov HEX7, a 		;clear 7 seg display
	mov HEX6, a
	mov HEX5, a
	mov HEX4, a
	mov HEX3, a
	mov HEX2, a
	mov HEX1, a
	mov HEX0, a
	
	mov soakTemp, #150
	mov soakTimeMin, #1
	mov soakTimeSec, #30h
	
	mov reflowTemp, #220
	mov reflowTimeMin, #1
	mov reflowTimeSec, #0
	
	lcall start_LCD
	
	lcall InitTimer0
	lcall InitTimer1

	lcall Init_Temp
	mov P0MOD, #00000011B ;NEEDS TO BE REFORMULATED AFTER EVERYTHING IS ADDED
	clr EA
	setb EA  ; Enable all interrupts
	ljmp s0_idle
	
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
	mov LEDRA, #10101010b	;remove when testing is done	
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

mov LEDRA, #0	;remove when testing is done
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
	ljmp selectSoakTime	
	
;the loop for soakTimeMin changing. Press key3 to go onto next loop
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
	ljmp selectSoakTimeMin
	
;The loop for selecting reflow temp
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
    ljmp selectReflowTemp

;the loop for reflowTimeSec changing. Press key3 to go onto next loop
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
	ljmp selectReflowTime
	
;the loop for reflowTimeMin changing. Press key3 to go onto next loop
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
	jb key.3, nodebounceToReturn
	jnb key.3, $
	ret
noDebounceToReturn:
	mov r1, reflowTimeMin
	lcall changeTime
	mov reflowTimeMin, r1
	ljmp selectReflowTimeMin
;====================================================
;End of variable selection
;=====================================================

;===============================================================
; THE STATE MACHINE, LADIES AND GENTLEMEN.
;===============================================================

s6_SetVars: 			;moves back to s0_Idle after all varibles have been set/after buton pushed

	jnb KEY.2, s6_SetVars
	lcall varSelect
	ljmp s0_idle
	
s0_Idle: 				;state we reset to when stop buton/switch pressed
	SetTemp(#0)
	setb LEDRA.4	 					
	jnb KEY.3, s1_RampToSoak ; if Key 3 pressed, jumps to s1_RampToSoak
	jnb KEY.2, s6_SetVars 		 ; if Key 2 pressed, jumps s6_SetVars
	setb LEDRA.5
	lcall Display_LCD_L0
	setb LEDRA.6
	sjmp s0_Idle 
		 
s1_RampToSoak: 			;moves to s2_Soak when the desired soak temp is reached
	jnb KEY.3, s1_RampToSoak
	setTemp(soakTemp)
	lcall Display_LCD_L1
	lcall buzz1Sec
s1_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L1
	jnb Pwmdone, s1_loop	
	
s2_Soak:
	HoldTemp(soakTimeMin, soakTimeSec)
	lcall Display_LCD_L2
	lcall buzz1Sec
s2_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L2
	jnb Pwmdone, s2_loop

s3_RampToPeak: 			;moves to s4_Reflow when the desired reflow temp is reached
	SetTemp(ReflowTemp)
	lcall Display_LCD_L3
	lcall buzz1Sec
s3_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L3
	jnb Pwmdone, s3_loop

s4_Reflow: 				;moves to s5_Cooling after y seconds (y=relfow time)
	HoldTemp(ReflowTimeMin, ReflowTimeSec)
	lcall Display_LCD_L4
	lcall buzz1Sec
	lcall buzz1Sec
	lcall buzz1Sec
s4_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L4
	jnb Pwmdone, s4_loop

s5_Cooling: 			;moves to s6_SetVars when temp is less than 60 degrees
	setTemp(#60)
	lcall Display_LCD_DOOR
	push AR0
Cooling_Buzzer:
	mov R0, #6
	lcall buzz1sec
	lcall wait1sec
	djnz R0, Cooling_buzzer
	pop AR0
s5_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L5
	jnb Pwmdone, s5_loop
	ljmp s0_idle
JumpToIdle:
	ljmp s0_idle
	
;=================================================================
; THE END OF THE STATE MACHINE. THANK YOU. WE'LL BE HERE ALL WEEK.
;=================================================================
	
ISR_timer1:			;needs more work
	push acc
	mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    
    djnz timer1_count, noclear
    lcall clear_screen
    mov timer1_count, #200
NoClear:
    jb KEY.1, BuzzerCheck
    setb Emergency
    
BuzzerCheck:
    jnb buzzer, nobuzzer
    cpl BUZZERPIN
nobuzzer:
	pop acc
	reti
	
Wait1Sec:
	push AR0
	push AR1
	push AR2
	mov R0, #180
WaitL0:
	mov R1, #250
WaitL1:
	mov R2, #250
WaitL2:
	djnz R2, WaitL2
	djnz R1, WaitL1
	djnz R0, WaitL0
	pop AR2
	pop AR1
	pop AR0
	ret
	
Buzz1Sec:
	setb buzzer
	lcall Wait1Sec
	clr buzzer
	ret
	
InitTimer1:
	mov timer1_count, #200
	mov a, TMOD
	anl a, #0Fh
	orl a, #00010000b
	mov TMOD, a
	clr TR1 ; Disable timer 1
	clr TF1
    mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    setb TR1 ; Enable timer 1
    setb ET1 ; Enable timer 1 interrupt
    ret
	
END