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

;SetTemp - Ramps to desired temp then sets PWMDone

SetTemp MAC
	mov DesiredTemp, %0
	;lcall function
	ENDMAC
	
;HoldTemp - holds the temp for the desired length then sets PWMDone
	
HoldTemp MAC
	mov TimeToReach, %0
	;lcall function
	ENDMAC
	
;PWMISR - ISR to deal with timing and temperature adjustments
	
PWMISR:
	
	ret
	
;InitTimer0 - initialization for timer 0
	
InitTimer0:
	
	ret
	
;AdjustTemp - Turns the heat on or off based on current temp and desired temp
	
AdjustTemp:
	
	ret
	
$LIST