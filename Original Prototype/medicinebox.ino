#include <Stepper.h>
#include <Servo.h>
#include <LiquidCrystal.h>

const int speakerPin = 5;          //Pin 5 connected to the speaker
const int buttonPin = 6;           //Pin 6 connected to the button
const int stepsPerRevolution = 115; //Number of steps per revolution for the stepper motor
const int ledPin = 7;              //Pin 7 connected to the LED
const char* daysOfWeek[] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}; //Days of the week list
int dayOfWeek = 0;                  //Variable to keep track of the day of the week

LiquidCrystal lcd(13, 12, 11, 10, 9, 8); //Pins for the LCD display
Servo servoMotor;                      //Define servo object
Stepper myStepper(stepsPerRevolution, 2, 3); //Define stepper motor object

void setup() {
  servoMotor.attach(4);       //Attach servo to pin 4
  myStepper.setSpeed(100);    //Set stepper motor speed
  pinMode(speakerPin, OUTPUT); //Set speaker pin as output
  pinMode(ledPin, OUTPUT);     //Set LED pin as output
  lcd.begin(16, 2);            //Initialise the LCD with 16 columns and 2 rows
  pinMode(buttonPin, INPUT_PULLUP); //Set button pin as input with internal pull-up resistor
  servoMotor.write(0);         //Set servo position to 0
  Serial.begin(9600);          //Initialize serial communication
}

void loop() {
  //Increment day of the week
  if(dayOfWeek == 7){
    dayOfWeek = 0;
  }
  dayOfWeek++;

  //Turn on LED if it's Sunday, otherwise off
  if(dayOfWeek==7){
      digitalWrite(ledPin, HIGH);
  }
  else{
      digitalWrite(ledPin, LOW);
  }

  //Display medication information on LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("MedWise ");
  lcd.print(daysOfWeek[dayOfWeek - 1]);
  lcd.setCursor(0, 1);
  lcd.print("Next: 12PM today");
  delay(10000);

  //Rotate stepper motor
  myStepper.step(stepsPerRevolution); 
  delay(500);

  //Display reminder to take medication
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("MedWise ");
  lcd.print(daysOfWeek[dayOfWeek - 1]);
  lcd.setCursor(0, 1);
  lcd.print("Take your meds!!");
  delay(500);

  //Check if button pressed and stop buzzer sound and move servo
  for(int i=0 ;  ; i++){
    int buttonState = digitalRead(buttonPin);
    if(buttonState == 1){
        tone(speakerPin, 1000); 
        delay(100);
        noTone(speakerPin);
        delay(100);
    }else{
      noTone(speakerPin);
      servoMotor.write(135);
      break;
    }
  }
  delay(500);

  //Check if button pressed and reset servo position
  for(int i=0 ;  ; i++){
    int buttonState = digitalRead(buttonPin);
    if(buttonState == 0){
      servoMotor.write(0);
      break;
    }else{
      continue;
    }
  }
  delay(100);

  //Display medication information on LCD
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("MedWise ");
  lcd.print(daysOfWeek[dayOfWeek - 1]);
  lcd.setCursor(0, 1);
  //Display refill message if it's Sunday, otherwise display next medication time
  if(dayOfWeek == 7){
    lcd.print("Pls Refill Box!");
  }else{
    lcd.print("Next: 12PM tmrrw");
  }
  delay(10000); //10 second delay to assume day change for demo
  //in an ideal case it would be defined in the app or will be 24 hrs.
}
