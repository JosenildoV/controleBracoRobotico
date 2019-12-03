#include <ax12.h>
#include <BioloidController.h>

#define ombro1 2
#define ombro2 3
#define cotovelo 4
#define pulso 5
#define garra 6

void setup(){ 
  Serial.begin(9600);
  delay(3000);
  Serial.println("start");
}

void loop(){
  receiveComandsSerial();
}

void receiveComandsSerial(){  
    int motor2 = 0;
    int motor3 = 0;
    int motor4 = 0;
    int motor5 = 0;

//  Serial.print(Serial.available());
  if (Serial.available()>=4)
  {
    Serial.print(Serial.available());
    motor2 = Serial.read();
    motor3 = Serial.read();
    motor4 = Serial.read();
    motor5 = Serial.read();
    
    //SetPositionMulti(motor2,motor3,motor4,motor5,0);
    
    //changeVelocity();
    SetPosition(2,degree2pos(motor2));
    SetPosition(3,degree2pos(motor3));
    SetPosition(4,degree2pos(motor4));
    SetPosition(5,degree2pos(motor5));
    //SetPosition(6,512);
    
    Serial.print(" | ");
    Serial.print(GetPositionExt(2));
    Serial.print(", ");
    Serial.print(GetPositionExt(3));
    Serial.print(", ");
    Serial.print(GetPositionExt(4));
    Serial.print(", ");
    Serial.println(GetPositionExt(5));
  }
}

int serialReceiveNumber(){

  int signal = Serial.read();
  int pos1 = Serial.read();
  int pos2 = Serial.read();

  int res = ((pos2 * 256) + pos1) * signal;

  return res;
}

void receiveComands(){
 
 //numero de bytes disponíveis
  if(Serial.available() > 7){//no minimo 2 bytes * 3 servos
    //primeiro para a posição inicial e depois executar o movimento.
    //homePos();
    
    //para não ter conflito com var id
    int i;
    
    //cada byte da comunicação, lida byte a byte
    int low = 0;
    int high = 0;
      
    for(i = 2; i <= 5; i++){
      //manter ordem    
      low = Serial.read();
      high = Serial.read();
  
      Serial.print(low);
      Serial.print(" ");
      Serial.println(high);
      delay(300);
      //Definir posicao
      SetPositionExt(i, low + high*256 );//low + high*256);
      delay(300);
    }
    
    //garantir que no serial não irá ter nada mais
    Serial.flush(); 
  }
}

void samplePosition(){
  SetPositionMulti(-7,47,27,49, 0);
}

void positionZeroRobot(){
  SetPositionMulti(0,0,0,0,0);
}

void catchObject(){
  SetPositionExt(garra,-110);
}

void dropObject(){
    SetPositionExt(garra,0);
}

void changeVelocity(){
  //Mudar velocidade

  //torque
  ax12SetRegister2(ombro1,14,100);
  ax12SetRegister2(ombro2,14,800);
  ax12SetRegister2(cotovelo,14,700);
  ax12SetRegister2(pulso,14,400);
  ax12SetRegister2(garra,14,500);
  
  //velocidade
  ax12SetRegister2(ombro1,32,80);
  ax12SetRegister2(ombro2,32,80);
  ax12SetRegister2(cotovelo,32,80);
  ax12SetRegister2(pulso,32,80);
  ax12SetRegister2(garra,32,80);
  
  ax12SetRegister2(ombro1,33,0);
  ax12SetRegister2(ombro2,33,0);
  ax12SetRegister2(cotovelo,33,0);
  ax12SetRegister2(pulso,33,0);
  ax12SetRegister2(garra,33,0);
}

void turnOffRobot(){
 //'Desligar' o robo
  ax12SetRegister(ombro1,AX_TORQUE_ENABLE,0);
  ax12SetRegister(ombro2,AX_TORQUE_ENABLE,0);
  ax12SetRegister(cotovelo,AX_TORQUE_ENABLE,0);
  ax12SetRegister(pulso,AX_TORQUE_ENABLE,0);
  ax12SetRegister(garra,AX_TORQUE_ENABLE,0);
  
  ax12SetRegister(ombro1,AX_LED,0);
  ax12SetRegister(ombro2,AX_LED,0);
  ax12SetRegister(cotovelo,AX_LED,0);
  ax12SetRegister(pulso,AX_LED,0);
  ax12SetRegister(garra,AX_LED,0); 
}

//Função para colocar braço na posição inicial
void homePos(){
  
  //Mudar velocidade
  changeVelocity();
  
  //Mudar posição para inicial (ou home)
  SetPositionMulti(0, 140, -140, -55, 0);
  
  //'Desligar' o robo
  turnOffRobot();
}

//Levar de posição para grau
float pos2degree(int pos){
  float degree = (300*(float(pos)/1023.0)) -150;
  return degree;
}

// Levar de grau para posição
int degree2pos(float degree){
  if (degree<-150)
    degree = -150;
  if (degree>150)
    degree = 150;
    
  int pos = (int)(1023*(float(degree+150)/(300.0)));
  return pos;
}

//Função para imprimir posição atual dos motores do braço
void printPosition(){
  Serial.print("Ombro1: ");
  Serial.println(GetPositionExt(ombro1));
  Serial.print("Ombro2: ");
  Serial.println(GetPositionExt(ombro2));
  Serial.print("Cotovelo: ");
  Serial.println(GetPositionExt(cotovelo));
  Serial.print("Pulso: ");
  Serial.println(GetPositionExt(pulso));
  Serial.print("Garra: ");
  Serial.println(GetPositionExt(garra));
}

float GetPositionExt(int num_motor){
  float degree = pos2degree(GetPosition(num_motor));
  return degree;
}

//Nova função setPosition
void SetPositionExt(int num_motor, float num_pos){
  SetPosition(num_motor, degree2pos(num_pos));
  
  float curPos = GetPositionExt(num_motor);
  while(curPos < num_pos -2 || curPos > num_pos +2){ 
   delay(150);
   if(GetPositionExt(num_motor) > curPos -1 && GetPositionExt(num_motor) < curPos +1){
       Serial.println("halt!");
       SetPosition(num_motor, GetPosition(num_motor));
       printPosition();
       break;
     }
     curPos = GetPositionExt(num_motor);
  }
  Serial.println("done.");
}

// move todos os braços de uma vez, espera todos chegarem à posição esperada antes de continuar
void SetPositionMulti(float num_pos1, float num_pos2, float num_pos3, float num_pos4, float num_pos5){
  SetPosition(ombro1, degree2pos(num_pos1));
  SetPosition(ombro2, degree2pos(num_pos2));
  SetPosition(cotovelo, degree2pos(num_pos3));
  SetPosition(pulso, degree2pos(num_pos4));
  SetPosition(garra, degree2pos(num_pos5));
  
  int i=0;
  
  while(((GetPositionExt(ombro1) < num_pos1 -5 || GetPositionExt(ombro1) > num_pos1 +5) || (GetPositionExt(ombro2) < num_pos2 -5 || GetPositionExt(ombro2) > num_pos2 +5) || (GetPositionExt(cotovelo) < num_pos3 -5 || GetPositionExt(cotovelo) > num_pos3 +5) || (GetPositionExt(pulso) < num_pos4 -5 || GetPositionExt(pulso) > num_pos4 +5) || (GetPositionExt(garra) < num_pos5 -5 || GetPositionExt(garra) > num_pos5 +5)) && i<50){ 
     
    Serial.print((GetPositionExt(ombro1) < num_pos1 -5 || GetPositionExt(ombro1) > num_pos1 +5));
    Serial.print((GetPositionExt(ombro2) < num_pos2 -5 || GetPositionExt(ombro2) > num_pos2 +5));
    Serial.print((GetPositionExt(cotovelo) < num_pos3 -5 || GetPositionExt(cotovelo) > num_pos3 +5));
    Serial.print((GetPositionExt(pulso) < num_pos4 -5 || GetPositionExt(pulso) > num_pos4 +5));
    Serial.println((GetPositionExt(garra) < num_pos5 -5 || GetPositionExt(garra) > num_pos5 +5));
    delay(100);
    i++;
  }

  if(i>=50){
    Serial.println("Entrou outro loop!!!!");
    SetPositionMulti(num_pos1,num_pos2,num_pos3,num_pos4,num_pos5);
    return;
  }

  Serial.println("done.");
  delay(300);
  printPosition();
}
