#include <stdio.h>
#include <stdlib.h>
#include <at89lp51rd2.h>
//#include <Commands.h>
 
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
#define shortDistance 5 
#define medDistance 5
#define longDistance 5
#define FLIP 0B_000
#define CLOSE 0B_110
#define FAR 0B_011
#define PARK 0B_101
#define MIN 0

void wait(long);
void parallelpark();
void turn180();
void changeDistance(int);
int getDistance(int sensor);
unsigned char rx_byte (int min);
int receive_command (void);
void implement_command (int);
void printCommand(int);
unsigned int GetADC(unsigned char channel);
void wait_bit_time (void);
void wait_one_and_half_bit_time (void);
int complement (int num);


void compareVoltage(unsigned char chan1, unsigned char chan2);

typedef struct motor{
	int power;
	int direction;
}motor;

volatile int orientation = REVERSE;
volatile unsigned pwmcount;
volatile long unsigned systime = 0;
volatile int distance = 10;
volatile int totalpower = 50;
volatile int autonomous = 0;
motor motorLeft, motorRight;
int start_receiving=0;


//         LP51B    MCP3004

//---------------------------

// MISO  -  P1.5  - pin 10
// SCK   -  P1.6  - pin 11
// MOSI  -  P1.7  - pin 9
// CE*   -  P1.4  - pin 8
// 5V  -  VCC   - pins 13, 14
// 0V    -  GND   - pins 7, 12
// CH0   -        - pin 1
// CH1   -        - pin 2
// CH2   -        - pin 3
// CH3   -        - pin 4



void main (void) {
	int zeroCount=0;
	int command;
	int v;
	while (1) {
		if (zeroCount==2) {
			autonomous=0;
			command=receive_command();
			implement_command(command);
			printCommand(command);
			zeroCount=0;
			autonomous=1;
		}
		v=GetADC(0);
		if (!(v>MIN)) zeroCount+=1;
		else zeroCount=0;
		wait_bit_time();
	}
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
			motorLeft.direction = FORWARD;
			motorRight.direction = FORWARD;
			motorLeft.power = totalpower + DISTSCALE * delta;
			motorRight.power = totalpower - DISTSCALE * delta;
		} else if (left < distance){
			motorLeft.direction = REVERSE;
			motorRight.direction = REVERSE;
			motorLeft.power = totalpower - DISTSCALE * delta;
			motorRight.power = totalpower + DISTSCALE * delta;
		} else if (left == distance){
			motorLeft.power = 0;
			if (delta > 0){
				motorRight.direction = REVERSE;
				motorRight.power = DISTSCALE * delta;
			} else if (delta < 0){
				motorRight.direction = FORWARD;
				motorRight.power = - (DISTSCALE * delta);
			} else {
				motorRight.power = 0;
			}
		}
	}
	
	
	if (motorLeft.power > 100){
		motorLeft.power = 100;
	}
	if (motorLeft.power < 0){
		motorLeft.power = 0;
	}
	if (motorRight.power > 100){
		motorRight.power = 100;
	}
	if (motorRight.power < 0){
		motorRight.power = 0;
	}
	
	if (orientation == FORWARD) {
		if (motorLeft.direction == FORWARD){
			M1P = (motorLeft.power > pwmcount ? 1 : 0);
			M1N = 0;
		} else {
			M1P = 0;
			M1N = (motorLeft.power > pwmcount ? 1 : 0);
		}
		if (motorRight.direction == FORWARD){
			M2P = (motorRight.power > pwmcount ? 1 : 0);
			M2N = 0;
		} else {
			M2P = 0;
			M2N = (motorRight.power > pwmcount ? 1 : 0);
		}
	} else {
		if (motorLeft.direction == FORWARD){
			M2P = 0;
			M2N = (motorLeft.power > pwmcount ? 1 : 0);
		} else {
			M2P = (motorLeft.power > pwmcount ? 1 : 0);
			M2N = 0;
		}
		if (motorRight.direction == FORWARD){
			M1P = 0;
			M1N = (motorRight.power > pwmcount ? 1 : 0);
		} else {
			M1P = (motorRight.power > pwmcount ? 1 : 0);
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
void printCommand(int command){
	if(command==FLIP)
		printf("Recieved flip command \n");
	else if (command == PARK)
		printf("Received park command \n");
	else if (command == CLOSE)
		printf("Received closer command \n");
	else if (command == FAR)
		printf("Received farther command \n");
return;
}
void parallelpark () {
	motorLeft.power = 85;
	motorRight.power = 85;
	motorLeft.direction = 1;
	motorRight.direction = 1;
	wait(1);

	motorLeft.power = 50;
	motorRight.power = 0;
	motorLeft.direction = 0;
	motorRight.direction = 0;
	wait(1);

	motorLeft.power = 75;
	motorRight.power = 75;
	wait(1);
	
	motorLeft.power = 0;
	motorRight.power = 45;
	wait(1);
	
	motorLeft.power = 0;
	motorRight.power = 0;
	return;
}

void turn180 (void) {
	motorLeft.power = 50;
	motorRight.power = 50;
	motorLeft.direction = 1;
	motorRight.direction = 0;
	wait(8);
	
	if(orientation) {
		orientation=0;
	} else {
		orientation=1;
	}
	motorLeft.power = 0;
	motorRight.power = 0;
	return;
}


int receive_command (void) { // NOT DONE
	int command;
	command = rx_byte(MIN);
	command = complement(command);
	if (command == FLIP || command == CLOSE || command == FAR || command == PARK) {
		return command;
	} else {
		return -1;
	}
}

void implement_command (int command) {
	if (command == FLIP) {
		turn180();
	} else if (command == CLOSE) {
		changeDistance(1);
	} else if (command == FAR) {
		changeDistance(0);
	} else if (command == PARK) {
		parallelpark();
	} 
	return;
}

void changeDistance(int change){
	if(change) //1= get closer
	{
		if(distance == longDistance)
			distance = medDistance;
		else if (distance == medDistance)
			distance = shortDistance;
	}
	else 
	{
		if(distance == medDistance)
			distance = longDistance;
		if(distance ==shortDistance)
			distance = medDistance;
	}
	
	return;
}
unsigned char rx_byte (int min) {
	unsigned char j, val;
	int v;
	int k=0;
	while (!(GetADC(0)>min));
	val=0;
	wait_one_and_half_bit_time();
	for(j=0; j<4; j++) {
		v=GetADC(0);
		val|=(v>min)?(0x01<<j):0x00;
		wait_bit_time();
	}
	wait_one_and_half_bit_time();
	return val;
}

void wait(long time){
	long time1= systime+time*10000;
	while(!(time1 < systime));
}

void wait_bit_time (void) {
	int time_start=systime;
	while (!(systime==time_start+100));
	return;
}

void wait_one_and_half_bit_time(void) {
	long time_start=systime;
	while (!(systime==time_start+150));
	return;
}


int complement (int num) {
	return ~num - 0xF0;
}
	
void SPIWrite(unsigned char value)
{
	SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	SPDAT=value;
	while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
}

// Read 10 bits from the MCP3004 ADC converter
unsigned int GetADC(unsigned char channel)
{
	unsigned int adc;

	// initialize the SPI port to read the MCP3004 ADC attached to it.
	SPCON&=(~SPEN); // Disable SPI
	SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	SPCON|=SPEN; // Enable SPI
	
	P1_4=0; // Activate the MCP3004 ADC.
	SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	for(adc=0; adc<10; adc++); // Wait for S/H to setup
	SPIWrite(0x55); // Read bits 9 down to 4
	adc=((SPDAT&0x3f)*0x100);
	SPIWrite(0x55);// Read bits 3 down to 0
	P1_4=1; // Deactivate the MCP3004 ADC.
	adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	adc>>=4;
		
	return adc;
}

float voltage (unsigned char channel)
{
	return ( (GetADC(channel)*5)/1023.0 ); // VCC=5V (measured)
}

void compareVoltage(unsigned char chan1, unsigned char chan2) {
	float v1,v2;
	v1=voltage(chan1);
	v2=voltage(chan2);
	printf("Channel %c = %dV \n\r Channel %c = %dV \n\r Chan %c - %c = %dV",chan1,v1,chan2,v2,chan1,chan2,v1-v2);
	return;
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