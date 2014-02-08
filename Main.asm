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


org 0000H
	ljmp myprogram
	
org 000BH
	lcall PWMISR
	reti
	
org 001BH
	ljmp ISR_timer1

$include(PWM.asm)
$include(LCD.asm)
$include(math16.asm)

DSEG at 30h
	x:				ds	2
	y:				ds	2
	bcd:			ds	3
	temperature:	ds	2

	;PWM Variables - don't touch!
	desiredTemp:	ds	2
	timeToReach:	ds	1
	UniMin:			ds	1
	UniSec:			ds	1
	TskMin:			ds	1
	TskSec:			ds	1
	count:			ds	1
	difference:		ds	1
	
	;Main Variables
	soakTemp:		ds	2
	soakTempBCD:	ds	2
	soakTimeSec:	ds	1
	soakTimeMin:	ds	1
	reflowTemp:		ds	2
	reflowTempBCD:	ds	2
	reflowTimeSec:	ds	1
	reflowTimeMin:	ds	1
	state:			ds	1
	
	;LCD Variables
	timer1_count:	ds	1
	digits:			ds	1

BSEG
	PWMdone:	dbit	1
	holding:	dbit	1
	buzzer:		dbit    1		;turn on to get buzzer
	mf:			dbit	1
	emergency:	dbit	1
	
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
	
	mov soakTemp, #200
	mov soakTemp+1, #0
	mov soakTimeMin, #2
	mov soakTimeSec, #0
	
	mov reflowTemp, #low(260)
	mov reflowTemp+1, #high(260)
	mov reflowTimeMin, #0
	mov reflowTimeSec, #30
	
	lcall InitTimer0
	lcall InitTimer1
	
	mov P0MOD, #00000011B ;NEEDS TO BE REFORMULATED AFTER EVERYTHING IS ADDED
	setb EA  ; Enable all interrupts
	sjmp s0_idle
	
;===============================================================
; THE STATE MACHINE, LADIES AND GENTLEMEN.
;===============================================================


s6_SetVars: 			;moves back to s0_Idle after all varibles have been set/after buton pushed
	jnb KEY.2, s6_SetVars
	ljmp s0_idle
		
s0_Idle: 				;state we reset to when stop button/switch pressed
	SetTemp(#20, #0)
		 					
	jnb KEY.3, s1_RampToSoak ; if Key 3 pressed, jumps to s1_RampToSoak
	jnb KEY.2, s6_SetVars 		 ; if Key 2 pressed, jumps s6_SetVars
	
	lcall Display_LCD_L0
	sjmp s0_Idle 
		 
s1_RampToSoak: 			;moves to s2_Soak when the desired soak temp is reached
	jnb KEY.3, s1_RampToSoak
	setTemp(soakTemp, soakTemp+1)
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
	SetTemp(ReflowTemp, reflowTemp+1)
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
	setTemp(#60, #0)
	lcall Display_LCD_DOOR
	push AR0
Cooling_Buzzer:
	mov R0, #6
	lcall buzz1sec
	lcall wait1sec
	djnz R0, Cooling_buzzer
	pop AR0
s5_loop:
	jb emergency, s5_jump_to_idle
	lcall Display_LCD_L5
	jnb Pwmdone, s5_loop
	ljmp s0_idle
s5_jump_to_idle:
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
	push acc
	mov a, R0
	push acc
	mov a, R1
	push acc
	mov a, R2
	push acc
	mov R0, #180
WaitL0:
	mov R1, #250
WaitL1:
	mov R2, #250
WaitL2:
	djnz R2, WaitL2
	djnz R1, WaitL1
	djnz R0, WaitL0
	pop acc
	mov R2, a
	pop acc
	mov R1, a
	pop acc
	mov R0, a
	pop acc
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