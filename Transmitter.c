#include <stdio.h>
#include <at89lp51rd2.h>
#include "Commands.h"
 
#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))
#define FREQ 30400L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))
#define FREQ1 1000
#define TIMER1_RELOAD_VALUE (65536L-(CLK/(12L*FREQ1)))

#define BUTTON1 P0_0
#define BUTTON2 P0_1
#define BUTTON3 P0_2
#define BUTTON4 P0_3
#define HPIN1 P2_1
#define HPIN2 P2_2

#define PUSHED 0
#define CLEAR 1

volatile long time = 0;

unsigned char _c51_external_startup(void) {
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
	TR1=0;
	TMOD=0x11;
	TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	TH1=RH1=TIMER1_RELOAD_VALUE/0x100;
	TL1=RL1=TIMER1_RELOAD_VALUE%0x100;
	TR1=1;
	ET1=1;
	TR0=1;
	ET0=1;
	EA=1;
	
 	HPIN1 = 0;
	HPIN2 = 1;   
    return 0;
}

void turnOff (void) {
	ET0 = 0;
}

void turnOn (void) {
	ET0 = 1;
}

void signalGen (void) interrupt 1 {
	HPIN2 = HPIN1;
	HPIN1 = !HPIN1;
}

void sysTime (void) interrupt 3 {
	time++;
}

void sendMessage (int message) {
	int i;
	long tempTime;
	
	turnOff();
	tempTime = time;
	while(time < tempTime + 1000); //3 "0"s as start bits
	turnOn();
	tempTime = time;
	while(time < tempTime + 10); //1 "1" as start bit
	for (i = 0; i < 4; i++) {
		ET0 = message & 1;
		message >>= 1;
		tempTime = time;
		while(time < tempTime + 10); //send each bit for 10ms
	}
	turnOn();
}

void main (void) {
	while (1)
	{
		if (BUTTON1 == PUSHED){
			while(BUTTON1 == PUSHED);
			sendMessage(FLIP);
		} else if (BUTTON2 == PUSHED){
			while(BUTTON2 == PUSHED);
			sendMessage(CLOSE);
		} else if (BUTTON3 == PUSHED){
			while(BUTTON3 == PUSHED);
			sendMessage(FAR);
		} else if (BUTTON4 == PUSHED){
			while(BUTTON4 == PUSHED);
			sendMessage(PARK);
		} else {
			turnOn();
		}
	}
}