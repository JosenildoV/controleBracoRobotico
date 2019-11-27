#include <ax12.h>
#include <BioloidController.h>

void setup(){
  Serial.begin(9600);
  delay(2000);
  Serial.println("start");
  delay(1000);
  changeVelocity();
  delay(100);
  moveRobot();
  //sample();
  //catchObject();
  printPosition();
  //dropObject();
  //delay(3000);
  //homePos();
}

void loop(){
  //SetPositionMulti(rand();
  //printPosition();
}

void sample(){
  SetPositionMulti(-7,47,27,49, 0);
}

void moveRobot(){
  Serial.println("Ordem: 1");
  SetPositionMulti(1,68,63,-27, 0);
  Serial.println("Ordem: 2");
  SetPositionMulti(-54,50,18,87, 0);
  Serial.println("Ordem: 3");
  SetPositionMulti(22,77,38,-43, 0);
  Serial.println("Ordem: 4");
  SetPositionMulti(3,61,-36,51, 0);
  Serial.println("Ordem: 5");
  SetPositionMulti(35,47,87,-5, 0);
  Serial.println("Ordem: 6");
  SetPositionMulti(-25,50,12,62, 0);
  Serial.println("Ordem: 7");
  SetPositionMulti(42,47,64,42, 0);
  Serial.println("Ordem: 8");
  SetPositionMulti(51,78,-61,32, 0);
  Serial.println("Ordem: 9");
  SetPositionMulti(16,50,-42,19, 0);
  Serial.println("Ordem: 10");
  SetPositionMulti(60,1,130,-81, 0);
  Serial.println("Ordem: 11");
  SetPositionMulti(31,55,-20,48, 0);
  Serial.println("Ordem: 12");
  SetPositionMulti(-68,74,22,-82, 0);
  Serial.println("Ordem: 13");
  SetPositionMulti(-80,16,-13,46, 0);
  Serial.println("Ordem: 14");
  SetPositionMulti(60,68,15,56, 0);
  Serial.println("Ordem: 15");
  SetPositionMulti(-73,100,-83,49, 0);
  Serial.println("Ordem: 16");
  SetPositionMulti(-65,62,-62,85, 0);
  Serial.println("Ordem: 17");
  SetPositionMulti(63,101,57,-44, 0);
  Serial.println("Ordem: 18");
  SetPositionMulti(-41,11,70,13, 0);
  Serial.println("Ordem: 19");
  SetPositionMulti(48,9,96,-15, 0);
  Serial.println("Ordem: 20");
  SetPositionMulti(-60,104,-9,-22, 0);
  Serial.println("Ordem: 21");
  SetPositionMulti(80,72,0,63, 0);
  Serial.println("Ordem: 22");
  SetPositionMulti(6,61,48,-38, 0);
  Serial.println("Ordem: 23");
  SetPositionMulti(-47,64,75,-45, 0);
  Serial.println("Ordem: 24");
  SetPositionMulti(-70,49,-1,15, 0);
  Serial.println("Ordem: 25");
  SetPositionMulti(60,44,18,-4, 0);
  Serial.println("Ordem: 26");
  SetPositionMulti(-65,28,-15,40, 0);
  Serial.println("Ordem: 27");
  SetPositionMulti(-44,33,35,-49, 0);
  Serial.println("Ordem: 28");
  SetPositionMulti(-1,78,-39,78, 0);
  Serial.println("Ordem: 29");
  SetPositionMulti(-77,43,-43,24, 0);
  Serial.println("Ordem: 30");
  SetPositionMulti(-90,20,2,13, 0);
  Serial.println("Ordem: 31");
  SetPositionMulti(-59,15,81,49, 0);
  Serial.println("Ordem: 32");
  SetPositionMulti(80,24,53,-17, 0);
  Serial.println("Ordem: 33");
  SetPositionMulti(4,29,-18,42, 0);
  Serial.println("Ordem: 34");
  SetPositionMulti(-59,2,144,-45, 0);
  Serial.println("Ordem: 35");
  SetPositionMulti(84,84,-83,75, 0);
  Serial.println("Ordem: 36");
  SetPositionMulti(37,71,17,-53, 0);
  Serial.println("Ordem: 37");
  SetPositionMulti(49,25,34,84, 0);
  Serial.println("Ordem: 38");
  SetPositionMulti(65,44,7,46, 0);
  Serial.println("Ordem: 39");
  SetPositionMulti(74,100,-5,-39, 0);
  Serial.println("Ordem: 40");
  SetPositionMulti(64,49,96,-87, 0);
  Serial.println("Ordem: 41");
  SetPositionMulti(6,79,-51,18, 0);
  Serial.println("Ordem: 42");
  SetPositionMulti(-57,35,30,23, 0);
  Serial.println("Ordem: 43");
  SetPositionMulti(-82,61,-17,-7, 0);
  Serial.println("Ordem: 44");
  SetPositionMulti(-46,17,136,1, 0);
  Serial.println("Ordem: 45");
  SetPositionMulti(58,80,-52,22, 0);
  Serial.println("Ordem: 46");
  SetPositionMulti(-56,0,47,63, 0);
  Serial.println("Ordem: 47");
  SetPositionMulti(23,60,10,-24, 0);
  Serial.println("Ordem: 48");
  SetPositionMulti(0,84,38,-16, 0);
  Serial.println("Ordem: 49");
  SetPositionMulti(45,71,-52,46, 0);
  Serial.println("Ordem: 50");
  SetPositionMulti(-28,10,13,3, 0);
}

void catchObject(){
  SetPositionExt(6,-110);
}

void dropObject(){
  SetPosition(6,degree2pos(0));
  delay(3000);
}

void changeVelocity(){
  //Mudar velocidade
  ax12SetRegister2(2,AX_TORQUE_LIMIT_L,100);
  ax12SetRegister2(3,AX_TORQUE_LIMIT_L,800);
  ax12SetRegister2(4,AX_TORQUE_LIMIT_L,700);
  ax12SetRegister2(5,AX_TORQUE_LIMIT_L,400);
  ax12SetRegister2(6,AX_TORQUE_LIMIT_L,500);
  
  ax12SetRegister2(2,32,50);
  ax12SetRegister2(3,32,50);
  ax12SetRegister2(4,32,50);
  ax12SetRegister2(5,32,50);
  ax12SetRegister2(6,32,50);
  
  ax12SetRegister2(2,33,80);
  ax12SetRegister2(3,33,80);
  ax12SetRegister2(4,33,80);
  ax12SetRegister2(5,33,80);
  ax12SetRegister2(6,33,80);
}

void turnOffRobot(){
 //'Desligar' o robo
  ax12SetRegister(1,AX_TORQUE_ENABLE,0);
  ax12SetRegister(2,AX_TORQUE_ENABLE,0);
  ax12SetRegister(3,AX_TORQUE_ENABLE,0);
  ax12SetRegister(4,AX_TORQUE_ENABLE,0);
  ax12SetRegister(5,AX_TORQUE_ENABLE,0);
  ax12SetRegister(6,AX_TORQUE_ENABLE,0);
  
  ax12SetRegister(1,AX_LED,0);
  ax12SetRegister(2,AX_LED,0);
  ax12SetRegister(3,AX_LED,0);
  ax12SetRegister(4,AX_LED,0);
  ax12SetRegister(5,AX_LED,0);
  ax12SetRegister(6,AX_LED,0); 
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
int degree2pos(float degree)
{
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
  Serial.println(GetPositionExt(2));
  Serial.print("Ombro2: ");
  Serial.println(GetPositionExt(3));
  Serial.print("Cotovelo: ");
  Serial.println(GetPositionExt(4));
  Serial.print("Pulso: ");
  Serial.println(GetPositionExt(5));
  Serial.print("Garra: ");
  Serial.println(GetPositionExt(6));
}

float GetPositionExt(int num_motor){
  float degree = pos2degree(ax12GetRegister(num_motor, 36, 2));
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
  SetPosition(2, degree2pos(num_pos1));
  SetPosition(3, degree2pos(num_pos2));
  SetPosition(4, degree2pos(num_pos3));
  SetPosition(5, degree2pos(num_pos4));
  SetPosition(6, degree2pos(num_pos5));
  
  int i=0;
  
  while(((GetPositionExt(2) < num_pos1 -5 || GetPositionExt(2) > num_pos1 +5) || (GetPositionExt(3) < num_pos2 -5 || GetPositionExt(3) > num_pos2 +5) || (GetPositionExt(4) < num_pos3 -5 || GetPositionExt(4) > num_pos3 +5) || (GetPositionExt(5) < num_pos4 -5 || GetPositionExt(5) > num_pos4 +5) || (GetPositionExt(6) < num_pos5 -5 || GetPositionExt(6) > num_pos5 +5)) && i<50){ 
     
    Serial.print((GetPositionExt(2) < num_pos1 -5 || GetPositionExt(2) > num_pos1 +5));
    Serial.print((GetPositionExt(3) < num_pos2 -5 || GetPositionExt(3) > num_pos2 +5));
    Serial.print((GetPositionExt(4) < num_pos3 -5 || GetPositionExt(4) > num_pos3 +5));
    Serial.print((GetPositionExt(5) < num_pos4 -5 || GetPositionExt(5) > num_pos4 +5));
    Serial.println((GetPositionExt(6) < num_pos5 -5 || GetPositionExt(6) > num_pos5 +5));
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

