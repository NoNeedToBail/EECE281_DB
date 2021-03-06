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
WAIT   EQU  5
MINUS  EQU  10

org 0000H
	ljmp myprogram
	
org 000BH
	ljmp PWMISR
	
org 001BH
	ljmp ISR_timer1

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
	
	mov range, #5
	
	lcall start_LCD
	lcall InitTimer0
	lcall InitTimer1
	lcall Init_Temp
	mov TMOD, #00010001b ; Timers 1 and 0 in 16-bit mode
	
	mov soakTemp, #150
	mov soakTimeMin, #1
	mov soakTimeSec, #30h
	
	mov reflowTemp, #217
	mov reflowTimeMin, #0
	mov reflowTimeSec, #45h
	
	mov P0MOD, #00111110B
	mov P1MOD, #10000000B
	mov P3MOD, #00000010B
	setb EA  ; Enable all interrupts
	
	ljmp s0_idle
	
SendTemp:
	mov x+0, temperature
	mov x+1, #0
	lcall hex2bcd
	lcall send_Number
	ret

;===============================================================
; THE STATE MACHINE, LADIES AND GENTLEMEN.
;===============================================================

s6_SetVars: 			;moves back to s0_Idle after all varibles have been set/after buton pushed
	jnb KEY.2, s6_SetVars
	lcall varSelect
	ljmp s0_idle
	
s0_Idle: 				;state we reset to when stop buton/switch pressed
	lcall clear_screen
	SetTemp(#0)
	clr emergency
s0_loop:
	mov uniSec, #0
	mov uniMin, #0
	lcall Delay
	lcall Delay
	jnb KEY.3, s1_RampToSoak ; if Key 3 pressed, jumps to s1_RampToSoak
	jnb KEY.2, s6_SetVars 		 ; if Key 2 pressed, jumps s6_SetVars
	lcall Display_LCD_L0
	lcall Delay
	lcall Delay
	lcall Display
	lcall Delay
	lcall Delay
	sjmp s0_loop

s1_RampToSoak: 			;moves to s2_Soak when the desired soak temp is reached
	jnb KEY.3, s1_RampToSoak
	lcall clear_screen
	setTemp(soakTemp)
	mov range, #25
	lcall Display_LCD_L1
	lcall Display
	setb ET1
	lcall Wait1Sec
	clr ET1
s1_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L1
	lcall Display
	lcall Wait1Sec
	jnb Pwmdone, s1_loop	
	
s2_Soak:
	lcall clear_screen
	HoldTemp(soakTimeMin, soakTimeSec)
	lcall Display_LCD_L2
	lcall Display
	setb ET1
	lcall Wait1Sec
	clr ET1
s2_loop:
	jb emergency, s0_idle
	lcall Display_LCD_L2
	lcall Display
	lcall Wait1Sec
	jnb Pwmdone, s2_loop

s3_RampToPeak: 			;moves to s4_Reflow when the desired reflow temp is reached
	lcall clear_screen
	SetTemp(ReflowTemp)
	mov range, #5
	lcall Display_LCD_L3
	lcall Display
	setb ET1
	lcall Wait1Sec
	clr ET1
s3_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L3
	lcall Display
	lcall Wait1Sec
	jnb Pwmdone, s3_loop

s4_Reflow: 				;moves to s5_Cooling after y seconds (y=relfow time)
	lcall clear_screen
	HoldTemp(ReflowTimeMin, ReflowTimeSec)
	lcall Display_LCD_L4
	lcall Display
	setb ET1
	lcall Wait1Sec
	clr ET1
	
s4_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L4
	lcall Display
	lcall Wait1Sec
	jnb Pwmdone, s4_loop
	
	sjmp s5_Cooling
	jumpToIdle:
	ljmp s0_idle

s5_Cooling: 	;moves to s6_SetVars when temp is less than 60 degrees
	lcall clear_screen
	setTemp(#60)
	mov range, #0
	lcall Display_LCD_DOOR
	lcall Display
	
	setb ET1
	lcall Wait1Sec
	lcall Wait1Sec
	lcall Wait1Sec
	clr ET1
	lcall clear_screen
		
	mov R5, #WAIT
loopfor5:	
	jb emergency, jumpToIdle
	lcall Display_LCD_L5
	lcall Display
	lcall Wait1Sec
	setTemp(#20)
	jnb Pwmdone, doorcheckloop 
	lcall sixBeep
	ljmp s0_idle
doorcheckloop:
	lcall wait1sec
	lcall Display
	djnz R5, loopfor5
	ljmp doorCheck

s5_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L5
	lcall Display
	lcall Wait1Sec
	setTemp(#20)
	jnb Pwmdone, s5_loop
	lcall sixBeep
	ljmp s0_idle

	
	
;=================================================================
; THE END OF THE STATE MACHINE. THANK YOU. WE'LL BE HERE ALL WEEK.
;=================================================================
sixBeep: 
	
	mov R5, #6
CoolingBuzzer:
	setb ET1
	lcall Wait1Sec
	lcall Display_LCD_L5
	clr ET1
	lcall Wait1Sec
	lcall Display_LCD_L5
	lcall Display
	djnz R5, CoolingBuzzer
ret	
	
	
ISR_timer1:
	
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
	
Buzz1Sec:
	setb ET1
	lcall Wait1Sec
	clr ET1
	ret
	
InitTimer1:
	mov timer1_count, #200
	clr TR1 ; Disable timer 1
	clr TF1
    mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    setb TR1 ; Enable timer 1
    ret
	
	
doorCheck:
	mov y+0, (reflowTemp-MINUS)
	mov y+1, #0
	
	mov x+0, temperature
	mov x+1, #0
	
	lcall x_gteq_y
	
	jnb mf, dooropen	
	ljmp s5_Cooling

dooropen:
	ljmp s5_loop
	
; Look-up table for 7-seg displays
hexLUT:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 099H        ; 0 TO 4
    DB 092H, 082H, 0F8H, 080H, 090H        ; 4 TO 9


Display:
	mov a, SWC ; Read switches 17 and 16
	jb acc.1, doDisplay ; if * pressed, jumps display code
	mov a, #1111111B
	mov HEX3, a
	mov HEX2, a
	mov HEX1, a
	mov HEX0, a
    ret
    
    doDisplay:
	mov x+0, temperature
	mov x+1, #0
	lcall hex2bcd
	
	mov dptr, #hexLUT
	mov HEX0, #1000110b
; Display Digit 0
    mov A, bcd+0
    anl a, #0fh
    movc A, @A+dptr
    mov HEX1, A
; Display Digit 1
    mov A, bcd+0
    swap a
    anl a, #0fh
    movc A, @A+dptr
    mov HEX2, A
; Display Digit 2    
    mov A, bcd+1
    anl a, #0fh
    movc A, @A+dptr
    mov HEX3, A
	
	ret
		
END


    
    
	
