;=============================================================================
; Main.asm
; UI code and runnable file for the reflow oven controller.
; States have been created and commented.
; Need to implemnt the states and control flow between them
;=============================================================================

$modde2

;Universal
CLK EQU 33333333
;Main
FREQ_1 EQU 2000
TIMER1_RELOAD EQU 65536-(CLK/(12*2*FREQ_1))
;PWM
PWR EQU P0.0
T0_Freq EQU 50
T0_RELOAD EQU 65536-(CLK/(12*T0_Freq))
RANGE EQU 5


org 0000H
	ljmp myprogram
	
org 000BH				;probs need to change this
	ljmp ISR_timer1

$include(PWM.asm)

DSEG at 30h
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
	
	soakTemp:		ds	1
	soakTempBCD:	ds	2
	soakTimeSec:	ds	1
	soakTimeMin:	ds	1
	
	reflowTemp:		ds	1
	reflowTempBCD:	ds	2
	reflowTimeSec:	ds	1
	reflowTimeMin:	ds	1

BSEG
	PWMdone:	dbit	1
	holding:	dbit	1
	buzzer:		dbit    1		;turn on to get buzzer
	
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
	
	mov P0MOD, #00000001B ; P0.0 is output used for buzzer 
	setb P0.0
	mov TMOD,  #00010000B ; GATE=0, C/T*=0, M1=0, M0=1: 16-bit timer
	clr TR1 ; Disable timer 1
	clr TF1
    mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    setb TR1 ; Enable timer 1
    setb ET1 ; Enable timer 1 interrupt

	setb EA  ; Enable all interrupts
	
s0_Idle: 				;state we reset to when stop buton/switch pressed
	SetTemp(#0)
		 					
	jnb KEY.3, s1_RampToSoak ; if Key 3 pressed, jumps to s1_RampToSoak
	jnb KEY.2, s6_SetVars 		 ; if Key 2 pressed, jumps s6_SetVars 
	sjmp s0_Idle
		 
		 
s1_RampToSoak: 			;moves to s2_Soak when the desired soak temp is reached
	jnb KEY.3, s1_RampToSoak
	setTemp(soakTemp)
s1_loop:
	jnb Pwmdone, s1_loop	
	
s2_Soak:
	HoldTemp(soakTimeMin, soakTimeSec)
s2_loop:
	jb Pwmdone, s3_ramptopeak

s3_RampToPeak: 			;moves to s4_Reflow when the desired reflow temp is reached
	SetTemp(ReflowTemp)
s3_loop:
	jb Pwmdone, s4_reflow

s4_Reflow: 				;moves to s5_Cooling after y seconds (y=relfow time)
	HoldTemp(ReflowTimeMin, ReflowTimeSec)
s4_loop:
	jb Pwmdone, s5_cooling

s5_Cooling: 			;moves to s6_SetVars when temp is less than 60 degrees
	setTemp(#60)
s5_loop:
	jb Pwmdone, s0_idle

s6_SetVars: 			;moves back to s0_Idle after all varibles have been set/after buton pushed
	jnb KEY.2, s6_SetVars
	
	;Need to include display function and lookup table for 7 segment display
	
ISR_timer1:			;needs more work
	mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    ;if Key 1 pressed, reset to Idle state
    ;make sure all the varibles are 
    
    mov a, SWC ; Read switches 17 and 16
	jb acc.1, s0_Idle ;jumps to s0_Idle if 
    
    ;compliment if buzzer is suposed to go off
    jnb buzzer, nobuzzer
    cpl P0.0
nobuzzer:
	reti
	
END