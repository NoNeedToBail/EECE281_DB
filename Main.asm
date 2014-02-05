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
	
org 000BH				;probs need to change this
	ljmp ISR_timer1

$include(PWM.asm)
$include(math16.asm)

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
	
	lcall InitTimer0
	lcall InitTimer1
	
	mov P0MOD, #00000011B ;NEEDS TO BE REFORMULATED AFTER EVERYTHING IS ADDED
	setb EA  ; Enable all interrupts
	
;===============================================================
; THE STATE MACHINE, LADIES AND GENTLEMEN.
;===============================================================
	
s0_Idle: 				;state we reset to when stop buton/switch pressed
	SetTemp(#0)
		 					
	jnb KEY.3, s1_RampToSoak ; if Key 3 pressed, jumps to s1_RampToSoak
	jnb KEY.2, s6_SetVars 		 ; if Key 2 pressed, jumps s6_SetVars 
	sjmp s0_Idle 
		 
s1_RampToSoak: 			;moves to s2_Soak when the desired soak temp is reached
	jnb KEY.3, s1_RampToSoak
	setTemp(soakTemp)
	lcall buzz1Sec
s1_loop:
	jnb Pwmdone, s1_loop	
	
s2_Soak:
	HoldTemp(soakTimeMin, soakTimeSec)
	lcall buzz1Sec
s2_loop:
	jb Pwmdone, s3_ramptopeak

s3_RampToPeak: 			;moves to s4_Reflow when the desired reflow temp is reached
	SetTemp(ReflowTemp)
	lcall buzz1Sec
s3_loop:
	jb Pwmdone, s4_reflow

s4_Reflow: 				;moves to s5_Cooling after y seconds (y=relfow time)
	HoldTemp(ReflowTimeMin, ReflowTimeSec)
	lcall buzz1Sec
	lcall buzz1Sec
	lcall buzz1Sec
s4_loop:
	jb Pwmdone, s5_cooling

s5_Cooling: 			;moves to s6_SetVars when temp is less than 60 degrees
	setTemp(#60)
	push R0
Cooling_Buzzer:
	mov R0, #6
	lcall buzz1sec
	lcall wait1sec
	djnz R0, Cooling_buzzer
s5_loop:
	jb Pwmdone, s0_idle

s6_SetVars: 			;moves back to s0_Idle after all varibles have been set/after buton pushed
	jnb KEY.2, s6_SetVars
	
;===============================================================
; THE END OF THE STATE MACHINE. wE'LL BE HERE ALL WEEK.
;===============================================================
	
ISR_timer1:			;needs more work
	mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    ;if Key 1 pressed, reset to Idle state
    ;make sure all the varibles are 
    
    mov a, SWC ; Read switches 17 and 16
	jb acc.1, s0_Idle ;jumps to s0_Idle if 
    
    ;compliment if buzzer is suposed to go off
    jnb buzzer, nobuzzer
    cpl BUZZERPIN
nobuzzer:
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