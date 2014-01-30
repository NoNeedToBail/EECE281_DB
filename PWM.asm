$MODDE2
$NOLIST

;==============================================================
; PWM.asm: Library of functions for setting temperature.
; Variables required:
; DesiredTemp
; Temperature
; TimeToReach
; DonePWM
;==============================================================

PWR EQU P0.0
CLK EQU 33333333
T0_Freq EQU 50
T0_RELOAD EQU 65536-(CLK/(12*T0_Freq))

;SetTemp - Ramps to desired temp then sets PWMDone

SetTemp MAC
	mov DesiredTemp, %0
	clr pwmdone
	
	ENDMAC
	
;HoldTemp - holds the temp for the desired length then sets PWMDone
	
HoldTemp MAC
	mov Tskmin, %0
	mov tsksec, %1
	clr pwmdone

	ENDMAC
	
;PWMISR - ISR to deal with timing and temperature adjustments
	
PWMISR:
	push psw
	push acc
	mov TH0, #high(T0_RELOAD)
	mov TL0, #low(T0_RELOAD)
	
	mov a, count
	cjne a, #50, falseStart
	mov count, #0
	lcall incUNiTime
	

falseStart:
	pop acc
	pop psw
	ret
	
;InitTimer0 - initialization for timer 0
	
InitTimer0:
	mov a, TMOD
	anl a, #0f0h
	orl a, #1	;putting timer0 in 16 bit timer mode
	clr TR0
	clr TF0
	;has a 20 ms delay so need 50 to make second (can only go to like 23 ms)
	mov TH0, #high(T0_RELOAD)
	mov TL0, #low(T0_RELOAD)	;initial frequency of genereated function
	setb TR0	;start timer 1
	setb ET0

	ret
	
;AdjustTemp - Turns the heat on or off based on current temp and desired temp
	
AdjustTemp:
	
	ret
incUniTime:
	mov a, unisec
	add a, #1
	da a 
	mov unisec, a 
	cjne a, #01100000b, notEq	;seconds overflow
	mov unisec, #00h
	mov a, unimin
	add a, #1
	da a 
	mov unimin, a 
	cjne a, #01100000b, notEq	;minutes overflow
	mov unimin, #00h
noteq:
	ret	
	
$LIST