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

;SetTemp - Ramps to desired temp then sets PWMDone

SetTemp MAC
	mov DesiredTemp, %0
	clr pwmdone
	clr holding
	ENDMAC
	
;HoldTemp - holds the temp for (minutes, seconds) then sets PWMDone
	
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
	
	djnz count, falseStart
	mov count, #200
	lcall incUniTime
	jb holding, hold
Ramp:
	lcall rampf
	sjmp done
Hold:
	lcall holdf
Done:
	pop acc
	pop psw
	reti

falseStart:
	pop acc
	pop psw
	reti
	
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
	mov a, #Range
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
	jb acc.7, twoscomp
pos:
	jnc toohot
toocold:
	setb PWR
	ret
toohot:
	clr PWR
	ret
twoscomp:
	cpl a
	inc a
	mov difference, a
	sjmp pos
	
;DecTskTime - decrements the time left for holding

decTskTime:

	mov a, tsksec
	dec a
	mov tsksec, a
	
	cjne a, #11111111b , noRollBack
	mov tsksec, #01011001b
	mov a, tskmin
	dec a
	mov tskmin, a
	cjne a, #11111111b, noRollbackMin
	sjmp noManualDAMin
	
noRollBackMin:
	anl a, #0fh
	cjne a, #00001111b, noManualDA
	clr c
	mov a, tskmin
	subb a, #06
	mov tskmin, a 
	
noManualDAMin:
	mov a, tsksec
	
noRollBack:
    anl a, #0fh
	cjne a, #00001111b, noManualDA
	clr c
	mov a, tsksec
	subb a, #06
	mov tsksec, a 	
	
noManualDA:
	ret
	
	
;InitTimer0 - initialization for timer 0

InitTimer0:
	mov unimin, #0
	mov unisec, #0
	mov tskmin, #0
	mov tsksec, #0
	clr pwmdone
	clr holding
	mov desiredTemp, #20
	mov TH0, #high(T0_RELOAD)
	mov TL0, #low(T0_RELOAD)	;initial frequency of genereated function
	
	;clr TR0
	;clr TF0
	;has a 20 ms delay so need 50 to make second (can only go to like 23 ms)

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