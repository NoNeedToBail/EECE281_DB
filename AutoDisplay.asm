;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Sun Apr 06 18:15:23 2014
;--------------------------------------------------------
$name AutoDisplay
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public __c51_external_startup
	public _SPIWrite
	public _motorISR
	public _timeISR
	public _main
	public _k
	public _first_line
	public _motorRight
	public _motorLeft
	public _orientation
	public _autonomous
	public _totalpower
	public _travelled
	public _distance
	public _systime
	public _pwmcount
	public _getDistance
	public _parallelpark
	public _turn180
	public _implement_command
	public _changeDistance
	public _rx_byte
	public _waitms
	public _wait_bit_time
	public _wait_one_and_half_bit_time
	public _GetADC
	public _voltage
	public _lcdcmd
	public _display
	public _delay
	public _lcdinit
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_B              DATA 0xf0
_PSW            DATA 0xd0
_SP             DATA 0x81
_SPX            DATA 0xef
_DPL            DATA 0x82
_DPH            DATA 0x83
_DPLB           DATA 0xd4
_DPHB           DATA 0xd5
_PAGE           DATA 0xf6
_AX             DATA 0xe1
_BX             DATA 0xf7
_DSPR           DATA 0xe2
_FIRD           DATA 0xe3
_MACL           DATA 0xe4
_MACH           DATA 0xe5
_PCON           DATA 0x87
_AUXR           DATA 0x8e
_AUXR1          DATA 0xa2
_DPCF           DATA 0xa1
_CKRL           DATA 0x97
_CKCKON0        DATA 0x8f
_CKCKON1        DATA 0xaf
_CKSEL          DATA 0x85
_CLKREG         DATA 0xae
_OSCCON         DATA 0x85
_IE             DATA 0xa8
_IEN0           DATA 0xa8
_IEN1           DATA 0xb1
_IPH0           DATA 0xb7
_IP             DATA 0xb8
_IPL0           DATA 0xb8
_IPH1           DATA 0xb3
_IPL1           DATA 0xb2
_P0             DATA 0x80
_P1             DATA 0x90
_P2             DATA 0xa0
_P3             DATA 0xb0
_P4             DATA 0xc0
_P0M0           DATA 0xe6
_P0M1           DATA 0xe7
_P1M0           DATA 0xd6
_P1M1           DATA 0xd7
_P2M0           DATA 0xce
_P2M1           DATA 0xcf
_P3M0           DATA 0xc6
_P3M1           DATA 0xc7
_P4M0           DATA 0xbe
_P4M1           DATA 0xbf
_SCON           DATA 0x98
_SBUF           DATA 0x99
_SADEN          DATA 0xb9
_SADDR          DATA 0xa9
_BDRCON         DATA 0x9b
_BRL            DATA 0x9a
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TCONB          DATA 0x91
_TL0            DATA 0x8a
_TH0            DATA 0x8c
_TL1            DATA 0x8b
_TH1            DATA 0x8d
_RL0            DATA 0xf2
_RH0            DATA 0xf4
_RL1            DATA 0xf3
_RH1            DATA 0xf5
_WDTRST         DATA 0xa6
_WDTPRG         DATA 0xa7
_T2CON          DATA 0xc8
_T2MOD          DATA 0xc9
_RCAP2H         DATA 0xcb
_RCAP2L         DATA 0xca
_TH2            DATA 0xcd
_TL2            DATA 0xcc
_SPCON          DATA 0xc3
_SPSTA          DATA 0xc4
_SPDAT          DATA 0xc5
_SSCON          DATA 0x93
_SSCS           DATA 0x94
_SSDAT          DATA 0x95
_SSADR          DATA 0x96
_KBLS           DATA 0x9c
_KBE            DATA 0x9d
_KBF            DATA 0x9e
_KBMOD          DATA 0x9f
_BMSEL          DATA 0x92
_FCON           DATA 0xd2
_EECON          DATA 0xd2
_ACSRA          DATA 0xa3
_ACSRB          DATA 0xab
_AREF           DATA 0xbd
_DADC           DATA 0xa4
_DADI           DATA 0xa5
_DADL           DATA 0xac
_DADH           DATA 0xad
_CCON           DATA 0xd8
_CMOD           DATA 0xd9
_CL             DATA 0xe9
_CH             DATA 0xf9
_CCAPM0         DATA 0xda
_CCAPM1         DATA 0xdb
_CCAPM2         DATA 0xdc
_CCAPM3         DATA 0xdd
_CCAPM4         DATA 0xde
_CCAP0H         DATA 0xfa
_CCAP1H         DATA 0xfb
_CCAP2H         DATA 0xfc
_CCAP3H         DATA 0xfd
_CCAP4H         DATA 0xfe
_CCAP0L         DATA 0xea
_CCAP1L         DATA 0xeb
_CCAP2L         DATA 0xec
_CCAP3L         DATA 0xed
_CCAP4L         DATA 0xee
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_P              BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES             BIT 0xac
_ET2            BIT 0xad
_EC             BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS             BIT 0xbc
_PT2            BIT 0xbd
_IP0D           BIT 0xbf
_PPCL           BIT 0xbe
_PT2L           BIT 0xbd
_PLS            BIT 0xbc
_PT1L           BIT 0xbb
_PX1L           BIT 0xba
_PT0L           BIT 0xb9
_PX0L           BIT 0xb8
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_RXD            BIT 0xb0
_TXD            BIT 0xb1
_INT0           BIT 0xb2
_INT1           BIT 0xb3
_T0             BIT 0xb4
_T1             BIT 0xb5
_WR             BIT 0xb6
_RD             BIT 0xb7
_P4_0           BIT 0xc0
_P4_1           BIT 0xc1
_P4_2           BIT 0xc2
_P4_3           BIT 0xc3
_P4_4           BIT 0xc4
_P4_5           BIT 0xc5
_P4_6           BIT 0xc6
_P4_7           BIT 0xc7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_SM2            BIT 0x9d
_SM1            BIT 0x9e
_SM0            BIT 0x9f
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_CP_RL2         BIT 0xc8
_C_T2           BIT 0xc9
_TR2            BIT 0xca
_EXEN2          BIT 0xcb
_TCLK           BIT 0xcc
_RCLK           BIT 0xcd
_EXF2           BIT 0xce
_TF2            BIT 0xcf
_CF             BIT 0xdf
_CR             BIT 0xde
_CCF4           BIT 0xdc
_CCF3           BIT 0xdb
_CCF2           BIT 0xda
_CCF1           BIT 0xd9
_CCF0           BIT 0xd8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; overlayable bit register bank
;--------------------------------------------------------
	rseg BIT_BANK
bits:
	ds 1
	b0 equ  bits.0 
	b1 equ  bits.1 
	b2 equ  bits.2 
	b3 equ  bits.3 
	b4 equ  bits.4 
	b5 equ  bits.5 
	b6 equ  bits.6 
	b7 equ  bits.7 
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_pwmcount:
	ds 2
_systime:
	ds 4
_distance:
	ds 2
_travelled:
	ds 4
_totalpower:
	ds 2
_autonomous:
	ds 2
_orientation:
	ds 2
_motorLeft:
	ds 4
_motorRight:
	ds 4
_first_line:
	ds 16
_k:
	ds 2
_main_left_1_56:
	ds 4
_main_right_1_56:
	ds 4
_main_rec_1_56:
	ds 2
_main_z_1_56:
	ds 2
_main_temp_4_61:
	ds 4
_main_sloc0_1_0:
	ds 4
_main_sloc1_1_0:
	ds 4
_motorISR_sloc0_1_0:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_motorISR_sloc1_1_0:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x000b
	ljmp	_motorISR
	CSEG at 0x001b
	ljmp	_timeISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:71: volatile long unsigned systime = 0;
	clr	a
	mov	_systime,a
	mov	(_systime + 1),a
	mov	(_systime + 2),a
	mov	(_systime + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:72: int distance = 1200;
	mov	_distance,#0xB0
	mov	(_distance + 1),#0x04
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:73: volatile long travelled = 0;
	clr	a
	mov	_travelled,a
	mov	(_travelled + 1),a
	mov	(_travelled + 2),a
	mov	(_travelled + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:74: int totalpower = 50;
	mov	_totalpower,#0x32
	clr	a
	mov	(_totalpower + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:75: int autonomous = 1;
	mov	_autonomous,#0x01
	clr	a
	mov	(_autonomous + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:76: int orientation = FORWARD;
	mov	_orientation,#0x01
	clr	a
	mov	(_orientation + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:79: int k=0;
	clr	a
	mov	_k,a
	mov	(_k + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;command                   Allocated to registers r2 r3 r4 r5 
;left                      Allocated with name '_main_left_1_56'
;right                     Allocated with name '_main_right_1_56'
;rec                       Allocated with name '_main_rec_1_56'
;i                         Allocated to registers r6 r7 
;z                         Allocated with name '_main_z_1_56'
;temp                      Allocated with name '_main_temp_4_61'
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:81: void main (void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	using	0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:83: int rec, i, z=0;
	clr	a
	mov	_main_z_1_56,a
	mov	(_main_z_1_56 + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:85: lcdinit(); //initalizes LCD display
	lcall	_lcdinit
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:87: while (1) {
L002031?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:88: rec = 0; //Gets set to a 1 if magnetic field is being transmitted
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:89: for (i = 0; i < 4; i++){ //Prevents fluctuations from starting the signal receiving process
	clr	a
	mov	_main_rec_1_56,a
	mov	(_main_rec_1_56 + 1),a
	mov	r6,a
	mov	r7,a
L002033?:
	clr	c
	mov	a,r6
	subb	a,#0x04
	mov	a,r7
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L002036?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:90: if (voltage(0) > MIN){ //If voltage is a logic one then we're not receiving a signal
	mov	dpl,#0x00
	push	ar6
	push	ar7
	lcall	_voltage
	mov	r4,dpl
	mov	r5,dph
	pop	ar7
	pop	ar6
	clr	c
	mov	a,#0xC8
	subb	a,r4
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	L002035?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:91: rec = 1;
	mov	_main_rec_1_56,#0x01
	clr	a
	mov	(_main_rec_1_56 + 1),a
L002035?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:89: for (i = 0; i < 4; i++){ //Prevents fluctuations from starting the signal receiving process
	inc	r6
	cjne	r6,#0x00,L002033?
	inc	r7
	sjmp	L002033?
L002036?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:94: if (rec){
	mov	a,_main_rec_1_56
	orl	a,(_main_rec_1_56 + 1)
	jnz	L002059?
	ljmp	L002020?
L002059?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:95: right = getDistance(2);
	mov	dptr,#0x0002
	lcall	_getDistance
	mov	r4,dpl
	mov	r5,dph
	mov	_main_right_1_56,r4
	mov	a,r5
	mov	(_main_right_1_56 + 1),a
	rlc	a
	subb	a,acc
	mov	(_main_right_1_56 + 2),a
	mov	(_main_right_1_56 + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:96: left = getDistance(1);
	mov	dptr,#0x0001
	lcall	_getDistance
	mov	r2,dpl
	mov	r3,dph
	mov	_main_left_1_56,r2
	mov	a,r3
	mov	(_main_left_1_56 + 1),a
	rlc	a
	subb	a,acc
	mov	(_main_left_1_56 + 2),a
	mov	(_main_left_1_56 + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:98: if (orientation == REVERSE){ //This allows us to abstract to the left motor and right motor, regardless of orientation
	mov	a,_orientation
	orl	a,(_orientation + 1)
	jnz	L002004?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:99: long temp = left;
	mov	_main_temp_4_61,_main_left_1_56
	mov	(_main_temp_4_61 + 1),(_main_left_1_56 + 1)
	mov	(_main_temp_4_61 + 2),(_main_left_1_56 + 2)
	mov	(_main_temp_4_61 + 3),(_main_left_1_56 + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:100: left = right;
	mov	_main_left_1_56,_main_right_1_56
	mov	(_main_left_1_56 + 1),(_main_right_1_56 + 1)
	mov	(_main_left_1_56 + 2),(_main_right_1_56 + 2)
	mov	(_main_left_1_56 + 3),(_main_right_1_56 + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:101: right = temp;
	mov	_main_right_1_56,_main_temp_4_61
	mov	(_main_right_1_56 + 1),(_main_temp_4_61 + 1)
	mov	(_main_right_1_56 + 2),(_main_temp_4_61 + 2)
	mov	(_main_right_1_56 + 3),(_main_temp_4_61 + 3)
L002004?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:104: if (autonomous){
	mov	a,_autonomous
	orl	a,(_autonomous + 1)
	jnz	L002061?
	ljmp	L002021?
L002061?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:105: if (left > right + 300){ //Left wheel is too far back
	mov	a,#0x2C
	add	a,_main_right_1_56
	mov	r6,a
	mov	a,#0x01
	addc	a,(_main_right_1_56 + 1)
	mov	r7,a
	clr	a
	addc	a,(_main_right_1_56 + 2)
	mov	r2,a
	clr	a
	addc	a,(_main_right_1_56 + 3)
	mov	r3,a
	clr	c
	mov	a,r6
	subb	a,_main_left_1_56
	mov	a,r7
	subb	a,(_main_left_1_56 + 1)
	mov	a,r2
	subb	a,(_main_left_1_56 + 2)
	mov	a,r3
	xrl	a,#0x80
	mov	b,(_main_left_1_56 + 3)
	xrl	b,#0x80
	subb	a,b
	jnc	L002015?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:106: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:107: motorLeft.power = totalpower;
	mov	_motorLeft,_totalpower
	mov	(_motorLeft + 1),(_totalpower + 1)
	ljmp	L002021?
L002015?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:108: } else if (right > left + 300){ //Right wheel is too far back
	mov	a,#0x2C
	add	a,_main_left_1_56
	mov	r2,a
	mov	a,#0x01
	addc	a,(_main_left_1_56 + 1)
	mov	r3,a
	clr	a
	addc	a,(_main_left_1_56 + 2)
	mov	r4,a
	clr	a
	addc	a,(_main_left_1_56 + 3)
	mov	r5,a
	clr	c
	mov	a,r2
	subb	a,_main_right_1_56
	mov	a,r3
	subb	a,(_main_right_1_56 + 1)
	mov	a,r4
	subb	a,(_main_right_1_56 + 2)
	mov	a,r5
	xrl	a,#0x80
	mov	b,(_main_right_1_56 + 3)
	xrl	b,#0x80
	subb	a,b
	jnc	L002012?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:109: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:110: motorRight.power = totalpower;
	mov	_motorRight,_totalpower
	mov	(_motorRight + 1),(_totalpower + 1)
	ljmp	L002021?
L002012?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:111: } else if (left > distance * ERROR){ //Angle ok, robot too far away
	mov	dpl,_distance
	mov	dph,(_distance + 1)
	lcall	___sint2fs
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	push	_main_sloc0_1_0
	push	(_main_sloc0_1_0 + 1)
	push	(_main_sloc0_1_0 + 2)
	push	(_main_sloc0_1_0 + 3)
	mov	dptr,#0x999A
	mov	b,#0x99
	mov	a,#0x3F
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r2,b
	mov	r3,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_left_1_56
	mov	dph,(_main_left_1_56 + 1)
	mov	b,(_main_left_1_56 + 2)
	mov	a,(_main_left_1_56 + 3)
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	lcall	___slong2fs
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar2
	push	ar3
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L002009?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:112: motorLeft.direction = FORWARD;
	mov	(_motorLeft + 0x0002),#0x01
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:113: motorRight.direction = FORWARD;
	mov	(_motorRight + 0x0002),#0x01
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:114: motorLeft.power = totalpower;
	mov	_motorLeft,_totalpower
	mov	(_motorLeft + 1),(_totalpower + 1)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:115: motorRight.power = totalpower;
	mov	_motorRight,_totalpower
	mov	(_motorRight + 1),(_totalpower + 1)
	ljmp	L002021?
L002009?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:116: } else if (left < distance / ERROR){ //Robot too close
	mov	a,#0x9A
	push	acc
	mov	a,#0x99
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L002006?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:117: motorLeft.direction = REVERSE;
	mov	(_motorLeft + 0x0002),#0x00
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:118: motorRight.direction = REVERSE;
	mov	(_motorRight + 0x0002),#0x00
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:119: motorLeft.power = totalpower;
	mov	_motorLeft,_totalpower
	mov	(_motorLeft + 1),(_totalpower + 1)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:120: motorRight.power = totalpower;
	mov	_motorRight,_totalpower
	mov	(_motorRight + 1),(_totalpower + 1)
	sjmp	L002021?
L002006?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:122: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:123: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
	sjmp	L002021?
L002020?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:127: motorLeft.power = 0; //Turn the motors off while waiting for command
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:128: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:129: waitms(10); //this makes sure that the power change takes effect before shutting off the interrupt
	mov	dptr,#(0x0A&0x00ff)
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:130: command = rx_byte();
	lcall	_rx_byte
	mov	r2,dpl
	mov	r3,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:131: implement_command(command);
	mov	dpl,r2
	mov	dph,r3
	lcall	_implement_command
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:132: waitms(200); //prevents receiving commands back to back
	mov	dptr,#(0xC8&0x00ff)
	clr	a
	mov	b,a
	lcall	_waitms
L002021?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:134: z++;
	inc	_main_z_1_56
	clr	a
	cjne	a,_main_z_1_56,L002066?
	inc	(_main_z_1_56 + 1)
L002066?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:135: if(z >= 5){ //Prevents LCD display from refreshing too fast and flickering
	clr	c
	mov	a,_main_z_1_56
	subb	a,#0x05
	mov	a,(_main_z_1_56 + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L002067?
	ljmp	L002031?
L002067?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:136: z = 0;
	clr	a
	mov	_main_z_1_56,a
	mov	(_main_z_1_56 + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:137: sprintf(first_line, "SPD=%dcm/s      ", (int)((motorLeft.power + motorRight.power) / 2.0 * RATIO));
	mov	a,_motorRight
	add	a,_motorLeft
	mov	dpl,a
	mov	a,(_motorRight + 1)
	addc	a,(_motorLeft + 1)
	mov	dph,a
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xD70A
	mov	b,#0x23
	mov	a,#0x3E
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	push	ar2
	push	ar3
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_first_line
	push	acc
	mov	a,#(_first_line >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:138: lcdcmd(0x80); //Print on the first line
	mov	dpl,#0x80
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:139: k=0;
	clr	a
	mov	_k,a
	mov	(_k + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:140: while(first_line[k]!='\0') {
L002022?:
	mov	a,_k
	add	a,#_first_line
	mov	r0,a
	mov	a,@r0
	mov	r2,a
	jz	L002024?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:141: display(first_line[k]);
	mov	dpl,r2
	lcall	_display
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:142: k++;
	inc	_k
	clr	a
	cjne	a,_k,L002022?
	inc	(_k + 1)
	sjmp	L002022?
L002024?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:144: sprintf(first_line, "Travelled=%dcm", (int)(travelled/100.0));             
	mov	dpl,_travelled
	mov	dph,(_travelled + 1)
	mov	b,(_travelled + 2)
	mov	a,(_travelled + 3)
	lcall	___slong2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	push	acc
	push	acc
	mov	a,#0xC8
	push	acc
	mov	a,#0x42
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	push	ar2
	push	ar3
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_first_line
	push	acc
	mov	a,#(_first_line >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:145: lcdcmd(0xC0); //Print on the second line
	mov	dpl,#0xC0
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:146: k=0;
	clr	a
	mov	_k,a
	mov	(_k + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:147: while(first_line[k]!='\0') {
L002025?:
	mov	a,_k
	add	a,#_first_line
	mov	r0,a
	mov	a,@r0
	mov	r2,a
	jnz	L002070?
	ljmp	L002031?
L002070?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:148: display(first_line[k]);
	mov	dpl,r2
	lcall	_display
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:149: k++;
	inc	_k
	clr	a
	cjne	a,_k,L002025?
	inc	(_k + 1)
	sjmp	L002025?
;------------------------------------------------------------
;Allocation info for local variables in function 'timeISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:155: void timeISR (void) interrupt 3 { //Timer 1 runs every millisecond and gives us a millisecond timer
;	-----------------------------------------
;	 function timeISR
;	-----------------------------------------
_timeISR:
	push	acc
	push	psw
	mov	psw,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:156: systime++;
	mov	a,#0x01
	add	a,_systime
	mov	_systime,a
	clr	a
	addc	a,(_systime + 1)
	mov	(_systime + 1),a
	clr	a
	addc	a,(_systime + 2)
	mov	(_systime + 2),a
	clr	a
	addc	a,(_systime + 3)
	mov	(_systime + 3),a
	pop	psw
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'motorISR'
;------------------------------------------------------------
;sloc0                     Allocated with name '_motorISR_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:159: void motorISR (void) interrupt 1 {
;	-----------------------------------------
;	 function motorISR
;	-----------------------------------------
_motorISR:
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:160: if((pwmcount+=5) > 99){ //Frequency is 2000, 2000 / 5 = 100 for 100Hz PWM signal
	mov	a,#0x05
	add	a,_pwmcount
	mov	r2,a
	clr	a
	addc	a,(_pwmcount + 1)
	mov	r3,a
	mov	_pwmcount,r2
	mov	(_pwmcount + 1),r3
	clr	c
	mov	a,#0x63
	subb	a,r2
	clr	a
	subb	a,r3
	jc	L004010?
	ljmp	L004002?
L004010?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:161: pwmcount = 0;
	clr	a
	mov	_pwmcount,a
	mov	(_pwmcount + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:162: travelled += (motorLeft.power + motorRight.power) / 2 * RATIO; //tracks the distance travelled
	mov	a,_motorRight
	add	a,_motorLeft
	mov	dpl,a
	mov	a,(_motorRight + 1)
	addc	a,(_motorLeft + 1)
	mov	dph,a
	mov	__divsint_PARM_2,#0x02
	clr	a
	mov	(__divsint_PARM_2 + 1),a
	lcall	__divsint
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xD70A
	mov	b,#0x23
	mov	a,#0x3E
	lcall	___fsmul
	mov	_motorISR_sloc0_1_0,dpl
	mov	(_motorISR_sloc0_1_0 + 1),dph
	mov	(_motorISR_sloc0_1_0 + 2),b
	mov	(_motorISR_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_travelled
	mov	dph,(_travelled + 1)
	mov	b,(_travelled + 2)
	mov	a,(_travelled + 3)
	lcall	___slong2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r2,b
	mov	r3,a
	push	_motorISR_sloc0_1_0
	push	(_motorISR_sloc0_1_0 + 1)
	push	(_motorISR_sloc0_1_0 + 2)
	push	(_motorISR_sloc0_1_0 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r2
	mov	a,r3
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2slong
	mov	_travelled,dpl
	mov	(_travelled + 1),dph
	mov	(_travelled + 2),b
	mov	(_travelled + 3),a
L004002?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:165: if (orientation == REVERSE) {
	mov	a,_orientation
	orl	a,(_orientation + 1)
	jz	L004011?
	ljmp	L004004?
L004011?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:166: M1P = (motorLeft.power > pwmcount ? 1 : 0) * motorLeft.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorLeft
	mov	a,(_pwmcount + 1)
	subb	a,(_motorLeft + 1)
	mov	_motorISR_sloc1_1_0,c
	mov	r2,(_motorLeft + 0x0002)
	mov	r3,((_motorLeft + 0x0002) + 1)
	mov	c,_motorISR_sloc1_1_0
	clr	a
	rlc	a
	mov	r4,a
	mov	r5,#0x00
	mov	__mulint_PARM_2,r2
	mov	(__mulint_PARM_2 + 1),r3
	mov	dpl,r4
	mov	dph,r5
	push	ar2
	push	ar3
	lcall	__mulint
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
	mov	a,r4
	orl	a,r5
	add	a,#0xff
	mov	_P0_2,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:167: M1N = (motorLeft.power > pwmcount ? 1 : 0) * !motorLeft.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorLeft
	mov	a,(_pwmcount + 1)
	subb	a,(_motorLeft + 1)
	clr	a
	rlc	a
	mov	r4,a
	mov	a,r2
	orl	a,r3
	cjne	a,#0x01,L004012?
L004012?:
	clr	a
	rlc	a
	mov	r2,a
	mov	b,r2
	mov	a,r4
	mul	ab
	add	a,#0xff
	mov	_P0_3,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:169: M2P = (motorRight.power > pwmcount ? 1 : 0) * motorRight.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorRight
	mov	a,(_pwmcount + 1)
	subb	a,(_motorRight + 1)
	mov	_motorISR_sloc1_1_0,c
	mov	r2,(_motorRight + 0x0002)
	mov	r3,((_motorRight + 0x0002) + 1)
	mov	c,_motorISR_sloc1_1_0
	clr	a
	rlc	a
	mov	r4,a
	mov	r5,#0x00
	mov	__mulint_PARM_2,r2
	mov	(__mulint_PARM_2 + 1),r3
	mov	dpl,r4
	mov	dph,r5
	push	ar2
	push	ar3
	lcall	__mulint
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
	mov	a,r4
	orl	a,r5
	add	a,#0xff
	mov	_P0_0,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:170: M2N = (motorRight.power > pwmcount ? 1 : 0) * !motorRight.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorRight
	mov	a,(_pwmcount + 1)
	subb	a,(_motorRight + 1)
	clr	a
	rlc	a
	mov	r4,a
	mov	a,r2
	orl	a,r3
	cjne	a,#0x01,L004013?
L004013?:
	clr	a
	rlc	a
	mov	r2,a
	mov	b,r2
	mov	a,r4
	mul	ab
	add	a,#0xff
	mov	_P0_1,c
	ljmp	L004006?
L004004?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:172: M2P = (motorLeft.power > pwmcount ? 1 : 0) * !motorLeft.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorLeft
	mov	a,(_pwmcount + 1)
	subb	a,(_motorLeft + 1)
	clr	a
	rlc	a
	mov	r2,a
	mov	a,(_motorLeft + 0x0002)
	orl	a,((_motorLeft + 0x0002) + 1)
	cjne	a,#0x01,L004014?
L004014?:
	clr	a
	rlc	a
	mov	r3,a
	mov	b,r3
	mov	a,r2
	mul	ab
	add	a,#0xff
	mov	_P0_0,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:173: M2N = (motorLeft.power > pwmcount ? 1 : 0) * motorLeft.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorLeft
	mov	a,(_pwmcount + 1)
	subb	a,(_motorLeft + 1)
	mov  _motorISR_sloc1_1_0,c
	clr	a
	rlc	a
	mov	r2,a
	mov	r3,#0x00
	mov	__mulint_PARM_2,(_motorLeft + 0x0002)
	mov	(__mulint_PARM_2 + 1),((_motorLeft + 0x0002) + 1)
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r2,dpl
	mov	r3,dph
	mov	a,r2
	orl	a,r3
	add	a,#0xff
	mov	_P0_1,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:175: M1P = (motorRight.power > pwmcount ? 1 : 0) * !motorRight.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorRight
	mov	a,(_pwmcount + 1)
	subb	a,(_motorRight + 1)
	clr	a
	rlc	a
	mov	r2,a
	mov	a,(_motorRight + 0x0002)
	orl	a,((_motorRight + 0x0002) + 1)
	cjne	a,#0x01,L004015?
L004015?:
	clr	a
	rlc	a
	mov	r3,a
	mov	b,r3
	mov	a,r2
	mul	ab
	add	a,#0xff
	mov	_P0_2,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:176: M1N = (motorRight.power > pwmcount ? 1 : 0) * motorRight.direction;
	clr	c
	mov	a,_pwmcount
	subb	a,_motorRight
	mov	a,(_pwmcount + 1)
	subb	a,(_motorRight + 1)
	mov  _motorISR_sloc1_1_0,c
	clr	a
	rlc	a
	mov	r2,a
	mov	r3,#0x00
	mov	__mulint_PARM_2,(_motorRight + 0x0002)
	mov	(__mulint_PARM_2 + 1),((_motorRight + 0x0002) + 1)
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r2,dpl
	mov	r3,dph
	mov	a,r2
	orl	a,r3
	add	a,#0xff
	mov	_P0_3,c
L004006?:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'getDistance'
;------------------------------------------------------------
;sensor                    Allocated to registers r2 r3 
;v                         Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:180: int getDistance(int sensor){
;	-----------------------------------------
;	 function getDistance
;	-----------------------------------------
_getDistance:
	mov	r2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:182: v = voltage(sensor - 1);
	mov	a,r2
	dec	a
	mov	dpl,a
	lcall	_voltage
	mov	r2,dpl
	mov	a,dph
	mov	r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:183: return 3000-v;
	mov	a,#0xB8
	clr	c
	subb	a,r2
	mov	r2,a
	mov	a,#0x0B
	subb	a,r3
	mov	r3,a
	clr	a
	subb	a,r4
	clr	a
	subb	a,r5
	mov	dpl,r2
	mov	dph,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'parallelpark'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:186: void parallelpark () {
;	-----------------------------------------
;	 function parallelpark
;	-----------------------------------------
_parallelpark:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:187: orientation=!orientation; //Code was originally programmed for the opposite orientation, this is a quick fix
	mov	a,_orientation
	orl	a,(_orientation + 1)
	cjne	a,#0x01,L006003?
L006003?:
	clr	a
	rlc	a
	mov	r2,a
	mov	_orientation,r2
	mov	(_orientation + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:189: motorLeft.power = 85;
	mov	_motorLeft,#0x55
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:190: motorRight.power = 85;
	mov	_motorRight,#0x55
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:191: motorLeft.direction = FORWARD;
	mov	(_motorLeft + 0x0002),#0x01
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:192: motorRight.direction = FORWARD;
	mov	(_motorRight + 0x0002),#0x01
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:193: waitms(1100); //move back for 1100ms
	mov	dptr,#0x044C
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:195: motorLeft.power = 50;
	mov	_motorLeft,#0x32
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:196: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:197: motorLeft.direction = REVERSE;
	mov	(_motorLeft + 0x0002),#0x00
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:198: motorRight.direction = REVERSE;
	mov	(_motorRight + 0x0002),#0x00
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:199: waitms(1000); //Turn left 45 degrees
	mov	dptr,#0x03E8
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:201: motorLeft.power = 75;
	mov	_motorLeft,#0x4B
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:202: motorRight.power = 75;
	mov	_motorRight,#0x4B
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:203: waitms(1200); //Move forward
	mov	dptr,#0x04B0
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:205: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:206: motorRight.power = 50;
	mov	_motorRight,#0x32
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:207: waitms(1000); //Turn right 45 degrees to straighten out
	mov	dptr,#0x03E8
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:209: motorLeft.power = 0;
	mov	_motorLeft,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:210: motorRight.power = 0;
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:212: orientation=!orientation; //orientation is reset to original value
	clr	a
	mov	(_motorLeft + 1),a
	mov	_motorRight,a
	mov	(_motorRight + 1),a
	mov	a,_orientation
	orl	a,(_orientation + 1)
	cjne	a,#0x01,L006004?
L006004?:
	clr	a
	rlc	a
	mov	r2,a
	mov	_orientation,r2
	mov	(_orientation + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:213: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'turn180'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:216: void turn180 (void) {
;	-----------------------------------------
;	 function turn180
;	-----------------------------------------
_turn180:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:217: motorLeft.power = 50;
	mov	_motorLeft,#0x32
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:218: motorRight.power = 50;
	mov	_motorRight,#0x32
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:219: motorLeft.direction = FORWARD;
	mov	(_motorLeft + 0x0002),#0x01
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:220: motorRight.direction = REVERSE;
	mov	(_motorRight + 0x0002),#0x00
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:221: waitms(3600);
	mov	dptr,#0x0E10
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:223: orientation = !orientation;
	mov	a,_orientation
	orl	a,(_orientation + 1)
	cjne	a,#0x01,L007003?
L007003?:
	clr	a
	rlc	a
	mov	r2,a
	mov	_orientation,r2
	mov	(_orientation + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:225: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:226: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:227: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'implement_command'
;------------------------------------------------------------
;command                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:230: void implement_command (int command) {
;	-----------------------------------------
;	 function implement_command
;	-----------------------------------------
_implement_command:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:231: if (command == FLIP) {
	cjne	r2,#0x03,L008028?
	cjne	r3,#0x00,L008028?
	sjmp	L008029?
L008028?:
	ljmp	L008016?
L008029?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:232: autonomous = 0;
	clr	a
	mov	_autonomous,a
	mov	(_autonomous + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:233: sprintf(first_line, "   FLIPPING...   ", (int)(travelled/100.0)); //loads first_line with our message
	mov	dpl,_travelled
	mov	dph,(_travelled + 1)
	mov	b,(_travelled + 2)
	mov	a,(_travelled + 3)
	lcall	___slong2fs
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	clr	a
	push	acc
	push	acc
	mov	a,#0xC8
	push	acc
	mov	a,#0x42
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	___fsdiv
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	___fs2sint
	mov	r4,dpl
	mov	r5,dph
	push	ar4
	push	ar5
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_first_line
	push	acc
	mov	a,#(_first_line >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:234: lcdcmd(0x80); //print on first line
	mov	dpl,#0x80
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:235: k=0;
	clr	a
	mov	_k,a
	mov	(_k + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:236: while(first_line[k]!='\0') {
L008001?:
	mov	a,_k
	add	a,#_first_line
	mov	r0,a
	mov	a,@r0
	mov	r4,a
	jz	L008003?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:237: display(first_line[k]);
	mov	dpl,r4
	lcall	_display
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:238: k++;
	inc	_k
	clr	a
	cjne	a,_k,L008001?
	inc	(_k + 1)
	sjmp	L008001?
L008003?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:240: turn180(); //flip the robot
	lcall	_turn180
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:241: autonomous = 1;
	mov	_autonomous,#0x01
	clr	a
	mov	(_autonomous + 1),a
	ljmp	L008017?
L008016?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:242: } else if (command == CLOSE) {
	cjne	r2,#0x06,L008013?
	cjne	r3,#0x00,L008013?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:243: changeDistance(1);
	mov	dptr,#0x0001
	lcall	_changeDistance
	ljmp	L008017?
L008013?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:244: } else if (command == FAR) {
	cjne	r2,#0x0C,L008010?
	cjne	r3,#0x00,L008010?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:245: changeDistance(0);
	mov	dptr,#0x0000
	lcall	_changeDistance
	ljmp	L008017?
L008010?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:246: } else if (command == PARK) {
	cjne	r2,#0x09,L008036?
	cjne	r3,#0x00,L008036?
	sjmp	L008037?
L008036?:
	ljmp	L008017?
L008037?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:247: autonomous = 0;
	clr	a
	mov	_autonomous,a
	mov	(_autonomous + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:248: sprintf(first_line, "   PARKING...   ", (int)(travelled/100.0));             
	mov	dpl,_travelled
	mov	dph,(_travelled + 1)
	mov	b,(_travelled + 2)
	mov	a,(_travelled + 3)
	lcall	___slong2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	push	acc
	push	acc
	mov	a,#0xC8
	push	acc
	mov	a,#0x42
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	push	ar2
	push	ar3
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_first_line
	push	acc
	mov	a,#(_first_line >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:249: lcdcmd(0x80);
	mov	dpl,#0x80
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:250: k=0;
	clr	a
	mov	_k,a
	mov	(_k + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:251: while(first_line[k]!='\0') {
L008004?:
	mov	a,_k
	add	a,#_first_line
	mov	r0,a
	mov	a,@r0
	mov	r2,a
	jz	L008006?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:252: display(first_line[k]);
	mov	dpl,r2
	lcall	_display
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:253: k++;
	inc	_k
	clr	a
	cjne	a,_k,L008004?
	inc	(_k + 1)
	sjmp	L008004?
L008006?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:255: parallelpark();
	lcall	_parallelpark
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:256: autonomous = 1;
	mov	_autonomous,#0x01
	clr	a
	mov	(_autonomous + 1),a
L008017?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:258: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'changeDistance'
;------------------------------------------------------------
;change                    Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:262: void changeDistance(int change){
;	-----------------------------------------
;	 function changeDistance
;	-----------------------------------------
_changeDistance:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:263: if(change) {
	mov	a,r2
	orl	a,r3
	jz	L009006?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:264: if (distance > DISTMIN) distance -= 400;
	clr	c
	mov	a,#0x90
	subb	a,_distance
	mov	a,#(0x01 ^ 0x80)
	mov	b,(_distance + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L009008?
	mov	a,_distance
	add	a,#0x70
	mov	_distance,a
	mov	a,(_distance + 1)
	addc	a,#0xfe
	mov	(_distance + 1),a
	ret
L009006?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:266: if (distance < DISTMAX) distance += 400;
	clr	c
	mov	a,_distance
	subb	a,#0xF0
	mov	a,(_distance + 1)
	xrl	a,#0x80
	subb	a,#0x8a
	jnc	L009008?
	mov	a,#0x90
	add	a,_distance
	mov	_distance,a
	mov	a,#0x01
	addc	a,(_distance + 1)
	mov	(_distance + 1),a
L009008?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'rx_byte'
;------------------------------------------------------------
;j                         Allocated to registers r3 
;val                       Allocated to registers r2 
;v                         Allocated to registers r4 r5 
;k                         Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:270: unsigned char rx_byte (void) {
;	-----------------------------------------
;	 function rx_byte
;	-----------------------------------------
_rx_byte:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:274: ET0 = 0; //Timing is sensitive and we don't need the motors right now + motors are off
	clr	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:275: while (voltage(0)<MIN);
L010001?:
	mov	dpl,#0x00
	lcall	_voltage
	mov	r2,dpl
	mov	r3,dph
	clr	c
	mov	a,r2
	subb	a,#0xC8
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jc	L010001?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:276: val=0;
	mov	r2,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:277: wait_one_and_half_bit_time(); //Sample in the middle of the bits for less error
	push	ar2
	lcall	_wait_one_and_half_bit_time
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:278: for(j=0; j<4; j++) {
	mov	r3,#0x00
L010004?:
	cjne	r3,#0x04,L010019?
L010019?:
	jnc	L010007?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:279: v=voltage(0);
	mov	dpl,#0x00
	push	ar2
	push	ar3
	lcall	_voltage
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:280: val|=(v>MIN)?(0x01<<j):0x00;
	clr	c
	mov	a,#0xC8
	subb	a,r4
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	L010010?
	mov	b,r3
	inc	b
	mov	a,#0x01
	sjmp	L010024?
L010022?:
	add	a,acc
L010024?:
	djnz	b,L010022?
	mov	r4,a
	sjmp	L010011?
L010010?:
	mov	r4,#0x00
L010011?:
	mov	a,r4
	orl	ar2,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:281: wait_bit_time();
	push	ar2
	push	ar3
	lcall	_wait_bit_time
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:278: for(j=0; j<4; j++) {
	inc	r3
	sjmp	L010004?
L010007?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:283: ET0 = 1;
	setb	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:284: return val;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;time                      Allocated to registers r2 r3 r4 r5 
;time1                     Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:288: void waitms(long time){
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:289: long time1= systime+time;
	mov	a,r2
	add	a,_systime
	mov	r2,a
	mov	a,r3
	addc	a,(_systime + 1)
	mov	r3,a
	mov	a,r4
	addc	a,(_systime + 2)
	mov	r4,a
	mov	a,r5
	addc	a,(_systime + 3)
	mov	r5,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:290: while(!(time1 < systime));
L011001?:
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	clr	c
	mov	a,r6
	subb	a,_systime
	mov	a,r7
	subb	a,(_systime + 1)
	mov	a,r0
	subb	a,(_systime + 2)
	mov	a,r1
	subb	a,(_systime + 3)
	jnc	L011001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_bit_time'
;------------------------------------------------------------
;time_start                Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:293: void wait_bit_time (void) {
;	-----------------------------------------
;	 function wait_bit_time
;	-----------------------------------------
_wait_bit_time:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:294: long time_start=systime;
	mov	r2,_systime
	mov	r3,(_systime + 1)
	mov	r4,(_systime + 2)
	mov	r5,(_systime + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:295: while (!(systime > time_start+9)); //bit is 10ms but other code runs as well so this prevents us from losing ground over time
	mov	a,#0x09
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	clr	a
	addc	a,r4
	mov	r4,a
	clr	a
	addc	a,r5
	mov	r5,a
L012001?:
	clr	c
	mov	a,r2
	subb	a,_systime
	mov	a,r3
	subb	a,(_systime + 1)
	mov	a,r4
	subb	a,(_systime + 2)
	mov	a,r5
	subb	a,(_systime + 3)
	jnc	L012001?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:296: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_one_and_half_bit_time'
;------------------------------------------------------------
;time_start                Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:299: void wait_one_and_half_bit_time(void) {
;	-----------------------------------------
;	 function wait_one_and_half_bit_time
;	-----------------------------------------
_wait_one_and_half_bit_time:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:300: long time_start=systime;
	mov	r2,_systime
	mov	r3,(_systime + 1)
	mov	r4,(_systime + 2)
	mov	r5,(_systime + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:301: while (!(systime > time_start+14)); //same as above but for 1.5 bits
	mov	a,#0x0E
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	clr	a
	addc	a,r4
	mov	r4,a
	clr	a
	addc	a,r5
	mov	r5,a
L013001?:
	clr	c
	mov	a,r2
	subb	a,_systime
	mov	a,r3
	subb	a,(_systime + 1)
	mov	a,r4
	subb	a,(_systime + 2)
	mov	a,r5
	subb	a,(_systime + 3)
	jnc	L013001?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:302: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SPIWrite'
;------------------------------------------------------------
;value                     Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:305: void SPIWrite(unsigned char value)
;	-----------------------------------------
;	 function SPIWrite
;	-----------------------------------------
_SPIWrite:
	mov	r2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:307: SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	anl	_SPSTA,#0x7F
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:308: SPDAT=value;
	mov	_SPDAT,r2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:309: while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
L014001?:
	mov	a,#0x80
	anl	a,_SPSTA
	mov	r2,a
	cjne	r2,#0x80,L014001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'GetADC'
;------------------------------------------------------------
;channel                   Allocated to registers r2 
;adc                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:312: unsigned int GetADC(unsigned char channel) {
;	-----------------------------------------
;	 function GetADC
;	-----------------------------------------
_GetADC:
	mov	r2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:316: SPCON&=(~SPEN); // Disable SPI
	anl	_SPCON,#0xBF
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:317: SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	mov	_SPCON,#0x3F
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:318: SPCON|=SPEN; // Enable SPI
	orl	_SPCON,#0x40
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:320: CE=0; // Activate the MCP3004 ADC.
	clr	_P1_4
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:321: SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	mov	a,#0x18
	orl	a,r2
	mov	dpl,a
	lcall	_SPIWrite
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:322: for(adc=0; adc<10; adc++); // Wait for S/H to setup
	mov	r2,#0x0A
	mov	r3,#0x00
L015003?:
	dec	r2
	cjne	r2,#0xff,L015009?
	dec	r3
L015009?:
	mov	a,r2
	orl	a,r3
	jnz	L015003?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:323: SPIWrite(0x55); // Read bits 9 down to 4
	mov	dpl,#0x55
	lcall	_SPIWrite
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:324: adc=((SPDAT&0x3f)*0x100);
	mov	a,#0x3F
	anl	a,_SPDAT
	mov	r3,a
	mov	r2,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:325: SPIWrite(0x55);// Read bits 3 down to 0
	mov	dpl,#0x55
	push	ar2
	push	ar3
	lcall	_SPIWrite
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:326: CE=1; // Deactivate the MCP3004 ADC.
	setb	_P1_4
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:327: adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	mov	a,#0xF0
	anl	a,_SPDAT
	mov	r4,a
	mov	r5,#0x00
	mov	a,r4
	add	a,r2
	mov	r2,a
	mov	a,r5
	addc	a,r3
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:328: adc>>=4;
	swap	a
	xch	a,r2
	swap	a
	anl	a,#0x0f
	xrl	a,r2
	xch	a,r2
	anl	a,#0x0f
	xch	a,r2
	xrl	a,r2
	xch	a,r2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:330: return adc;
	mov	dpl,r2
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'voltage'
;------------------------------------------------------------
;channel                   Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:333: int voltage (unsigned char channel) {
;	-----------------------------------------
;	 function voltage
;	-----------------------------------------
_voltage:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:334: return ((GetADC(channel)*5)/1023.0) * 1000; // VCC=5V (measured)
	lcall	_GetADC
	mov	__mulint_PARM_2,dpl
	mov	(__mulint_PARM_2 + 1),dph
	mov	dptr,#0x0005
	lcall	__mulint
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	push	acc
	mov	a,#0xC0
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x44
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x7A
	mov	a,#0x44
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ljmp	___fs2sint
;------------------------------------------------------------
;Allocation info for local variables in function 'lcdcmd'
;------------------------------------------------------------
;value                     Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:337: void lcdcmd(unsigned char value) {
;	-----------------------------------------
;	 function lcdcmd
;	-----------------------------------------
_lcdcmd:
	mov	_P2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:339: RS=0; RW=0; EN=1;
	clr	_P4_4
	clr	_P4_0
	setb	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:340: delay(50);
	mov	dptr,#0x0032
	lcall	_delay
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:341: EN=0;
	clr	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:342: delay(50);
	mov	dptr,#0x0032
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:343: return;
	ljmp	_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'display'
;------------------------------------------------------------
;value                     Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:347: void display(unsigned char value) {
;	-----------------------------------------
;	 function display
;	-----------------------------------------
_display:
	mov	_P2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:349: RS=1; EN=1;
	setb	_P4_4
	setb	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:350: delay(500);
	mov	dptr,#0x01F4
	lcall	_delay
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:351: EN=0;
	clr	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:352: delay(50);
	mov	dptr,#0x0032
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:353: return;
	ljmp	_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'delay'
;------------------------------------------------------------
;time                      Allocated to registers r2 r3 
;i                         Allocated to registers r4 r5 
;j                         Allocated to registers r6 r7 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:356: void delay(unsigned int time) { //Time delay function
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:358: for(i=0;i<time;i++)
	mov	r4,#0x00
	mov	r5,#0x00
L019004?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L019008?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:359: for(j=0;j<5;j++);
	mov	r6,#0x05
	mov	r7,#0x00
L019003?:
	dec	r6
	cjne	r6,#0xff,L019017?
	dec	r7
L019017?:
	mov	a,r6
	orl	a,r7
	jnz	L019003?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:358: for(i=0;i<time;i++)
	inc	r4
	cjne	r4,#0x00,L019004?
	inc	r5
	sjmp	L019004?
L019008?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcdinit'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:363: void lcdinit(void) {
;	-----------------------------------------
;	 function lcdinit
;	-----------------------------------------
_lcdinit:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:364: P2=0x00;
	mov	_P2,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:365: RW=0; EN=0; RS=0;
	clr	_P4_0
	clr	_P0_7
	clr	_P4_4
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:366: delay(15000);display(0x30);delay(4500);display(0x30);delay(300);
	mov	dptr,#0x3A98
	lcall	_delay
	mov	dpl,#0x30
	lcall	_display
	mov	dptr,#0x1194
	lcall	_delay
	mov	dpl,#0x30
	lcall	_display
	mov	dptr,#0x012C
	lcall	_delay
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:367: display(0x30);delay(650);lcdcmd(0x38);delay(50);lcdcmd(0x0F);
	mov	dpl,#0x30
	lcall	_display
	mov	dptr,#0x028A
	lcall	_delay
	mov	dpl,#0x38
	lcall	_lcdcmd
	mov	dptr,#0x0032
	lcall	_delay
	mov	dpl,#0x0F
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:368: delay(50);lcdcmd(0x01);delay(50);lcdcmd(0x06);delay(50);lcdcmd(0x80);
	mov	dptr,#0x0032
	lcall	_delay
	mov	dpl,#0x01
	lcall	_lcdcmd
	mov	dptr,#0x0032
	lcall	_delay
	mov	dpl,#0x06
	lcall	_lcdcmd
	mov	dptr,#0x0032
	lcall	_delay
	mov	dpl,#0x80
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:369: delay(50);
	mov	dptr,#0x0032
	ljmp	_delay
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:372: unsigned char _c51_external_startup(void) {
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:373: P0M0=0;	P0M1=0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:374: P1M0=0;	P1M1=0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:375: P2M0=0;	P2M1=0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:376: P3M0=0;	P3M1=0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:377: AUXR=0B_0001_0001;
	mov	_AUXR,#0x11
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:378: P4M0=0;	P4M1=0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:380: PCON|=0x80;
	orl	_PCON,#0x80
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:381: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:382: BDRCON=0;
	mov	_BDRCON,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:383: BRL=BRG_VAL;
	mov	_BRL,#0xFA
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:384: BDRCON=BRR|TBCK|RBCK|SPD;
	mov	_BDRCON,#0x1E
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:386: TR0=0;
	clr	_TR0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:387: TMOD=0x11;
	mov	_TMOD,#0x11
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:388: TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	mov	_RH0,#0xFC
	mov	_TH0,#0xFC
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:389: TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	mov	_RL0,#0x67
	mov	_TL0,#0x67
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:390: TR0=1;
	setb	_TR0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:391: ET0=1;
	setb	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:392: TR1=0;
	clr	_TR1
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:393: TH1=RH1=TIMER1_RELOAD_VALUE/0x100;
	mov	_RH1,#0xF8
	mov	_TH1,#0xF8
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:394: TL1=RL1=TIMER1_RELOAD_VALUE%0x100;
	mov	_RL1,#0xCD
	mov	_TL1,#0xCD
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:395: TR1=1;
	setb	_TR1
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:396: ET1=1;
	setb	_ET1
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:397: EA=1;
	setb	_EA
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:398: return 0;
	mov	dpl,#0x00
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'SPD=%dcm/s      '
	db 0x00
__str_1:
	db 'Travelled=%dcm'
	db 0x00
__str_2:
	db '   FLIPPING...   '
	db 0x00
__str_3:
	db '   PARKING...   '
	db 0x00

	CSEG

end
