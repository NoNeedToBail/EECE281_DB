#include <stdio.h>
#include <stdlib.h>
#include <at89lp51rd2.h>
#include <8051.h>

#define RS	P3_5
#define RW	P3_7
#define EN	P3_6
 
#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

//We want timer 0 to interrupt every 100 microseconds ((1/10000Hz)=100 us)
#define FREQ 2000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))
#define FREQ1 1000L
#define TIMER1_RELOAD_VALUE (65536L-(CLK/(12L*FREQ1)))

#define FORWARD 1
#define REVERSE 0
#define DISTSCALE 50
#define M1P P0_2
#define M1N P0_3
#define M2P P0_0
#define M2N P0_1
#define SHORT 600
#define MED 1500
#define LONG 2500
#define ERROR 1.1
#define FLIP 0B_0000
#define CLOSE 0B_0110
#define FAR 0B_0011
#define PARK 0B_0101
#define MIN 200
#define LEFTSCALINGFACTOR 1
#define RIGHTSCALINGFACTOR 1
#define RATIO 0.16 //ratio of cm/s per power

//	LCD
#define CLEAR 0x01
#define FIRSTLINE 0x80
#define SECONDLINE 0xC0

//         LP51B    MCP3004

//---------------------------

// MISO  -  P1.5  - pin 10
// SCK   -  P1.6  - pin 11
// MOSI  -  P1.7  - pin 9
// CE*   -  P1.4  - pin 8
// 5V 	 -  VCC   - pins 13, 14
// 0V    -  GND   - pins 7, 12
// CH0   -        - pin 1
// CH1   -        - pin 2
// CH2   -        - pin 3
// CH3   -        - pin 4

#define MISO	P1_5
#define SCK		P1_6
#define MOSI	P1_7
#define CE		P1_4

void waitms(long);
void parallelpark();
void turn180();
void changeDistance(int);

int voltage(unsigned char channel);
int getDistance(int sensor);
unsigned int GetADC(unsigned char channel);

unsigned char rx_byte ();
int receive_command (void);
void implement_command (int);
void printCommand(int command);

void wait_bit_time (void);
void wait_one_and_half_bit_time (void);

void lcdinit(void);
void display(unsigned char value);
void lcdcmd(unsigned char value);
void delay(unsigned int time);

typedef struct motor{
	int power;
	int direction;
}motor;

volatile unsigned int pwmcount;
volatile long unsigned systime = 0;
int distance;
long travelled = 0;
int totalpower = 50;
int autonomous = 0;
int orientation = FORWARD;
motor motorLeft, motorRight;

void main (void) {
	long command, delta, left, right;
	int k=0;
	char *u = malloc(20);
	
	lcdinit();
	ET0 = 1;
	distance = MED;
	P0_5=1;
	
	while (1) {
		right = getDistance(2);
		printf("left mV=%d right mV=%d dist L = %5d dist R = %5d\n",voltage(0),voltage(1),getDistance(1),getDistance(2));
	//	if (right > MIN){
			left = getDistance(1);
			
			if (orientation == REVERSE){
				long temp = left;
				left = right;
				right = temp;
			}
			
			if (autonomous){
				delta = left - right;
				
				if (left > distance * ERROR){
					motorLeft.direction = FORWARD;
					motorRight.direction = FORWARD;
					motorLeft.power = totalpower + DISTSCALE * delta;
					motorRight.power = totalpower - DISTSCALE * delta;
				} else if (left < distance / ERROR){
					motorLeft.direction = REVERSE;
					motorRight.direction = REVERSE;
					motorLeft.power = totalpower - DISTSCALE * delta;
					motorRight.power = totalpower + DISTSCALE * delta;
				} else {
					motorLeft.power = 0;
					motorRight.power = 0;
				}
			}
	/*	} else {
			command = receive_command();
			printCommand(command);
			implement_command(command);
			//wait_one_and_half_bit_time();
			waitms(200); //just so we don't receive commands back to back
		}*/
		
		/*if (systime % 1000 == 0){
			sprintf(u, "Distance: %ldcm", travelled);
			lcdcmd(CLEAR);          
			lcdcmd(FIRSTLINE);
			k = 0;
			while(u[k]!='\0' && k < 15)
			{
				display(u[k]);
				k++;
			}
		}
		if (systime % 1000 == 500){
			sprintf(u, "Speed: %dcm/s", (motorLeft.power + motorRight.power) / 2);
			lcdcmd(CLEAR);          
			lcdcmd(SECONDLINE);
			k = 0;
			while(u[k]!='\0' && k < 15)
			{
				display(u[k]);
				k++;
			}
		}*/
	}
} 

void timeISR (void) interrupt 3 {
	systime++;
	if (systime % 1000 == 0){
		travelled += (motorLeft.power + motorRight.power) / 2 * RATIO;
	}
}

void motorISR (void) interrupt 1 { 
	if((pwmcount+=5) > 99) pwmcount = 0;
	
	if (orientation == FORWARD) {
		M1P = (motorLeft.power > pwmcount ? 1 : 0) * motorLeft.direction;
		M1N = (motorLeft.power > pwmcount ? 1 : 0) * !motorLeft.direction;
		
		M2P = (motorRight.power > pwmcount ? 1 : 0) * motorRight.direction;
		M2N = (motorRight.power > pwmcount ? 1 : 0) * !motorRight.direction;
	} else {
		M2P = (motorLeft.power > pwmcount ? 1 : 0) * !motorLeft.direction;
		M2N = (motorLeft.power > pwmcount ? 1 : 0) * motorLeft.direction;
		
		M1P = (motorRight.power > pwmcount ? 1 : 0) * !motorRight.direction;
		M1N = (motorRight.power > pwmcount ? 1 : 0) * motorRight.direction;
	}
}

int getDistance(int sensor){
	long v;
	v = voltage(sensor - 1);
	if (sensor == 1) { //left wheel
		return LEFTSCALINGFACTOR*(3000-v);
	} else {
		return RIGHTSCALINGFACTOR*(3000-v);
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
	else
		printf("Received %d\n", command);
	return;
}

void parallelpark () {
	motorLeft.power = 85;
	motorRight.power = 85;
	motorLeft.direction = FORWARD;
	motorRight.direction = FORWARD;
	waitms(1100);
	
	motorLeft.power = 50;
	motorRight.power = 0;
	motorLeft.direction = REVERSE;
	motorRight.direction = REVERSE;
	waitms(1000);
	
	motorLeft.power = 75;
	motorRight.power = 75;
	waitms(900);
	
	motorLeft.power = 0;
	motorRight.power = 45;
	waitms(1035);
	
	motorLeft.power = 0;
	motorRight.power = 0;
	return;
}

void turn180 (void) {
	motorLeft.power = 50;
	motorRight.power = 50;
	motorLeft.direction = FORWARD;
	motorRight.direction = REVERSE;
	waitms(2650);
	
	if(orientation==FORWARD) {
		orientation=REVERSE;
	} else {
		orientation=FORWARD;
	}
	motorLeft.power = 0;
	motorRight.power = 0;
	return;
}

int receive_command (void) {
	int command;
	command = rx_byte();
	return command;
}

void implement_command (int command) {
	if (command == FLIP) {
		autonomous = 0;
		turn180();
		autonomous = 1;
	} else if (command == CLOSE) {
		changeDistance(1);
	} else if (command == FAR) {
		changeDistance(0);
	} else if (command == PARK) {
		autonomous = 0;
		parallelpark();
		autonomous = 1;
	} 
	return;
}

void changeDistance(int change){
	if(change) //1= get closer
	{
		if(distance == LONG)
			distance = MED;
		else if (distance == MED)
			distance = SHORT;
	}
	else 
	{
		if(distance == MED)
			distance = LONG;
		if(distance == SHORT)
			distance = MED;
	}
}

unsigned char rx_byte (void) {
	unsigned char j, val;
	int v;
	int k=0;
	while (voltage(0)<MIN);
	P0_5=!P0_5;
	val=0;
	wait_one_and_half_bit_time();
	for(j=0; j<4; j++) {
		v=voltage(0);
		val|=(v>MIN)?(0x01<<j):0x00;
		P0_5=!P0_5;
		wait_bit_time();
	}
	P0_5=1;
	return val;
}

void waitms(long time){
	long time1= systime+time;
	while(!(time1 < systime));
}

void wait_bit_time (void) {
	long time_start=systime;
	while (!(systime > time_start+9));
	return;
}

void wait_one_and_half_bit_time(void) {
	long time_start=systime;
	while (!(systime > time_start+14));
	return;
}
	
void SPIWrite(unsigned char value)
{
	SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	SPDAT=value;
	while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
}

unsigned int GetADC(unsigned char channel) {
	unsigned int adc;

	// initialize the SPI port to read the MCP3004 ADC attached to it.
	SPCON&=(~SPEN); // Disable SPI
	SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	SPCON|=SPEN; // Enable SPI
	
	CE=0; // Activate the MCP3004 ADC.
	SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	for(adc=0; adc<10; adc++); // Wait for S/H to setup
	SPIWrite(0x55); // Read bits 9 down to 4
	adc=((SPDAT&0x3f)*0x100);
	SPIWrite(0x55);// Read bits 3 down to 0
	CE=1; // Deactivate the MCP3004 ADC.
	adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	adc>>=4;
		
	return adc;
}

int voltage (unsigned char channel) {
	return ((GetADC(channel)*5.81)/1023.0) * 1000; // VCC=5.81V (measured)
}

void delay(unsigned int time)  //Time delay function
{
	unsigned int i,j;
	for(i=0;i<time;i++)
  		for(j=0;j<5;j++);
}
             //Function for sending values to the command register of LCD
void lcdcmd(unsigned char value)  
{
	P1=value;
	P3=0x40;
	delay(50);
	EN=0;
	delay(50);
	return;
}
             //Function for sending values to the data register of LCD
void display(unsigned char value)  
{
	P1=value;
	P3=0x60;
	delay(500);
	EN=0;
	delay(50);
	return;
}
             //function to initialize the registers and pins of LCD
void lcdinit(void)         
{
	P1=0x00;                 
	P3=0x00;
     	delay(15000);display(0x30);delay(4500);display(0x30);delay(300);
     	display(0x30);delay(650);lcdcmd(0x38);delay(50);lcdcmd(0x0F);
	delay(50);lcdcmd(0x01);delay(50);lcdcmd(0x06);delay(50);lcdcmd(0x80);
	delay(50);
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
    
    RS=1; RW=1;
	
	TR0=0;
	TMOD=0x11;
	TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	TR0=1;
	ET0=1;
	TR1=0;
	TH1=RH1=TIMER1_RELOAD_VALUE/0x100;
	TL1=RL1=TIMER1_RELOAD_VALUE%0x100;
	TR1=1;
	ET1=1;
	EA=1;
    return 0;
}