;=============================================================================
; Main.asm
; UI code and runnable file for the reflow oven controller.
;=============================================================================

$modde2

DSEG at 30h
	temperature:	ds	1
	desiredTemp:	ds	1

BSEG
	donePWM:	dbit	1
	
CSEG

END