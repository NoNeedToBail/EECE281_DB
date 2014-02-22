;=============================================================================
;TempDisp.asm - library of functions for reading and outputting temperature by the serial port
;Required "EQU"s
;FREQ: 33333333
;BAUD: 115200
;T2LOAD: 65536-(CLK/(32*BAUD))

;Required Pins:
;MISO
;MOSI 
;SCLK
;CE_ADC
;CE_EE
;CE_RTC

;This library needs math16.asm to function
;============================================================================

Init_Temp:; the function above is the function u guys should call in the beginning to initialize our crap
	setb CE_ADC
	setb CE_EE
	clr  CE_RTC ; RTC CE is active high
	clr SCLK              ; For mode (0,0) SCLK is zero
	lcall InitSerialPort
	ret

Get_temp:
	push psw
	push acc
	push x
	push x+1
	push y
	push bcd
	push bcd+1
	push bcd+2
	push AR0
	push AR1
	push AR2
	push AR3
	push AR4
	push AR5
	push AR6
	push AR7
	
	clr TF2
	mov b, #0  ; Read channel 0 - the oven temperature
	lcall Read_ADC_Channel
	
	mov x+1, R7 ;mov read values to x
	mov x+0, R6

	Load_y(62) ;together, the next 2 functions multiply x by 125
	lcall mul16
	mov R4, x+1

	mov x+1, R7
	mov x+0, R6

	Load_y(63)
	lcall mul16
	mov R5, x+1
	
	mov x+0, R4 ;divide x by 256
	mov x+1, #0
	mov y+0, R5
	mov y+1, #0
	lcall add16
	
	Load_y(273)
	lcall sub16
	
	mov b, #1	;read channel 1 - the room temperature
	lcall Read_ADC_Channel
	mov y+0, x+0
	mov y+1, x+1
	mov x+0, R6
	mov x+1, R7 ;add room temperature to oven temperature
	
	lcall add16
	mov temperature, x ;store final value in x
	
	pop AR7
	pop AR6
	pop AR5
	pop AR4
	pop AR3
	pop AR2
	pop AR1
	pop AR0
	pop bcd+2
	pop bcd+1
	pop bcd
	pop y
	pop x+1
	pop x
	pop acc
	pop psw
	reti
	
DO_SPI_G:
	push acc
    mov R1, #0            ; Received byte stored in R1
    mov R2, #8            ; Loop counter (8-bits)
DO_SPI_G_LOOP:
    mov a, R0             ; Byte to write is in R0
    rlc a                 ; Carry flag has bit to write
    mov R0, a
    mov MOSI, c
    setb SCLK             ; Transmit
    mov c, MISO           ; Read received bit
    mov a, R1             ; Save received bit in R1
    rlc a
    mov R1, a
    clr SCLK
    djnz R2, DO_SPI_G_LOOP
    pop acc
    ret
    
Read_ADC_Channel:
	clr CE_ADC
	mov R0, #00000001B ; Start bit:1
	lcall DO_SPI_G
	
	mov a, b
	swap a
	anl a, #0F0H
	setb acc.7 ; Single mode (bit 7).
	
	mov R0, a ;  Select channel
	lcall DO_SPI_G
	mov a, R1          ; R1 contains bits 8 and 9
	anl a, #03H
	mov R7, a
	
	mov R0, #55H ; It doesn't matter what we transmit...
	lcall DO_SPI_G
	mov a, R1    ; R1 contains bits 0 to 7
	mov R6, a
	setb CE_ADC
	ret
	
putchar:
    JNB TI, putchar
    CLR TI
    MOV SBUF, a
    RET
    
Delay:
	mov R3, #255
Delay_loop:
	djnz R3, Delay_loop
	ret
	
send_number:
	mov a, bcd+1
	anl a, #0fh
	orl a, #30h ; Convert to ASCII
	lcall putchar
	mov a, bcd+0
	swap a
	anl a, #0fh
	orl a, #30h ; Convert to ASCII
	lcall putchar
	mov a, bcd+0
	anl a, #0fh
	orl a, #30h ; Convert to ASCII
	lcall putchar
	mov a, #'\n'
	lcall putchar
	mov a, #'\r'
	lcall putchar
	lcall delay
	ret
	
WaitHalfSec:
	mov R2, #90
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1
	djnz R1, L2
	djnz R2, L3
	ret
	
InitSerialPort:
	; Configure serial port and baud rate
	clr TR2 ; Disable timer 2
	mov T2CON, #30H ; RCLK=1, TCLK=1 
	mov RCAP2H, #high(T2LOAD)  
	mov RCAP2L, #low(T2LOAD)
	setb TR2 ; Enable timer 2
	mov SCON, #52H
	ret	
END