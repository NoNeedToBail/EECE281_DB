;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Sun Mar 23 16:18:15 2014
;--------------------------------------------------------
$name Autonomous
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
	public _theISR
	public _main
	public _motor2
	public _motor1
	public _totalpower
	public _distance
	public _systime
	public _pwmcount
	public _orientation
	public _getDistance
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
_orientation:
	ds 2
_pwmcount:
	ds 2
_systime:
	ds 4
_distance:
	ds 2
_totalpower:
	ds 2
_motor1:
	ds 4
_motor2:
	ds 4
_theISR_sloc0_1_0:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
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
	ljmp	_theISR
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:28: volatile int orientation = REVERSE;
	clr	a
	mov	_orientation,a
	mov	(_orientation + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:30: volatile long unsigned systime = 0;
	clr	a
	mov	_systime,a
	mov	(_systime + 1),a
	mov	(_systime + 2),a
	mov	(_systime + 3),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:31: volatile int distance = 10;
	mov	_distance,#0x0A
	clr	a
	mov	(_distance + 1),a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:32: volatile int totalpower = 50;
	mov	_totalpower,#0x32
	clr	a
	mov	(_totalpower + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:35: void main (void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	using	0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:36: while(1);
L002002?:
	sjmp	L002002?
;------------------------------------------------------------
;Allocation info for local variables in function 'theISR'
;------------------------------------------------------------
;delta                     Allocated to registers r4 r5 
;left                      Allocated to registers r2 r3 
;right                     Allocated to registers r4 r5 
;temp                      Allocated to registers r6 r7 
;sloc0                     Allocated with name '_theISR_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:39: void theISR (void) interrupt 1 {
;	-----------------------------------------
;	 function theISR
;	-----------------------------------------
_theISR:
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:41: int left = getDistance(1);
	mov	dptr,#0x0001
	lcall	_getDistance
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:42: int right = getDistance(2);
	mov	dptr,#0x0002
	push	ar2
	push	ar3
	lcall	_getDistance
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:43: if(orientation == REVERSE){
	mov	a,_orientation
	orl	a,(_orientation + 1)
	jnz	L003002?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:44: int temp = left;
	mov	ar6,r2
	mov	ar7,r3
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:45: left = right;
	mov	ar2,r4
	mov	ar3,r5
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:46: right = temp;
	mov	ar4,r6
	mov	ar5,r7
L003002?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:48: delta = left - right;
	mov	a,r2
	clr	c
	subb	a,r4
	mov	r4,a
	mov	a,r3
	subb	a,r5
	mov	r5,a
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:50: if(++pwmcount > 99) pwmcount = 0;
	mov	a,#0x01
	add	a,_pwmcount
	mov	_pwmcount,a
	clr	a
	addc	a,(_pwmcount + 1)
	mov	(_pwmcount + 1),a
	clr	c
	mov	a,#0x63
	subb	a,_pwmcount
	clr	a
	subb	a,(_pwmcount + 1)
	jnc	L003004?
	clr	a
	mov	_pwmcount,a
	mov	(_pwmcount + 1),a
L003004?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:51: systime++;
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
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:53: if (left > distance){
	clr	c
	mov	a,_distance
	subb	a,r2
	mov	a,(_distance + 1)
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc	L003017?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:54: motor1.direction = FORWARD;
	mov	(_motor1 + 0x0002),#0x01
	mov	((_motor1 + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:55: motor2.direction = FORWARD;
	mov	(_motor2 + 0x0002),#0x01
	mov	((_motor2 + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:56: motor1.power = totalpower + DISTSCALE * delta;
	mov	__mulint_PARM_2,r4
	mov	(__mulint_PARM_2 + 1),r5
	mov	dptr,#0x000A
	lcall	__mulint
	mov	_theISR_sloc0_1_0,dpl
	mov	(_theISR_sloc0_1_0 + 1),dph
	mov	a,_theISR_sloc0_1_0
	add	a,_totalpower
	mov	r6,a
	mov	a,(_theISR_sloc0_1_0 + 1)
	addc	a,(_totalpower + 1)
	mov	r7,a
	mov	_motor1,r6
	mov	(_motor1 + 1),r7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:57: motor2.power = totalpower - DISTSCALE * delta;
	mov	a,_totalpower
	clr	c
	subb	a,_theISR_sloc0_1_0
	mov	r6,a
	mov	a,(_totalpower + 1)
	subb	a,(_theISR_sloc0_1_0 + 1)
	mov	r7,a
	mov	_motor2,r6
	mov	(_motor2 + 1),r7
	ljmp	L003018?
L003017?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:58: } else if (left < distance){
	clr	c
	mov	a,r2
	subb	a,_distance
	mov	a,r3
	xrl	a,#0x80
	mov	b,(_distance + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003014?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:59: motor1.direction = REVERSE;
	mov	(_motor1 + 0x0002),#0x00
	mov	((_motor1 + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:60: motor2.direction = REVERSE;
	mov	(_motor2 + 0x0002),#0x00
	mov	((_motor2 + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:61: motor1.power = totalpower - DISTSCALE * delta;
	mov	__mulint_PARM_2,r4
	mov	(__mulint_PARM_2 + 1),r5
	mov	dptr,#0x000A
	lcall	__mulint
	mov	_theISR_sloc0_1_0,dpl
	mov	(_theISR_sloc0_1_0 + 1),dph
	mov	a,_totalpower
	clr	c
	subb	a,_theISR_sloc0_1_0
	mov	r6,a
	mov	a,(_totalpower + 1)
	subb	a,(_theISR_sloc0_1_0 + 1)
	mov	r7,a
	mov	_motor1,r6
	mov	(_motor1 + 1),r7
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:62: motor2.power = totalpower + DISTSCALE * delta;
	mov	a,_theISR_sloc0_1_0
	add	a,_totalpower
	mov	r6,a
	mov	a,(_theISR_sloc0_1_0 + 1)
	addc	a,(_totalpower + 1)
	mov	r7,a
	mov	_motor2,r6
	mov	(_motor2 + 1),r7
	sjmp	L003018?
L003014?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:63: } else if (left == distance){
	mov	a,r2
	cjne	a,_distance,L003018?
	mov	a,r3
	cjne	a,(_distance + 1),L003018?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:64: motor1.power = 0;
	mov	_motor1,#0x00
	mov	(_motor1 + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:65: if (delta > 0){
	clr	c
	clr	a
	subb	a,r4
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	L003009?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:66: motor2.direction = REVERSE;
	mov	(_motor2 + 0x0002),#0x00
	mov	((_motor2 + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:67: motor2.power = DISTSCALE * delta;
	mov	__mulint_PARM_2,r4
	mov	(__mulint_PARM_2 + 1),r5
	mov	dptr,#0x000A
	lcall	__mulint
	mov	a,dpl
	mov	b,dph
	mov	_motor2,a
	mov	(_motor2 + 1),b
	sjmp	L003018?
L003009?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:68: } else if (delta < 0){
	mov	a,r5
	jnb	acc.7,L003006?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:69: motor2.direction = FORWARD;
	mov	(_motor2 + 0x0002),#0x01
	mov	((_motor2 + 0x0002) + 1),#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:70: motor2.power = - (DISTSCALE * delta);
	mov	__mulint_PARM_2,r4
	mov	(__mulint_PARM_2 + 1),r5
	mov	dptr,#0x000A
	lcall	__mulint
	mov	r2,dpl
	mov	r3,dph
	clr	c
	clr	a
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	mov	_motor2,r2
	mov	(_motor2 + 1),r3
	sjmp	L003018?
L003006?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:72: motor2.power = 0;
	mov	_motor2,#0x00
	mov	(_motor2 + 1),#0x00
L003018?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:76: if (motor1.power > 100){
	clr	c
	mov	a,#0x64
	subb	a,_motor1
	clr	a
	xrl	a,#0x80
	mov	b,(_motor1 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003020?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:77: motor1.power = 100;
	mov	_motor1,#0x64
	mov	(_motor1 + 1),#0x00
L003020?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:79: if (motor1.power < 0){
	mov	a,(_motor1 + 1)
	jnb	acc.7,L003022?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:80: motor1.power = 0;
	mov	_motor1,#0x00
	mov	(_motor1 + 1),#0x00
L003022?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:82: if (motor2.power > 100){
	clr	c
	mov	a,#0x64
	subb	a,_motor2
	clr	a
	xrl	a,#0x80
	mov	b,(_motor2 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003024?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:83: motor2.power = 100;
	mov	_motor2,#0x64
	mov	(_motor2 + 1),#0x00
L003024?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:85: if (motor2.power < 0){
	mov	a,(_motor2 + 1)
	jnb	acc.7,L003026?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:86: motor2.power = 0;
	mov	_motor2,#0x00
	mov	(_motor2 + 1),#0x00
L003026?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:89: if (orientation == FORWARD) {
	mov	a,#0x01
	cjne	a,_orientation,L003072?
	clr	a
	cjne	a,(_orientation + 1),L003072?
	sjmp	L003073?
L003072?:
	sjmp	L003040?
L003073?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:90: if (motor1.direction == FORWARD){
	mov	a,#0x01
	cjne	a,(_motor1 + 0x0002),L003074?
	clr	a
	cjne	a,((_motor1 + 0x0002) + 1),L003074?
	sjmp	L003075?
L003074?:
	sjmp	L003028?
L003075?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:91: M1P = (motor1.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor1
	mov	a,(_pwmcount + 1)
	subb	a,(_motor1 + 1)
	mov	_P0_2,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:92: M1N = 0;
	clr	_P0_3
	sjmp	L003029?
L003028?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:94: M1P = 0;
	clr	_P0_2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:95: M1N = (motor1.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor1
	mov	a,(_pwmcount + 1)
	subb	a,(_motor1 + 1)
	mov	_P0_3,c
L003029?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:97: if (motor2.direction == FORWARD){
	mov	a,#0x01
	cjne	a,(_motor2 + 0x0002),L003076?
	clr	a
	cjne	a,((_motor2 + 0x0002) + 1),L003076?
	sjmp	L003077?
L003076?:
	sjmp	L003031?
L003077?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:98: M2P = (motor2.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor2
	mov	a,(_pwmcount + 1)
	subb	a,(_motor2 + 1)
	mov	_P0_0,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:99: M2N = 0;
	clr	_P0_1
	sjmp	L003042?
L003031?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:101: M2P = 0;
	clr	_P0_0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:102: M2N = (motor2.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor2
	mov	a,(_pwmcount + 1)
	subb	a,(_motor2 + 1)
	mov	_P0_1,c
	sjmp	L003042?
L003040?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:105: if (motor1.direction == FORWARD){
	mov	a,#0x01
	cjne	a,(_motor1 + 0x0002),L003078?
	clr	a
	cjne	a,((_motor1 + 0x0002) + 1),L003078?
	sjmp	L003079?
L003078?:
	sjmp	L003034?
L003079?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:106: M2P = 0;
	clr	_P0_0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:107: M2N = (motor1.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor1
	mov	a,(_pwmcount + 1)
	subb	a,(_motor1 + 1)
	mov	_P0_1,c
	sjmp	L003035?
L003034?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:109: M2P = (motor1.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor1
	mov	a,(_pwmcount + 1)
	subb	a,(_motor1 + 1)
	mov	_P0_0,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:110: M2N = 0;
	clr	_P0_1
L003035?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:112: if (motor2.direction == FORWARD){
	mov	a,#0x01
	cjne	a,(_motor2 + 0x0002),L003080?
	clr	a
	cjne	a,((_motor2 + 0x0002) + 1),L003080?
	sjmp	L003081?
L003080?:
	sjmp	L003037?
L003081?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:113: M1P = 0;
	clr	_P0_2
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:114: M1N = (motor2.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor2
	mov	a,(_pwmcount + 1)
	subb	a,(_motor2 + 1)
	mov	_P0_3,c
	sjmp	L003042?
L003037?:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:116: M1P = (motor2.power > pwmcount ? 1 : 0);
	clr	c
	mov	a,_pwmcount
	subb	a,_motor2
	mov	a,(_pwmcount + 1)
	subb	a,(_motor2 + 1)
	mov	_P0_2,c
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:117: M1N = 0;
	clr	_P0_3
L003042?:
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
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:122: int getDistance(int sensor){
;	-----------------------------------------
;	 function getDistance
;	-----------------------------------------
_getDistance:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:123: if (sensor == 1){
	cjne	r2,#0x01,L004002?
	cjne	r3,#0x00,L004002?
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:124: return 5;
	mov	dptr,#0x0005
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:126: return 6;
	ret
L004002?:
	mov	dptr,#0x0006
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:130: unsigned char _c51_external_startup(void) {
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:131: P0M0=0;	P0M1=0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:132: P1M0=0;	P1M1=0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:133: P2M0=0;	P2M1=0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:134: P3M0=0;	P3M1=0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:135: AUXR=0B_0001_0001;
	mov	_AUXR,#0x11
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:136: P4M0=0;	P4M1=0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:138: PCON|=0x80;
	orl	_PCON,#0x80
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:139: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:140: BDRCON=0;
	mov	_BDRCON,#0x00
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:141: BRL=BRG_VAL;
	mov	_BRL,#0xFA
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:142: BDRCON=BRR|TBCK|RBCK|SPD;
	mov	_BDRCON,#0x1E
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:144: TR0=0;
	clr	_TR0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:145: TMOD=0x01;
	mov	_TMOD,#0x01
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:146: TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	mov	_RH0,#0xFF
	mov	_TH0,#0xFF
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:147: TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	mov	_RL0,#0x48
	mov	_TL0,#0x48
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:148: TR0=1;
	setb	_TR0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:149: ET0=1;
	setb	_ET0
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:150: EA=1;
	setb	_EA
;	C:\Users\Dylan\Documents\GitHub\EECE281_DB\Autonomous.c:151: return 0;
	mov	dpl,#0x00
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST

	CSEG

end
