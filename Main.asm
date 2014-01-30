;=============================================================================
; Main.asm
; UI code and runnable file for the reflow oven controller.
;=============================================================================

$modde2

DSEG at 30h
	temperature:	ds	1

	;PWM Variables - don't touch!
	desiredTemp:	ds	1
	timeToReach:	ds	1
	minutes:		ds	1
	seconds:		ds	1

BSEG
	donePWM:	dbit	1
	
CSEG

END