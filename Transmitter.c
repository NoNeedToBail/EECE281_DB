#include <stdio.h>
#include <at89lp51rd2.h>
 
#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 30400L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

unsigned char _c51_external_startup(void)
{
	P0M0=0;	P0M1=0;
	P1M0=0;	P1M1=0;
	P2M0=0;	P2M1=0;
	P3M0=0;	P3M1=0;
	AUXR=0B_0001_0001;
	P4M0=0;	P4M1=0;
    
    PCON|=0x80;
	SCON = 0x52;
    BDRCON=0;
    BRL=BRG_VAL;
    BDRCON=BRR|TBCK|RBCK|SPD;
	
	TR0=0;
	TMOD=0x01;
	TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	TR0=1;
	ET0=1;
	EA=1;
	
 	P2_1 = 0;
	P2_2 = 1;   
    return 0;
}

void counter (void) interrupt 1
{
	P2_1 =!P2_1;
	P2_2 =!P2_2;
}

void main (void)
{
	while (1)
	{
		
	}
}