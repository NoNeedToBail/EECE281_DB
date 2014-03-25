;==============================================================
; PWM.asm: Library of functions for setting temperature.
; Variables required:
; Unimin, Unisec
; Tskmin, Tsksec
; DesiredTemp, Temperature
; PWMdone, Holding
; Difference
; Emergency
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
	lcall get_temp
	jb KEY.1, checkFalse ;check for emergency stop button
	setb emergency
CheckFalse:
	djnz count, falseStart ;only run the temperature adjustment and timer once every second
	mov count, #200
	lcall sendTemp ;sends the value of temperature, in bcd, to the serial port
	
	lcall incUniTime
	jb holding, hold ;holding will be set if we are in the process of holding at a temperature, and not set otherwise
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
	mov tskMin, #0 ;job time is 0 as this is not a time-controlled action
	mov tskSec, #0
	clr overshoot
	lcall tempadjust ;turns temperature on or off as needed and sets the value of difference
	clr c ;calling tempadjust can set c
	mov a, range
	subb a, difference ;check if the difference between actual and desired temperatures is within the acceptable range
	jnc doneRamp
	ret
doneRamp:
	setb PWMdone ;done ramping so send that to the state machine and move to overshooting mode
	setb overshoot
	ret
	
;holdf - ISR function for when in holding mode

holdf:
	mov a, TskSec ;if job time is 0, we're done
	jnz NotZero
	mov a, TskMin
	jnz NotZero
	setb PWMDone
	clr holding
	ret
	
NotZero: ;still holding
	jb overshoot, transition ;if overshoot is set, in transition state from ramping to holding
	lcall decTskTime ;if not, decrement our job time and adjust the temperature as needed
	lcall tempAdjust
	ret
	
Transition:
	mov a, temperature
	subb a, desiredTemp
	jnz keepWaiting ;if our temperature and desired temperature aren't equal, we still have work to do
	clr overshoot
	ret
keepWaiting:
	mov a, desiredTemp
	subb a, temperature
	jb acc.7, doneTransition ; if our temperature is greater than desiredTemp, keep letting it fall
	subb a, range
	jb acc.7, doneTransition ; if our temperature is greater than (desiredTemp + range), stop the oven
	clr overshoot
	ret
DoneTransition:
	clr PWR ;stop the oven early to avoid overshooting our goal temperature
	ret
	
;tempAdjust - checks desired vs real temperature and sets or clears PWR
	
tempAdjust:
	clr c
	mov a, temperature
	subb a, desiredtemp
	mov difference, a ;set the difference between temperature and desiredTemp in the difference variable
	jb acc.7, twoscomp ;if difference is negative, negate it and re-store it
pos:
	jnc toohot ;if carry is set, then temperature > desiredTemp and we shut off oven. If not we turn oven on.
toocold:
	setb PWR
	ret
toohot:
	clr PWR
	ret
twoscomp: ;invert difference
	push psw
	cpl a
	inc a
	mov difference, a
	pop psw
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
	mov unimin, #0 ;all times are 0 by default
	mov unisec, #0
	mov tskmin, #0
	mov tsksec, #0
	clr pwmdone
	clr holding
	mov desiredTemp, #20
	mov TH0, #high(T0_RELOAD)
	mov TL0, #low(T0_RELOAD)
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
	
