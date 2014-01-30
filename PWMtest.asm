;=============================================================================
; PWMtest.asm: testing code for PWM.asm
;=============================================================================

$modde2

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

BSEG
	donePWM:	dbit	1
	holding:	dbit	1
	
CSEG

org 0000h
	ljmp myProgram
	
myProgram:
	sjmp myProgram

END