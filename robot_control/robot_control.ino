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

