;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Thu Apr 03 02:26:53 2014
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
	public _printCommand
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
_main_left_1_56:
	ds 4
_main_right_1_56:
	ds 4
_main_rec_1_56:
	ds 2
_main_z_1_56:
	ds 2
_main_first_line_1_56:
	ds 16
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:85: volatile long unsigned systime = 0;
	clr	a
	mov	_systime,a
	mov	(_systime + 1),a
	mov	(_systime + 2),a
	mov	(_systime + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:86: int distance = 1200;
	mov	_distance,#0xB0
	mov	(_distance + 1),#0x04
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:87: volatile long travelled = 0;
	clr	a
	mov	_travelled,a
	mov	(_travelled + 1),a
	mov	(_travelled + 2),a
	mov	(_travelled + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:88: int totalpower = 50;
	mov	_totalpower,#0x32
	clr	a
	mov	(_totalpower + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:89: int autonomous = 1;
	mov	_autonomous,#0x01
	clr	a
	mov	(_autonomous + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:90: int orientation = FORWARD;
	mov	_orientation,#0x01
	clr	a
	mov	(_orientation + 1),a
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
;k                         Allocated to registers r2 r3 
;first_line                Allocated with name '_main_first_line_1_56'
;temp                      Allocated with name '_main_temp_4_61'
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:93: void main (void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	using	0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:95: int rec, i, z=0, k=0;
	clr	a
	mov	_main_z_1_56,a
	mov	(_main_z_1_56 + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:97: P0_5=1;
	setb	_P0_5
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:99: lcdinit();
	lcall	_lcdinit
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:101: while (1) {
L002031?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:102: printf("%ld\n", travelled);
	push	_travelled
	push	(_travelled + 1)
	push	(_travelled + 2)
	push	(_travelled + 3)
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf9
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:103: rec = 1;
	mov	_main_rec_1_56,#0x01
	clr	a
	mov	(_main_rec_1_56 + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:104: for (i = 0; i < 4; i++){
	mov	r6,#0x00
	mov	r7,#0x00
L002033?:
	clr	c
	mov	a,r6
	subb	a,#0x04
	mov	a,r7
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L002036?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:105: if (voltage(0) > MIN){
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:106: rec = 0;
	clr	a
	mov	_main_rec_1_56,a
	mov	(_main_rec_1_56 + 1),a
L002035?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:104: for (i = 0; i < 4; i++){
	inc	r6
	cjne	r6,#0x00,L002033?
	inc	r7
	sjmp	L002033?
L002036?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:109: if (!rec){
	mov	a,_main_rec_1_56
	orl	a,(_main_rec_1_56 + 1)
	jz	L002060?
	ljmp	L002020?
L002060?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:110: right = getDistance(2);
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:111: left = getDistance(1);
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:113: if (orientation == REVERSE){
	mov	a,_orientation
	orl	a,(_orientation + 1)
	jnz	L002004?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:114: long temp = left;
	mov	_main_temp_4_61,_main_left_1_56
	mov	(_main_temp_4_61 + 1),(_main_left_1_56 + 1)
	mov	(_main_temp_4_61 + 2),(_main_left_1_56 + 2)
	mov	(_main_temp_4_61 + 3),(_main_left_1_56 + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:115: left = right;
	mov	_main_left_1_56,_main_right_1_56
	mov	(_main_left_1_56 + 1),(_main_right_1_56 + 1)
	mov	(_main_left_1_56 + 2),(_main_right_1_56 + 2)
	mov	(_main_left_1_56 + 3),(_main_right_1_56 + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:116: right = temp;
	mov	_main_right_1_56,_main_temp_4_61
	mov	(_main_right_1_56 + 1),(_main_temp_4_61 + 1)
	mov	(_main_right_1_56 + 2),(_main_temp_4_61 + 2)
	mov	(_main_right_1_56 + 3),(_main_temp_4_61 + 3)
L002004?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:119: if (autonomous){
	mov	a,_autonomous
	orl	a,(_autonomous + 1)
	jnz	L002062?
	ljmp	L002021?
L002062?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:120: if (left > right + 300){
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:121: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:122: motorLeft.power = totalpower;
	mov	_motorLeft,_totalpower
	mov	(_motorLeft + 1),(_totalpower + 1)
	ljmp	L002021?
L002015?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:123: } else if (right > left + 300){
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:124: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:125: motorRight.power = totalpower;
	mov	_motorRight,_totalpower
	mov	(_motorRight + 1),(_totalpower + 1)
	ljmp	L002021?
L002012?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:126: } else if (left > distance * ERROR){
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:127: motorLeft.direction = FORWARD;
	mov	(_motorLeft + 0x0002),#0x01
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:128: motorRight.direction = FORWARD;
	mov	(_motorRight + 0x0002),#0x01
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:129: motorLeft.power = totalpower;
	mov	_motorLeft,_totalpower
	mov	(_motorLeft + 1),(_totalpower + 1)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:130: motorRight.power = totalpower;
	mov	_motorRight,_totalpower
	mov	(_motorRight + 1),(_totalpower + 1)
	ljmp	L002021?
L002009?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:131: } else if (left < distance / ERROR){
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:132: motorLeft.direction = REVERSE;
	mov	(_motorLeft + 0x0002),#0x00
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:133: motorRight.direction = REVERSE;
	mov	(_motorRight + 0x0002),#0x00
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:134: motorLeft.power = totalpower;
	mov	_motorLeft,_totalpower
	mov	(_motorLeft + 1),(_totalpower + 1)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:135: motorRight.power = totalpower;
	mov	_motorRight,_totalpower
	mov	(_motorRight + 1),(_totalpower + 1)
	sjmp	L002021?
L002006?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:137: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:138: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
	sjmp	L002021?
L002020?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:142: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:143: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:144: waitms(10); //this makes sure that the power change takes effect before shutting off the interrupt
	mov	dptr,#(0x0A&0x00ff)
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:145: command = rx_byte();
	lcall	_rx_byte
	mov	r2,dpl
	mov	r3,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:146: implement_command(command);
	mov	dpl,r2
	mov	dph,r3
	lcall	_implement_command
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:147: waitms(200); //prevents receiving commands back to back
	mov	dptr,#(0xC8&0x00ff)
	clr	a
	mov	b,a
	lcall	_waitms
L002021?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:149: z++;
	inc	_main_z_1_56
	clr	a
	cjne	a,_main_z_1_56,L002067?
	inc	(_main_z_1_56 + 1)
L002067?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:150: if(z >= 5){
	clr	c
	mov	a,_main_z_1_56
	subb	a,#0x05
	mov	a,(_main_z_1_56 + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L002068?
	ljmp	L002031?
L002068?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:151: z = 0;
	clr	a
	mov	_main_z_1_56,a
	mov	(_main_z_1_56 + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:152: sprintf(first_line, "SPD=%dcm/s", (int)((motorLeft.power + motorRight.power) / 2.0 * RATIO));
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
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_main_first_line_1_56
	push	acc
	mov	a,#(_main_first_line_1_56 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:153: lcdcmd(0x80);
	mov	dpl,#0x80
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:155: while(first_line[k]!='\0') {
	mov	r2,#0x00
	mov	r3,#0x00
L002022?:
	mov	a,r2
	add	a,#_main_first_line_1_56
	mov	r0,a
	mov	a,@r0
	mov	r4,a
	jz	L002024?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:156: display(first_line[k]);
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_display
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:157: k++;
	inc	r2
	cjne	r2,#0x00,L002022?
	inc	r3
	sjmp	L002022?
L002024?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:159: sprintf(first_line, "Travelled=%dcm", (int)(travelled/100.0));             
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
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_main_first_line_1_56
	push	acc
	mov	a,#(_main_first_line_1_56 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:160: lcdcmd(0xC0);
	mov	dpl,#0xC0
	lcall	_lcdcmd
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:162: while(first_line[k]!='\0') {
	mov	r2,#0x00
	mov	r3,#0x00
L002025?:
	mov	a,r2
	add	a,#_main_first_line_1_56
	mov	r0,a
	mov	a,@r0
	mov	r4,a
	jnz	L002071?
	ljmp	L002031?
L002071?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:163: display(first_line[k]);
	mov	dpl,r4
	push	ar2
	push	ar3
	lcall	_display
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:164: k++;
	inc	r2
	cjne	r2,#0x00,L002025?
	inc	r3
	sjmp	L002025?
;------------------------------------------------------------
;Allocation info for local variables in function 'timeISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:170: void timeISR (void) interrupt 3 {
;	-----------------------------------------
;	 function timeISR
;	-----------------------------------------
_timeISR:
	push	acc
	push	psw
	mov	psw,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:171: systime++;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:174: void motorISR (void) interrupt 1 {
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:175: if((pwmcount+=5) > 99){
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:176: pwmcount = 0;
	clr	a
	mov	_pwmcount,a
	mov	(_pwmcount + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:177: travelled += (motorLeft.power + motorRight.power) / 2 * RATIO;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:180: if (orientation == REVERSE) {
	mov	a,_orientation
	orl	a,(_orientation + 1)
	jz	L004011?
	ljmp	L004004?
L004011?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:181: M1P = (motorLeft.power > pwmcount ? 1 : 0) * motorLeft.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:182: M1N = (motorLeft.power > pwmcount ? 1 : 0) * !motorLeft.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:184: M2P = (motorRight.power > pwmcount ? 1 : 0) * motorRight.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:185: M2N = (motorRight.power > pwmcount ? 1 : 0) * !motorRight.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:187: M2P = (motorLeft.power > pwmcount ? 1 : 0) * !motorLeft.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:188: M2N = (motorLeft.power > pwmcount ? 1 : 0) * motorLeft.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:190: M1P = (motorRight.power > pwmcount ? 1 : 0) * !motorRight.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:191: M1N = (motorRight.power > pwmcount ? 1 : 0) * motorRight.direction;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:195: int getDistance(int sensor){
;	-----------------------------------------
;	 function getDistance
;	-----------------------------------------
_getDistance:
	mov	r2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:197: v = voltage(sensor - 1);
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:198: return 3000-v;
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
;Allocation info for local variables in function 'printCommand'
;------------------------------------------------------------
;command                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:201: void printCommand(int command){
;	-----------------------------------------
;	 function printCommand
;	-----------------------------------------
_printCommand:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:202: if(command==FLIP)
	cjne	r2,#0x03,L006011?
	cjne	r3,#0x00,L006011?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:203: printf("Recieved flip command \n");
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	ljmp	L006012?
L006011?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:204: else if (command == PARK)
	cjne	r2,#0x09,L006008?
	cjne	r3,#0x00,L006008?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:205: printf("Received park command \n");
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	sjmp	L006012?
L006008?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:206: else if (command == CLOSE)
	cjne	r2,#0x06,L006005?
	cjne	r3,#0x00,L006005?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:207: printf("Received closer command \n");
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	sjmp	L006012?
L006005?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:208: else if (command == FAR)
	cjne	r2,#0x0C,L006002?
	cjne	r3,#0x00,L006002?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:209: printf("Received farther command \n");
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	sjmp	L006012?
L006002?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:211: printf("Received %d\n", command);
	push	ar2
	push	ar3
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
L006012?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:212: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'parallelpark'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:215: void parallelpark () {
;	-----------------------------------------
;	 function parallelpark
;	-----------------------------------------
_parallelpark:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:216: orientation=!orientation;
	mov	a,_orientation
	orl	a,(_orientation + 1)
	cjne	a,#0x01,L007003?
L007003?:
	clr	a
	rlc	a
	mov	r2,a
	mov	_orientation,r2
	mov	(_orientation + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:217: motorLeft.power = 85;
	mov	_motorLeft,#0x55
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:218: motorRight.power = 85;
	mov	_motorRight,#0x55
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:219: motorLeft.direction = FORWARD;
	mov	(_motorLeft + 0x0002),#0x01
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:220: motorRight.direction = FORWARD;
	mov	(_motorRight + 0x0002),#0x01
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:221: waitms(1100);
	mov	dptr,#0x044C
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:223: motorLeft.power = 50;
	mov	_motorLeft,#0x32
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:224: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:225: motorLeft.direction = REVERSE;
	mov	(_motorLeft + 0x0002),#0x00
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:226: motorRight.direction = REVERSE;
	mov	(_motorRight + 0x0002),#0x00
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:227: waitms(1000);
	mov	dptr,#0x03E8
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:229: motorLeft.power = 75;
	mov	_motorLeft,#0x4B
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:230: motorRight.power = 75;
	mov	_motorRight,#0x4B
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:231: waitms(900);
	mov	dptr,#0x0384
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:233: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:234: motorRight.power = 45;
	mov	_motorRight,#0x2D
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:235: waitms(1035);
	mov	dptr,#0x040B
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:237: motorLeft.power = 0;
	mov	_motorLeft,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:238: motorRight.power = 0;
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:239: orientation=!orientation;
	clr	a
	mov	(_motorLeft + 1),a
	mov	_motorRight,a
	mov	(_motorRight + 1),a
	mov	a,_orientation
	orl	a,(_orientation + 1)
	cjne	a,#0x01,L007004?
L007004?:
	clr	a
	rlc	a
	mov	r2,a
	mov	_orientation,r2
	mov	(_orientation + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:240: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'turn180'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:243: void turn180 (void) {
;	-----------------------------------------
;	 function turn180
;	-----------------------------------------
_turn180:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:244: motorLeft.power = 50;
	mov	_motorLeft,#0x32
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:245: motorRight.power = 50;
	mov	_motorRight,#0x32
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:246: motorLeft.direction = FORWARD;
	mov	(_motorLeft + 0x0002),#0x01
	mov	((_motorLeft + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:247: motorRight.direction = REVERSE;
	mov	(_motorRight + 0x0002),#0x00
	mov	((_motorRight + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:248: waitms(3250); //2650
	mov	dptr,#0x0CB2
	clr	a
	mov	b,a
	lcall	_waitms
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:250: if(orientation==FORWARD) {
	mov	a,#0x01
	cjne	a,_orientation,L008007?
	clr	a
	cjne	a,(_orientation + 1),L008007?
	sjmp	L008008?
L008007?:
	sjmp	L008002?
L008008?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:251: orientation=REVERSE;
	clr	a
	mov	_orientation,a
	mov	(_orientation + 1),a
	sjmp	L008003?
L008002?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:253: orientation=FORWARD;
	mov	_orientation,#0x01
	clr	a
	mov	(_orientation + 1),a
L008003?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:255: motorLeft.power = 0;
	mov	_motorLeft,#0x00
	mov	(_motorLeft + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:256: motorRight.power = 0;
	mov	_motorRight,#0x00
	mov	(_motorRight + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:257: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'implement_command'
;------------------------------------------------------------
;command                   Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:260: void implement_command (int command) {
;	-----------------------------------------
;	 function implement_command
;	-----------------------------------------
_implement_command:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:261: if (command == FLIP) {
	cjne	r2,#0x03,L009010?
	cjne	r3,#0x00,L009010?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:262: autonomous = 0;
	clr	a
	mov	_autonomous,a
	mov	(_autonomous + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:263: turn180();
	lcall	_turn180
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:264: autonomous = 1;
	mov	_autonomous,#0x01
	clr	a
	mov	(_autonomous + 1),a
	sjmp	L009011?
L009010?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:265: } else if (command == CLOSE) {
	cjne	r2,#0x06,L009007?
	cjne	r3,#0x00,L009007?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:266: changeDistance(1);
	mov	dptr,#0x0001
	lcall	_changeDistance
	sjmp	L009011?
L009007?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:267: } else if (command == FAR) {
	cjne	r2,#0x0C,L009004?
	cjne	r3,#0x00,L009004?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:268: changeDistance(0);
	mov	dptr,#0x0000
	lcall	_changeDistance
	sjmp	L009011?
L009004?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:269: } else if (command == PARK) {
	cjne	r2,#0x09,L009011?
	cjne	r3,#0x00,L009011?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:270: autonomous = 0;
	clr	a
	mov	_autonomous,a
	mov	(_autonomous + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:271: parallelpark();
	lcall	_parallelpark
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:272: autonomous = 1;
	mov	_autonomous,#0x01
	clr	a
	mov	(_autonomous + 1),a
L009011?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:274: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'changeDistance'
;------------------------------------------------------------
;change                    Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:277: void changeDistance(int change){
;	-----------------------------------------
;	 function changeDistance
;	-----------------------------------------
_changeDistance:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:278: if(change) {
	mov	a,r2
	orl	a,r3
	jz	L010006?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:279: if (distance > DISTMIN) distance -= 400;
	clr	c
	mov	a,#0x90
	subb	a,_distance
	mov	a,#(0x01 ^ 0x80)
	mov	b,(_distance + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L010008?
	mov	a,_distance
	add	a,#0x70
	mov	_distance,a
	mov	a,(_distance + 1)
	addc	a,#0xfe
	mov	(_distance + 1),a
	ret
L010006?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:281: if (distance < DISTMAX) distance += 400;
	clr	c
	mov	a,_distance
	subb	a,#0xF0
	mov	a,(_distance + 1)
	xrl	a,#0x80
	subb	a,#0x8a
	jnc	L010008?
	mov	a,#0x90
	add	a,_distance
	mov	_distance,a
	mov	a,#0x01
	addc	a,(_distance + 1)
	mov	(_distance + 1),a
L010008?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'rx_byte'
;------------------------------------------------------------
;j                         Allocated to registers r3 
;val                       Allocated to registers r2 
;v                         Allocated to registers r4 r5 
;k                         Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:285: unsigned char rx_byte (void) {
;	-----------------------------------------
;	 function rx_byte
;	-----------------------------------------
_rx_byte:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:289: ET0 = 0;
	clr	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:290: while (voltage(0)<MIN);
L011001?:
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
	jc	L011001?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:291: P0_5=!P0_5;
	cpl	_P0_5
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:292: val=0;
	mov	r2,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:293: wait_one_and_half_bit_time();
	push	ar2
	lcall	_wait_one_and_half_bit_time
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:294: for(j=0; j<4; j++) {
	mov	r3,#0x00
L011004?:
	cjne	r3,#0x04,L011019?
L011019?:
	jnc	L011007?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:295: v=voltage(0);
	mov	dpl,#0x00
	push	ar2
	push	ar3
	lcall	_voltage
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:296: val|=(v>MIN)?(0x01<<j):0x00;
	clr	c
	mov	a,#0xC8
	subb	a,r4
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	L011010?
	mov	b,r3
	inc	b
	mov	a,#0x01
	sjmp	L011024?
L011022?:
	add	a,acc
L011024?:
	djnz	b,L011022?
	mov	r4,a
	sjmp	L011011?
L011010?:
	mov	r4,#0x00
L011011?:
	mov	a,r4
	orl	ar2,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:297: P0_5=!P0_5;
	cpl	_P0_5
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:298: wait_bit_time();
	push	ar2
	push	ar3
	lcall	_wait_bit_time
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:294: for(j=0; j<4; j++) {
	inc	r3
	sjmp	L011004?
L011007?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:300: P0_5=1;
	setb	_P0_5
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:301: ET0 = 1;
	setb	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:302: return val;
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;time                      Allocated to registers r2 r3 r4 r5 
;time1                     Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:305: void waitms(long time){
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:306: long time1= systime+time;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:307: while(!(time1 < systime));
L012001?:
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
	jnc	L012001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_bit_time'
;------------------------------------------------------------
;time_start                Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:310: void wait_bit_time (void) {
;	-----------------------------------------
;	 function wait_bit_time
;	-----------------------------------------
_wait_bit_time:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:311: long time_start=systime;
	mov	r2,_systime
	mov	r3,(_systime + 1)
	mov	r4,(_systime + 2)
	mov	r5,(_systime + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:312: while (!(systime > time_start+9));
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:313: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait_one_and_half_bit_time'
;------------------------------------------------------------
;time_start                Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:316: void wait_one_and_half_bit_time(void) {
;	-----------------------------------------
;	 function wait_one_and_half_bit_time
;	-----------------------------------------
_wait_one_and_half_bit_time:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:317: long time_start=systime;
	mov	r2,_systime
	mov	r3,(_systime + 1)
	mov	r4,(_systime + 2)
	mov	r5,(_systime + 3)
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:318: while (!(systime > time_start+14));
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
L014001?:
	clr	c
	mov	a,r2
	subb	a,_systime
	mov	a,r3
	subb	a,(_systime + 1)
	mov	a,r4
	subb	a,(_systime + 2)
	mov	a,r5
	subb	a,(_systime + 3)
	jnc	L014001?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:319: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SPIWrite'
;------------------------------------------------------------
;value                     Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:322: void SPIWrite(unsigned char value)
;	-----------------------------------------
;	 function SPIWrite
;	-----------------------------------------
_SPIWrite:
	mov	r2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:324: SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	anl	_SPSTA,#0x7F
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:325: SPDAT=value;
	mov	_SPDAT,r2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:326: while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
L015001?:
	mov	a,#0x80
	anl	a,_SPSTA
	mov	r2,a
	cjne	r2,#0x80,L015001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'GetADC'
;------------------------------------------------------------
;channel                   Allocated to registers r2 
;adc                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:329: unsigned int GetADC(unsigned char channel) {
;	-----------------------------------------
;	 function GetADC
;	-----------------------------------------
_GetADC:
	mov	r2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:333: SPCON&=(~SPEN); // Disable SPI
	anl	_SPCON,#0xBF
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:334: SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	mov	_SPCON,#0x3F
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:335: SPCON|=SPEN; // Enable SPI
	orl	_SPCON,#0x40
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:337: CE=0; // Activate the MCP3004 ADC.
	clr	_P1_4
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:338: SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	mov	a,#0x18
	orl	a,r2
	mov	dpl,a
	lcall	_SPIWrite
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:339: for(adc=0; adc<10; adc++); // Wait for S/H to setup
	mov	r2,#0x0A
	mov	r3,#0x00
L016003?:
	dec	r2
	cjne	r2,#0xff,L016009?
	dec	r3
L016009?:
	mov	a,r2
	orl	a,r3
	jnz	L016003?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:340: SPIWrite(0x55); // Read bits 9 down to 4
	mov	dpl,#0x55
	lcall	_SPIWrite
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:341: adc=((SPDAT&0x3f)*0x100);
	mov	a,#0x3F
	anl	a,_SPDAT
	mov	r3,a
	mov	r2,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:342: SPIWrite(0x55);// Read bits 3 down to 0
	mov	dpl,#0x55
	push	ar2
	push	ar3
	lcall	_SPIWrite
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:343: CE=1; // Deactivate the MCP3004 ADC.
	setb	_P1_4
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:344: adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	mov	a,#0xF0
	anl	a,_SPDAT
	mov	r4,a
	mov	r5,#0x00
	mov	a,r4
	add	a,r2
	mov	r2,a
	mov	a,r5
	addc	a,r3
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:345: adc>>=4;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:347: return adc;
	mov	dpl,r2
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'voltage'
;------------------------------------------------------------
;channel                   Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:350: int voltage (unsigned char channel) {
;	-----------------------------------------
;	 function voltage
;	-----------------------------------------
_voltage:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:351: return ((GetADC(channel)*5)/1023.0) * 1000; // VCC=5.81V (measured)
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:354: void lcdcmd(unsigned char value)  
;	-----------------------------------------
;	 function lcdcmd
;	-----------------------------------------
_lcdcmd:
	mov	_P2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:357: RS=0; RW=0; EN=1;
	clr	_P4_4
	clr	_P4_0
	setb	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:358: delay(50);
	mov	dptr,#0x0032
	lcall	_delay
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:359: EN=0;
	clr	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:360: delay(50);
	mov	dptr,#0x0032
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:361: return;
	ljmp	_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'display'
;------------------------------------------------------------
;value                     Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:364: void display(unsigned char value)  
;	-----------------------------------------
;	 function display
;	-----------------------------------------
_display:
	mov	_P2,dpl
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:367: RS=1; EN=1;
	setb	_P4_4
	setb	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:368: delay(500);
	mov	dptr,#0x01F4
	lcall	_delay
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:369: EN=0;
	clr	_P0_7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:370: delay(50);
	mov	dptr,#0x0032
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:371: return;
	ljmp	_delay
;------------------------------------------------------------
;Allocation info for local variables in function 'delay'
;------------------------------------------------------------
;time                      Allocated to registers r2 r3 
;i                         Allocated to registers r4 r5 
;j                         Allocated to registers r6 r7 
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:374: void delay(unsigned int time)  //Time delay function
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:377: for(i=0;i<time;i++)
	mov	r4,#0x00
	mov	r5,#0x00
L020004?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L020008?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:378: for(j=0;j<5;j++);
	mov	r6,#0x05
	mov	r7,#0x00
L020003?:
	dec	r6
	cjne	r6,#0xff,L020017?
	dec	r7
L020017?:
	mov	a,r6
	orl	a,r7
	jnz	L020003?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:377: for(i=0;i<time;i++)
	inc	r4
	cjne	r4,#0x00,L020004?
	inc	r5
	sjmp	L020004?
L020008?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcdinit'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:382: void lcdinit(void)         
;	-----------------------------------------
;	 function lcdinit
;	-----------------------------------------
_lcdinit:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:384: P2=0x00;
	mov	_P2,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:385: RW=0; EN=0; RS=0;
	clr	_P4_0
	clr	_P0_7
	clr	_P4_4
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:386: delay(15000);display(0x30);delay(4500);display(0x30);delay(300);
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:387: display(0x30);delay(650);lcdcmd(0x38);delay(50);lcdcmd(0x0F);
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:388: delay(50);lcdcmd(0x01);delay(50);lcdcmd(0x06);delay(50);lcdcmd(0x80);
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:389: delay(50);
	mov	dptr,#0x0032
	ljmp	_delay
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:392: unsigned char _c51_external_startup(void) {
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:393: P0M0=0;	P0M1=0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:394: P1M0=0;	P1M1=0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:395: P2M0=0;	P2M1=0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:396: P3M0=0;	P3M1=0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:397: AUXR=0B_0001_0001;
	mov	_AUXR,#0x11
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:398: P4M0=0;	P4M1=0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:400: PCON|=0x80;
	orl	_PCON,#0x80
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:401: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:402: BDRCON=0;
	mov	_BDRCON,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:403: BRL=BRG_VAL;
	mov	_BRL,#0xFA
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:404: BDRCON=BRR|TBCK|RBCK|SPD;
	mov	_BDRCON,#0x1E
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:406: TR0=0;
	clr	_TR0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:407: TMOD=0x11;
	mov	_TMOD,#0x11
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:408: TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	mov	_RH0,#0xFC
	mov	_TH0,#0xFC
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:409: TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	mov	_RL0,#0x67
	mov	_TL0,#0x67
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:410: TR0=1;
	setb	_TR0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:411: ET0=1;
	setb	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:412: TR1=0;
	clr	_TR1
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:413: TH1=RH1=TIMER1_RELOAD_VALUE/0x100;
	mov	_RH1,#0xF8
	mov	_TH1,#0xF8
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:414: TL1=RL1=TIMER1_RELOAD_VALUE%0x100;
	mov	_RL1,#0xCD
	mov	_TL1,#0xCD
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:415: TR1=1;
	setb	_TR1
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:416: ET1=1;
	setb	_ET1
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:417: EA=1;
	setb	_EA
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\AutoDisplay.c:418: return 0;
	mov	dpl,#0x00
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db '%ld'
	db 0x0A
	db 0x00
__str_1:
	db 'SPD=%dcm/s'
	db 0x00
__str_2:
	db 'Travelled=%dcm'
	db 0x00
__str_3:
	db 'Recieved flip command '
	db 0x0A
	db 0x00
__str_4:
	db 'Received park command '
	db 0x0A
	db 0x00
__str_5:
	db 'Received closer command '
	db 0x0A
	db 0x00
__str_6:
	db 'Received farther command '
	db 0x0A
	db 0x00
__str_7:
	db 'Received %d'
	db 0x0A
	db 0x00

	CSEG

end
