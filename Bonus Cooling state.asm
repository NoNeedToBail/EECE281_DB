TEMPAFTERFIVE EQU 220

doorCheck:
	mov y+0, #low (TEMPAFTERFIVE) 
	mov y+1, #high(TEMPAFTERFIVE) 
	
	move x+0, #low(temperature)
	move y+1, #high(temperature)
	
	lcall x_gteq_y
	
	jnb mf, dooropen	
	ljmp s5_Cooling

dooropen:
	ljmp s5_loop

s5_Cooling: 			;moves to s6_SetVars when temp is less than 60 degrees
	lcall clear_screen
	setTemp(#60)
	lcall Display_LCD_DOOR
	push AR0
	mov R0, #3
Cooling_Buzzer:
	lcall buzz1sec
	lcall wait1sec
	djnz R0, Cooling_buzzer
	pop AR0
	lcall clear_screen
	
	mov R5 #5
loopfor5:	
	jb emergency, jumpToIdle
	lcall Display_LCD_L5
	jnb Pwmdone, doorcheckloop
	ljmp s0_idle
doorcheckloop:
	lcall wait1sec
	djnz R5, loopfor5
	ljmp doorCheck
		
s5_loop:
	jb emergency, jumpToIdle
	lcall Display_LCD_L5
	jnb Pwmdone, s5_loop
	ljmp s0_idle
JumpToIdle:
	ljmp s0_idle
	
	
