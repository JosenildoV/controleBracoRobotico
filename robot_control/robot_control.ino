#include <ax12.h>
#include <BioloidController.h>

void setup(){
  
}

void loop(){
  
}

//Função para colocar braço na posição inicial
void homePos(){
  
  //Mudar velocidade
  ax12SetRegister2(2,AX_TORQUE_LIMIT_L,400);
  ax12SetRegister2(3,AX_TORQUE_LIMIT_L,400);
  ax12SetRegister2(4,AX_TORQUE_LIMIT_L,400);
  ax12SetRegister2(5,AX_TORQUE_LIMIT_L,400);
  ax12SetRegister2(6,AX_TORQUE_LIMIT_L,400);
  delay(1000);
  ax12SetRegister2(2,32,50);
  ax12SetRegister2(3,32,50);
  ax12SetRegister2(4,32,50);
  ax12SetRegister2(5,32,50);
  ax12SetRegister2(6,32,50);
  
  //Mudar posição para inicial (ou home)
  SetPosition(6,degree2pos(0));
  SetPosition(5,degree2pos(-50));
  SetPosition(4,degree2pos(-142));
  SetPosition(3,degree2pos(141));
  SetPosition(2,degree2pos(0));
  delay(8000);
  
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

//Levar de posição para grau
int pos2degree(int pos){

  float deg = (300*(float(pos)/1023.0));

  int degree = (int) (deg - 150);  

  return degree;
}

// Levar de grau para posição
int degree2pos(int degree)
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
  
  int pos2 = ax12GetRegister(2, 36, 2);
  int pos3 = ax12GetRegister(3, 36, 2);
  int pos4 = ax12GetRegister(4, 36, 2);
  int pos5 = ax12GetRegister(5, 36, 2);
  int pos6 = ax12GetRegister(6, 36, 2);
  delay(500);
  Serial.print("Ombro1: ");
  Serial.println(pos2degree(pos2));
  Serial.print("Ombro2: ");
  Serial.println(pos2degree(pos3));
  Serial.print("Cotovelo: ");
  Serial.println(pos2degree(pos4));
  Serial.print("Pulso: ");
  Serial.println(pos2degree(pos5));
  Serial.print("Garra: ");
  Serial.println(pos2degree(pos6));
}
