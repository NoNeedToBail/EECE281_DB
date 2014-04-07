#include <stdio.h>
#include <stdlib.h>
#include <at89lp51rd2.h>
 
#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 2000L //Allows us to filter down to a 100Hz PWM with reasonable precision on the power percentage
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))
#define FREQ1 1000L //Gives us a millisecond timer
#define TIMER1_RELOAD_VALUE (65536L-(CLK/(12L*FREQ1)))

#define FORWARD 1
#define REVERSE 0
#define M1P P0_2
#define M1N P0_3
#define M2P P0_0
#define M2N P0_1
#define ERROR 1.2 //Acceptable error in distance measurement
#define DISTMIN 400 //Mimimum settable distance
#define DISTMAX 2800 //Maximum settable distance

//The four commands for the robot in binary
#define FLIP 0B_0011
#define CLOSE 0B_0110
#define FAR 0B_1100
#define PARK 0B_1001

#define MIN 200 //The cut-off threshold for what we consider to be logic 0
#define RATIO 0.16 //ratio of cm/s per power

//Pins for the LCD display
#define RS	P4_4
#define RW	P4_0
#define EN	P0_7

//MCP 3004 pins
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
void implement_command (int);
void printCommand(int command);

void lcdinit(void);
void display(unsigned char value);
void lcdcmd(unsigned char value);
void delay(unsigned int time);

void wait_bit_time (void);
void wait_one_and_half_bit_time (void);

typedef struct motor{
	int power;
	int direction;
}motor;

volatile unsigned int pwmcount;
volatile long unsigned systime = 0;
int distance = 1200;
volatile long travelled = 0;
int totalpower = 50;
int autonomous = 1;
int orientation = FORWARD;
motor motorLeft, motorRight;
char first_line[16];
int k=0;

void main (void) {
	long command, left, right;
	int rec, i, z=0;

	lcdinit(); //initalizes LCD display

	while (1) {
		rec = 0; //Gets set to a 1 if magnetic field is being transmitted
		for (i = 0; i < 4; i++){ //Prevents fluctuations from starting the signal receiving process
			if (voltage(0) > MIN){ //If voltage is a logic one then we're not receiving a signal
				rec = 1;
			}
		}
		if (rec){
			right = getDistance(2);
			left = getDistance(1);

			if (orientation == REVERSE){ //This allows us to abstract to the left motor and right motor, regardless of orientation
				long temp = left;
				left = right;
				right = temp;
			}

			if (autonomous){
				if (left > right + 300){ //Left wheel is too far back
					motorRight.power = 0;
					motorLeft.power = totalpower;
				} else if (right > left + 300){ //Right wheel is too far back
					motorLeft.power = 0;
					motorRight.power = totalpower;
				} else if (left > distance * ERROR){ //Angle ok, robot too far away
					motorLeft.direction = FORWARD;
					motorRight.direction = FORWARD;
					motorLeft.power = totalpower;
					motorRight.power = totalpower;
				} else if (left < distance / ERROR){ //Robot too close
					motorLeft.direction = REVERSE;
					motorRight.direction = REVERSE;
					motorLeft.power = totalpower;
					motorRight.power = totalpower;
				} else { //We're in the right spot
					motorLeft.power = 0;
					motorRight.power = 0;
				}
			}
		} else {
			motorLeft.power = 0; //Turn the motors off while waiting for command
			motorRight.power = 0;
			waitms(10); //this makes sure that the power change takes effect before shutting off the interrupt
			command = rx_byte();
			implement_command(command);
			waitms(200); //prevents receiving commands back to back
		}
		z++;
		if(z >= 5){ //Prevents LCD display from refreshing too fast and flickering
			z = 0;
			sprintf(first_line, "SPD=%dcm/s      ", (int)((motorLeft.power + motorRight.power) / 2.0 * RATIO));
			lcdcmd(0x80); //Print on the first line
			k=0;
			while(first_line[k]!='\0') {
				display(first_line[k]);
				k++;
			}
			sprintf(first_line, "Travelled=%dcm", (int)(travelled/100.0));             
			lcdcmd(0xC0); //Print on the second line
			k=0;
			while(first_line[k]!='\0') {
				display(first_line[k]);
				k++;
			}
		}
	}
} 

void timeISR (void) interrupt 3 { //Timer 1 runs every millisecond and gives us a millisecond timer
	systime++;
}

void motorISR (void) interrupt 1 {
	if((pwmcount+=5) > 99){ //Frequency is 2000, 2000 / 5 = 100 for 100Hz PWM signal
		pwmcount = 0;
		travelled += (motorLeft.power + motorRight.power) / 2 * RATIO; //tracks the distance travelled
	}

	if (orientation == REVERSE) {
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
	return 3000-v;
}

void parallelpark () {
	orientation=!orientation; //Code was originally programmed for the opposite orientation, this is a quick fix
	
	motorLeft.power = 85;
	motorRight.power = 85;
	motorLeft.direction = FORWARD;
	motorRight.direction = FORWARD;
	waitms(1100); //move back for 1100ms

	motorLeft.power = 50;
	motorRight.power = 0;
	motorLeft.direction = REVERSE;
	motorRight.direction = REVERSE;
	waitms(1000); //Turn left 45 degrees

	motorLeft.power = 75;
	motorRight.power = 75;
	waitms(1200); //Move forward

	motorLeft.power = 0;
	motorRight.power = 50;
	waitms(1000); //Turn right 45 degrees to straighten out

	motorLeft.power = 0;
	motorRight.power = 0;
	
	orientation=!orientation; //orientation is reset to original value
	return;
}

void turn180 (void) {
	motorLeft.power = 50;
	motorRight.power = 50;
	motorLeft.direction = FORWARD;
	motorRight.direction = REVERSE;
	waitms(3600);

	orientation = !orientation;
	
	motorLeft.power = 0;
	motorRight.power = 0;
	return;
}

void implement_command (int command) {
	if (command == FLIP) {
		autonomous = 0;
		sprintf(first_line, "   FLIPPING...   ", (int)(travelled/100.0)); //loads first_line with our message
		lcdcmd(0x80); //print on first line
		k=0;
		while(first_line[k]!='\0') {
			display(first_line[k]);
			k++;
		}
		turn180(); //flip the robot
		autonomous = 1;
	} else if (command == CLOSE) {
		changeDistance(1);
	} else if (command == FAR) {
		changeDistance(0);
	} else if (command == PARK) {
		autonomous = 0;
		sprintf(first_line, "   PARKING...   ", (int)(travelled/100.0));             
		lcdcmd(0x80);
		k=0;
		while(first_line[k]!='\0') {
			display(first_line[k]);
			k++;
		}
		parallelpark();
		autonomous = 1;
	} 
	return;
}

//increases or decreases the distance based on whether the input is a 1 (get closer) or 0 (get farther)
void changeDistance(int change){
	if(change) {
		if (distance > DISTMIN) distance -= 400;
	} else {
		if (distance < DISTMAX) distance += 400;
	}
}

unsigned char rx_byte (void) {
	unsigned char j, val;
	int v;
	int k=0;
	ET0 = 0; //Timing is sensitive and we don't need the motors right now + motors are off
	while (voltage(0)<MIN);
	val=0;
	wait_one_and_half_bit_time(); //Sample in the middle of the bits for less error
	for(j=0; j<4; j++) {
		v=voltage(0);
		val|=(v>MIN)?(0x01<<j):0x00;
		wait_bit_time();
	}
	ET0 = 1;
	return val;
}

//systime is a measure of milliseconds and all these functions wait on it to increment
void waitms(long time){
	long time1= systime+time;
	while(!(time1 < systime));
}

void wait_bit_time (void) {
	long time_start=systime;
	while (!(systime > time_start+9)); //bit is 10ms but other code runs as well so this prevents us from losing ground over time
	return;
}

void wait_one_and_half_bit_time(void) {
	long time_start=systime;
	while (!(systime > time_start+14)); //same as above but for 1.5 bits
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
	return ((GetADC(channel)*5)/1023.0) * 1000; // VCC=5V (measured)
}

void lcdcmd(unsigned char value) {
	P2=value;
	RS=0; RW=0; EN=1;
	delay(50);
	EN=0;
	delay(50);
	return;
}

//Function for sending values to the data register of LCD
void display(unsigned char value) {
	P2=value;
	RS=1; EN=1;
	delay(500);
	EN=0;
	delay(50);
	return;
}

void delay(unsigned int time) { //Time delay function
	unsigned int i,j;
	for(i=0;i<time;i++)
  		for(j=0;j<5;j++);
}

//function to initialize the registers and pins of LCD
void lcdinit(void) {
	P2=0x00;
	RW=0; EN=0; RS=0;
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