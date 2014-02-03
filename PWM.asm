$MODDE2
$NOLIST

;==============================================================
; PWM.asm: Library of functions for setting temperature.
; Variables required:
; Unimin, Unisec
; Tskmin, Tsksec
; DesiredTemp
; Temperature
; DonePWM
; Holding
;==============================================================

PWR EQU P0.0
CLK EQU 33333333
T0_Freq EQU 50
T0_RELOAD EQU 65536-(CLK/(12*T0_Freq))
RANGE EQU 5

;SetTemp - Ramps to desired temp then sets PWMDone

SetTemp MAC
	mov DesiredTemp, %0
	clr pwmdone
	clr holding
	ENDMAC
	
;HoldTemp - holds the temp for the desired length then sets PWMDone
	
HoldTemp MAC
	mov Tskmin, %0
	mov tsksec, %1
	clr pwmdone
	setb holding
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
	lcall incUniTime
	jb holding, hold
Ramp:
	lcall rampf
Hold:
	lcall holdf
Done:
	pop acc
	pop psw
	ret

falseStart:
	pop acc
	pop psw
	ret
	
;rampf - ISR function for when in ramping mode

rampf:
;my thoughts: call temp adjust
;then check to see if temp is within acceptable range to switch to plateauing
;do we care about the rate or are we assuming we're just hitting it? wait and see?
;also need to turn off bit for PWMdone, should this be done @the start of hitting a plateau?
;aka here in this function?
	lcall tempadjust
	clr c
;maybe change this to be more efficient later?
	mov a, Range
	subb a, difference
	jnc doneRamp
	ret
doneRamp:
	setb PWMdone
	ret
	
;holdf - ISR function for when in holding mode

holdf:
	lcall tempAdjust
	mov a, TskSec
	jnz NotZero
	mov a, TskMin
	jnz NotZero
	setb PWMDone
	clr holding
	ret
NotZero:
	lcall decTskTime
	ret
	
;tempAdjust - checks desired vs real temperature and sets or clears PWR
	
tempAdjust:
	clr c
	mov a, temperature
	subb a, desiredtemp
	mov difference, a
	jb acc.7, 2comp
pos:
	jnc toohot
toocold:
	setb PWR
	ret
toohot:
	clr PWR
	ret
2comp:
	cpl a
	inc a
	mov difference, a
	sjmp pos
	
;DecTskTime - decrements the time left for holding

decTskTime:
	;waiting on Alex's lab code
	
;InitTimer0 - initialization for timer 0

InitTimer0:
	mov unimin, #0
	mov unisec, #0
	mov tskmin, #0
	mov tsksec, #0
	clr pwmdone
	clr holding
	mov desiredTemp, #20
	
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
	
;IncUniTime - increments the total time that the system has been running

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