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
BUZZERPIN EQU P3.1
FREQ_1 EQU 1000
TIMER1_RELOAD EQU 65536-(CLK/(12*FREQ_1))

;PWM
PWR EQU P1.7
T0_Freq EQU 200
T0_RELOAD EQU 65536-(CLK/(12*T0_Freq))

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
	ljmp PWMISR ;ISR for controlling temperature of oven and sending characters via the serial port
	
org 001BH
	ljmp ISR_timer1 ;ISR for the buzzer

$include(PWM.asm)
$include(LCD.asm)
$include(math16.asm)
$include(tempDisp.asm)
$include(variableSelect.asm)

DSEG at 30h
	;math16 Variables
	x:				ds	2
	y:				ds	2
	bcd:			ds	3
	temperature:	ds	1

	;PWM Variables
	desiredTemp:	ds	1
	timeToReach:	ds	1
	UniMin:			ds	1
	UniSec:			ds	1
	TskMin:			ds	1
	TskSec:			ds	1
	count:			ds	3
	difference:		ds	1
	range:			ds	1
	
	;Main Variables
	soakTemp:		ds	1
	soakTempBCD:	ds	2
	soakTimeSec:	ds	1
	soakTimeMin:	ds	1
	reflowTemp:		ds	1
	reflowTempBCD:	ds	2
	reflowTimeSec:	ds	1
	reflowTimeMin:	ds	1
	
	;LCD Variables
	timer1_count:	ds	1
	digits:			ds	1

BSEG
	PWMdone:	dbit	1
	holding:	dbit	1
	mf:			dbit	1
	emergency:	dbit	1
	spaces:		dbit	1		;for leading 0's
	overshoot:	dbit	1
	
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
	
	;default value for the acceptable range
	mov range, #5
	
	lcall start_LCD ;Starts up the LCD
	lcall InitTimer0 ;Initialization required for pulse width modulation
	lcall InitTimer1 ;Initialization required for the buzzer
	lcall Init_Temp ;Initialization required for temperature measurement
	mov TMOD, #00010001b ; Timers 1 and 0 in 16-bit mode
	
	mov soakTemp, #150
	mov soakTimeMin, #1
	mov soakTimeSec, #30h
	
	mov reflowTemp, #217
	mov reflowTimeMin, #1
	mov reflowTimeSec, #0
	
	mov P0MOD, #00111110B
	mov P1MOD, #10000000B
	mov P2MOD, #00000000B
	mov P3MOD, #00000010B
	setb EA  ; Enable all interrupts
	
	ljmp s0_idle
	
SendTemp:
	mov x+0, temperature
	mov x+1, #0
	lcall hex2bcd ;temperature converted to bcd and stored in bcd variable
	lcall send_Number ;sends number in bcd variable out the serial port
	ret

;===============================================================
; THE STATE MACHINE, LADIES AND GENTLEMEN.
;===============================================================

s6_SetVars: 			;moves back to s0_Idle after all varibles have been set/after buton pushed
	jnb KEY.2, s6_SetVars ;debounce
	lcall varSelect
	ljmp s0_idle
	
s0_Idle: 				;state we reset to when stop buton/switch pressed
	lcall clear_screen
	SetTemp(#0) ;oven should be off while in idle
	clr emergency ;at idle so no emergency stop
s0_loop:
	mov uniSec, #0	;keep timer at 0 while in idle state
	mov uniMin, #0
	jnb KEY.3, s1_RampToSoak ; if Key 3 pressed, jumps to s1_RampToSoak
	jnb KEY.2, s6_SetVars 		 ; if Key 2 pressed, jumps s6_SetVars
	lcall Display_LCD_L0
	sjmp s0_loop

s1_RampToSoak: 			;moves to s2_Soak when the desired soak temp is reached
	jnb KEY.3, s1_RampToSoak ;debounce
	lcall clear_screen
	setTemp(soakTemp)
	mov range, #25 ;rapid increase in temperature means we need a larger acceptable range to avoid overshooting goal temp
	lcall Display_LCD_L1
	setb ET1 ;buzzer on
	lcall Wait1Sec
	clr ET1 ;buzzer off
s1_loop:
	jb emergency, s0_idle	;if stop button pressed, go to idle
	lcall Display_LCD_L1
	jnb Pwmdone, s1_loop	;wait for ramp to finish then go to S2
	
s2_Soak:
	lcall clear_screen
	HoldTemp(soakTimeMin, soakTimeSec)
	lcall Display_LCD_L2
	setb ET1 ;buzzer on
	lcall Wait1Sec
	clr ET1 ;buzzer off
s2_loop:
	jb emergency, s0_idle	;if stop button pressed, go to idle
	lcall Display_LCD_L2
	jnb Pwmdone, s2_loop	;wait for ramp to finish then go to S3

s3_RampToPeak: 			;moves to s4_Reflow when the desired reflow temp is reached
	lcall clear_screen
	SetTemp(ReflowTemp)
	mov range, #5	;lower acceptable range to avoid burning board
	lcall Display_LCD_L3
	setb ET1 ;buzzer on
	lcall Wait1Sec
	clr ET1 ;buzzer off
s3_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L3
	jnb Pwmdone, s3_loop

s4_Reflow: 				;moves to s5_Cooling after y seconds (y=reflow time)
	lcall clear_screen
	HoldTemp(ReflowTimeMin, ReflowTimeSec)
	lcall Display_LCD_L4
	setb ET1 ;buzzer
	lcall Wait1Sec
	clr ET1
s4_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L4
	jnb Pwmdone, s4_loop

s5_Cooling: 			;moves to s0_idle when temp is less than 60 degrees
	lcall clear_screen
	setTemp(#60)
	mov range, #0
	lcall Display_LCD_DOOR
	setb ET1 ;long buzzer
	lcall Wait1Sec
	lcall Wait1Sec
	lcall Wait1Sec
	clr ET1
	lcall clear_screen
s5_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L5
	jnb Pwmdone, s5_loop
	setTemp(#20)
	mov R5, #6 ;done cooling, need to buzz 6 times
CoolingBuzzer:
	setb ET1
	lcall Wait1Sec
	lcall Display_LCD_L5 ;need to call display so it doesn't lock up during buzzer
	clr ET1
	lcall Wait1Sec
	lcall Display_LCD_L5
	djnz R5, CoolingBuzzer
	ljmp s0_idle

JumpToIdle:
	ljmp s0_idle
	
;=================================================================
; THE END OF THE STATE MACHINE. THANK YOU. WE'LL BE HERE ALL WEEK.
;=================================================================
	
ISR_timer1: ;when ET1 is enabled, complements our buzzer pin with the specified frequency
	mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    cpl BUZZERPIN
	reti
	
Wait1Sec:
	push AR0
	push AR1
	push AR2
	mov R0, #180
WaitL0:
	mov R1, #200
WaitL1:
	mov R2, #200
WaitL2:
	djnz R2, WaitL2
	djnz R1, WaitL1
	djnz R0, WaitL0
	pop AR2
	pop AR1
	pop AR0
	ret
	
InitTimer1:
	mov timer1_count, #200 ; counter to slow down the running of the ISR
	clr TR1 ; Disable timer 1
	clr TF1
    mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    setb TR1 ; Enable timer 1
    ret
	
END