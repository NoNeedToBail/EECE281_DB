#include <stdio.h>
#include <at89lp51rd2.h>
 
#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

//We want timer 0 to interrupt every 100 microseconds ((1/10000Hz)=100 us)
#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

#define FORWARD 1
#define REVERSE 0
#define ERROR 3
#define DISTSCALE 10
#define M1P P0_2
#define M1N P0_3
#define M2P P0_0
#define M2N P0_1

void wait(long);
int getDistance(int sensor);

typedef struct motor{
	int power;
	int direction;
}motor;

volatile int orientation = REVERSE;
volatile unsigned pwmcount;
volatile long unsigned systime = 0;
volatile int distance = 10;
volatile int totalpower = 50;
volatile int autonomous = 1;
motor motor1, motor2;

void main (void) {
	while(1);
}

void theISR (void) interrupt 1 {
	int delta; //delta = left distance - right distance
	int left = getDistance(1);
	int right = getDistance(2);
	if(++pwmcount > 99) pwmcount = 0;
	systime++;
	
	if (autonomous){
		if(orientation == REVERSE){
			int temp = left;
			left = right;
			right = temp;
		}
		delta = left - right;
		
		
		
		if (left > distance){
			motor1.direction = FORWARD;
			motor2.direction = FORWARD;
			motor1.power = totalpower + DISTSCALE * delta;
			motor2.power = totalpower - DISTSCALE * delta;
		} else if (left < distance){
			motor1.direction = REVERSE;
			motor2.direction = REVERSE;
			motor1.power = totalpower - DISTSCALE * delta;
			motor2.power = totalpower + DISTSCALE * delta;
		} else if (left == distance){
			motor1.power = 0;
			if (delta > 0){
				motor2.direction = REVERSE;
				motor2.power = DISTSCALE * delta;
			} else if (delta < 0){
				motor2.direction = FORWARD;
				motor2.power = - (DISTSCALE * delta);
			} else {
				motor2.power = 0;
			}
		}
	}
	
	
	if (motor1.power > 100){
		motor1.power = 100;
	}
	if (motor1.power < 0){
		motor1.power = 0;
	}
	if (motor2.power > 100){
		motor2.power = 100;
	}
	if (motor2.power < 0){
		motor2.power = 0;
	}
	
	if (orientation == FORWARD) {
		if (motor1.direction == FORWARD){
			M1P = (motor1.power > pwmcount ? 1 : 0);
			M1N = 0;
		} else {
			M1P = 0;
			M1N = (motor1.power > pwmcount ? 1 : 0);
		}
		if (motor2.direction == FORWARD){
			M2P = (motor2.power > pwmcount ? 1 : 0);
			M2N = 0;
		} else {
			M2P = 0;
			M2N = (motor2.power > pwmcount ? 1 : 0);
		}
	} else {
		if (motor1.direction == FORWARD){
			M2P = 0;
			M2N = (motor1.power > pwmcount ? 1 : 0);
		} else {
			M2P = (motor1.power > pwmcount ? 1 : 0);
			M2N = 0;
		}
		if (motor2.direction == FORWARD){
			M1P = 0;
			M1N = (motor2.power > pwmcount ? 1 : 0);
		} else {
			M1P = (motor2.power > pwmcount ? 1 : 0);
			M1N = 0;
		}
	}
}

int getDistance(int sensor){
	if (sensor == 1){
		return 5;
	} else {
		return 6;
	}
}

void parallelpark () {
	motor1.power = 80;
	motor2.power = 80;
	motor1.direction = 1;
	motor2.direction = 1;
	wait(1);

	motor1.power = 50;
	motor2.power = 0;
	motor1.direction = 0;
	motor2.direction = 0;
	wait(1.5);

	motor1.power = 75;
	motor2.power = 75;
	wait(1);
	
	motor1.power = 0;
	motor2.power = 80;
	wait(1);
	
	motor1.power = 0;
	motor2.power = 0;
	return;
}

void wait(long time){
	long time1= systime+time*10000;
	while(!(time1 < systime));
}
	
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
	TMOD=0x01;
	TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	TR0=1;
	ET0=1;
	EA=1;
    return 0;
}