% clc
clear
close all

step=2e-4;
Ref =1;
gu= 100;
ge = 50;
gde = 20;
D=20;
tsim = 6; % tempo de simula��o

%% -----------------------------------
%Sistema de Inferencia Fuzzy - Tipo Mamdani
%**** PARTE 1 - Defini��o dos conjuntos fuzzy
SistFuzzy = newfis('ControleFuzzy');

%Input 1 = ErroX
SistFuzzy = addvar(SistFuzzy,'input','ErroX',[-200 200]);
SistFuzzy = addmf(SistFuzzy,'input',1,'P1','trimf', [-25 0 25]);
SistFuzzy = addmf(SistFuzzy,'input',1,'P2neg','trimf', [-75 -50 -25]);
SistFuzzy = addmf(SistFuzzy,'input',1,'P2pos','trimf', [25 50 75]);
SistFuzzy = addmf(SistFuzzy,'input',1,'Mneg','trapmf', [-150 -100 -75 -50]);
SistFuzzy = addmf(SistFuzzy,'input',1,'Mpos','trapmf', [50 75 100 150]);
SistFuzzy = addmf(SistFuzzy,'input',1,'Gneg','trapmf', [-700 -700 -150 -100]);
SistFuzzy = addmf(SistFuzzy,'input',1,'Gpos','trapmf', [100 150 700 700]);

%Input 2 = ErroY
SistFuzzy = addvar(SistFuzzy,'input','ErroY',[-200 200]);
SistFuzzy = addmf(SistFuzzy,'input',2,'P1','trimf', [-25 0 25]);
SistFuzzy = addmf(SistFuzzy,'input',2,'P2neg','trimf', [-75 -50 -25]);
SistFuzzy = addmf(SistFuzzy,'input',2,'P2pos','trimf', [25 50 75]);
SistFuzzy = addmf(SistFuzzy,'input',2,'Mneg','trapmf', [-150 -100 -75 -50]);
SistFuzzy = addmf(SistFuzzy,'input',2,'Mpos','trapmf', [50 75 100 150]);
SistFuzzy = addmf(SistFuzzy,'input',2,'Gneg','trapmf', [-700 -700 -150 -100]);
SistFuzzy = addmf(SistFuzzy,'input',2,'Gpos','trapmf', [100 150 700 700]);

%Input 3 = ErroZ
SistFuzzy = addvar(SistFuzzy,'input','ErroZ',[-400 400]);
SistFuzzy = addmf(SistFuzzy,'input',3,'P1','trimf', [-25 0 25]);
SistFuzzy = addmf(SistFuzzy,'input',3,'P2neg','trimf', [-100 -50 0]);
SistFuzzy = addmf(SistFuzzy,'input',3,'P2pos','trimf', [0 50 100]);
SistFuzzy = addmf(SistFuzzy,'input',3,'Mneg','trimf', [-300 -200 -100]);
SistFuzzy = addmf(SistFuzzy,'input',3,'Mpos','trimf', [100 200 300]);
SistFuzzy = addmf(SistFuzzy,'input',3,'Gneg','trapmf', [-700 -700 -300 -250]);
SistFuzzy = addmf(SistFuzzy,'input',3,'Gpos','trapmf', [250 300 700 700]);

%Output = J1 motor2
maximoMotor2 = 180;
SistFuzzy = addvar(SistFuzzy,'output','Junta1',[-maximoMotor2 maximoMotor2]);
SistFuzzy = addmf(SistFuzzy,'output',1,'P1','trimf', [-20 0 20]);
SistFuzzy = addmf(SistFuzzy,'output',1,'P2neg','trapmf', [-40 -30 -20 -10]);
SistFuzzy = addmf(SistFuzzy,'output',1,'P2pos','trapmf', [10 20 30 40]);
SistFuzzy = addmf(SistFuzzy,'output',1,'Mneg','trapmf', [-60 -50 -40 -30]);
SistFuzzy = addmf(SistFuzzy,'output',1,'Mpos','trapmf', [30 40 50 60]);
SistFuzzy = addmf(SistFuzzy,'output',1,'Gneg','trapmf', [-maximoMotor2 -maximoMotor2 -60 -50]);
SistFuzzy = addmf(SistFuzzy,'output',1,'Gpos','trapmf', [50 60 maximoMotor2 maximoMotor2]);

%Output = J2 motor3
maximoMotor3 = 110;
SistFuzzy = addvar(SistFuzzy,'output','Junta2',[-maximoMotor3 maximoMotor3]);
SistFuzzy = addmf(SistFuzzy,'output',2,'P1','trimf', [-20 0 20]);
SistFuzzy = addmf(SistFuzzy,'output',2,'P2neg','trapmf', [-40 -30 -20 -10]);
SistFuzzy = addmf(SistFuzzy,'output',2,'P2pos','trapmf', [10 20 30 40]);
SistFuzzy = addmf(SistFuzzy,'output',2,'Mneg','trapmf', [-60 -50 -40 -30]);
SistFuzzy = addmf(SistFuzzy,'output',2,'Mpos','trapmf', [30 40 50 60]);
SistFuzzy = addmf(SistFuzzy,'output',2,'Gneg','trapmf', [-maximoMotor3 -maximoMotor3 -60 -50]);
SistFuzzy = addmf(SistFuzzy,'output',2,'Gpos','trapmf', [50 60 maximoMotor3 maximoMotor3]);

%Output = J3 motor4
maximoMotor4 = 260;
SistFuzzy = addvar(SistFuzzy,'output','Junta3',[-maximoMotor4 maximoMotor4]);
SistFuzzy = addmf(SistFuzzy,'output',3,'P1','trimf', [-20 0 20]);
SistFuzzy = addmf(SistFuzzy,'output',3,'P2neg','trapmf', [-40 -30 -20 -10]);
SistFuzzy = addmf(SistFuzzy,'output',3,'P2pos','trapmf', [10 20 30 40]);
SistFuzzy = addmf(SistFuzzy,'output',3,'Mneg','trapmf', [-60 -50 -40 -30]);
SistFuzzy = addmf(SistFuzzy,'output',3,'Mpos','trapmf', [30 40 50 60]);
SistFuzzy = addmf(SistFuzzy,'output',3,'Gneg','trapmf', [-maximoMotor4 -maximoMotor4 -60 -50]);
SistFuzzy = addmf(SistFuzzy,'output',3,'Gpos','trapmf', [50 60 maximoMotor4 maximoMotor4]);

%Output = J4 motor5
maximoMotor5 = 200;
SistFuzzy = addvar(SistFuzzy,'output','Junta4',[-maximoMotor5 maximoMotor5]);
SistFuzzy = addmf(SistFuzzy,'output',4,'P1','trimf', [-20 0 20]);
SistFuzzy = addmf(SistFuzzy,'output',4,'P2neg','trapmf', [-40 -30 -20 -10]);
SistFuzzy = addmf(SistFuzzy,'output',4,'P2pos','trapmf', [10 20 30 40]);
SistFuzzy = addmf(SistFuzzy,'output',4,'Mneg','trapmf', [-60 -50 -40 -30]);
SistFuzzy = addmf(SistFuzzy,'output',4,'Mpos','trapmf', [30 40 50 60]);
SistFuzzy = addmf(SistFuzzy,'output',4,'Gneg','trapmf', [-maximoMotor5 -maximoMotor5 -60 -50]);
SistFuzzy = addmf(SistFuzzy,'output',4,'Gpos','trapmf', [50 60 maximoMotor5 maximoMotor5]);

% Varia��es de fun��es
%"gbellmf"	Generalized bell-shaped membership function	gbellmf
%"gaussmf"	Gaussian membership function	gaussmf
%"gauss2mf"	Gaussian combination membership function	gauss2mf
%"trimf"	Triangular membership function	trimf
%"trapmf"	Trapezoidal membership function	trapmf
%"sigmf"	Sigmoidal membership function	sigmf
%"dsigmf"	Difference between two sigmoidal membership functions	dsigmf
%"psigmf"	Product of two sigmoidal membership functions	psigmf
%"zmf"	Z-shaped membership function	zmf
%"pimf"	Pi-shaped membership function	pimf
%"smf"	S-shaped membership function	smf

figure(1)
subplot(3,1,1),plotmf(SistFuzzy,'input',1);
subplot(3,1,2),plotmf(SistFuzzy,'input',2);
subplot(3,1,3),plotmf(SistFuzzy,'input',3);
figure(2)
subplot(4,1,1),plotmf(SistFuzzy,'output',1);
subplot(4,1,2),plotmf(SistFuzzy,'output',2);
subplot(4,1,3),plotmf(SistFuzzy,'output',3);
subplot(4,1,4),plotmf(SistFuzzy,'output',4);

%% -----------------------------------
%**** PARTE 2- inserindo REGRAS
%[Conjunto1 Conjunto2 Conjunto3 Peso L�gica]
regras = [6 6 1 (1) 1
6 1 1 (1) 1
6 2 1 (1) 1
6 3 2 (1) 1
6 4 3 (1) 1
6 5 4 (1) 1
6 7 5 (1) 1
1 6 1 (1) 1
1 1 1 (1) 1
1 2 2 (1) 1
1 3 3 (1) 1
1 4 4 (1) 1
1 5 5 (1) 1
1 7 6 (1) 1
2 6 1 (1) 1
2 1 2 (1) 1
2 2 3 (1) 1
2 3 4 (1) 1
2 4 5 (1) 1
2 5 6 (1) 1
2 7 7 (1) 1
3 6 2 (1) 1
3 1 3 (1) 1
3 2 4 (1) 1
3 3 5 (1) 1
3 4 6 (1) 1
3 5 7 (1) 1
3 7 8 (1) 1
4 6 3 (1) 1
4 1 4 (1) 1
4 2 5 (1) 1
4 3 6 (1) 1
4 4 7 (1) 1
4 5 8 (1) 1
4 7 9 (1) 1
5 6 4 (1) 1
5 1 5 (1) 1
5 2 6 (1) 1
5 3 7 (1) 1
5 4 8 (1) 1
5 5 9 (1) 1
5 7 9 (1) 1
7 6 5 (1) 1
7 1 6 (1) 1
7 2 7 (1) 1
7 3 8 (1) 1
7 4 9 (1) 1
7 5 9 (1) 1
7 7 9 (1) 1];

%[entrada1 entrada2 entrada3 saida1 saida2 saida3 saida4 Peso L�gica]
regrasNovas = [
    1 1 1 1 1 1 1 (1) 1
    1 1 2 1 2 3 2 (1) 1
    1 1 3 1 3 2 3 (1) 1
    1 1 4 1 4 5 4 (1) 1
    1 1 5 1 5 4 5 (1) 1
    1 1 6 1 6 7 6 (1) 1
    1 1 7 1 7 6 7 (1) 1
    1 2 1 1 2 1 2 (1) 1
    1 2 2 1 2 3 2 (1) 1
    1 2 3 1 1 2 1 (1) 1
    1 2 4 1 4 5 4 (1) 1
    1 2 5 1 3 4 3 (1) 1
    1 2 6 1 6 7 6 (1) 1
    1 2 7 1 5 6 5 (1) 1
    1 3 1 1 3 1 3 (1) 1
    1 3 2 1 1 3 1 (1) 1
    1 3 3 1 2 2 2 (1) 1
    1 3 4 1 2 5 2 (1) 1
    1 3 5 1 5 4 5 (1) 1
    1 3 6 1 4 7 4 (1) 1
    1 3 7 1 7 6 7 (1) 1
    1 4 1 1 4 1 4 (1) 1
    1 4 2 1 4 3 4 (1) 1
    1 4 3 1 2 2 2 (1) 1
    1 4 4 1 4 5 4 (1) 1
    1 4 5 1 1 4 1 (1) 1
    1 4 6 1 6 7 6 (1) 1
    1 4 7 1 5 6 4 (1) 1
    1 5 1 1 5 1 5 (1) 1
    1 5 2 1 3 3 3 (1) 1
    1 5 3 1 5 2 5 (1) 1
    1 5 4 1 1 5 1 (1) 1
    1 5 5 1 5 4 5 (1) 1
    1 5 6 1 4 7 4 (1) 1
    1 5 7 1 7 6 7 (1) 1
    1 6 1 1 6 1 6 (1) 1
    1 6 2 1 6 3 6 (1) 1
    1 6 3 1 4 2 4 (1) 1
    1 6 4 1 6 5 6 (1) 1
    1 6 5 1 4 4 4 (1) 1
    1 6 6 1 6 7 6 (1) 1
    1 6 7 1 5 6 5 (1) 1
    1 7 1 1 7 1 7 (1) 1
    1 7 2 1 5 3 5 (1) 1
    1 7 3 1 7 2 7 (1) 1
    1 7 4 1 5 5 5 (1) 1
    1 7 5 1 7 4 7 (1) 1
    1 7 6 1 5 7 5 (1) 1
    1 7 7 1 7 6 7 (1) 1
    2 1 1 3 1 1 1 (1) 1
    2 1 2 3 2 3 2 (1) 1
    2 1 3 3 3 2 3 (1) 1
    2 1 4 3 4 5 4 (1) 1
    2 1 5 3 5 4 5 (1) 1
    2 1 6 3 6 7 6 (1) 1
    2 1 7 3 7 6 7 (1) 1
    2 2 1 3 2 1 2 (1) 1
    2 2 2 3 2 3 2 (1) 1
    2 2 3 3 1 2 1 (1) 1
    2 2 4 3 4 5 4 (1) 1
    2 2 5 3 3 4 3 (1) 1
    2 2 6 3 6 7 6 (1) 1
    2 2 7 3 5 6 5 (1) 1
    2 3 1 3 3 1 3 (1) 1
    2 3 2 3 1 3 1 (1) 1
    2 3 3 3 2 2 2 (1) 1
    2 3 4 3 2 5 2 (1) 1
    2 3 5 3 5 4 5 (1) 1
    2 3 6 3 4 7 4 (1) 1
    2 3 7 3 7 6 7 (1) 1
    2 4 1 3 4 1 4 (1) 1
    2 4 2 3 4 3 4 (1) 1
    2 4 3 3 2 2 2 (1) 1
    2 4 4 3 4 5 4 (1) 1
    2 4 5 3 1 4 1 (1) 1
    2 4 6 3 6 7 6 (1) 1
    2 4 7 3 5 6 5 (1) 1
    2 5 1 3 5 1 5 (1) 1
    2 5 2 3 3 3 3 (1) 1
    2 5 3 3 5 2 5 (1) 1
    2 5 4 3 1 5 1 (1) 1
    2 5 5 3 5 4 5 (1) 1
    2 5 6 3 4 7 4 (1) 1
    2 5 7 3 7 6 7 (1) 1
    2 6 1 3 6 1 6 (1) 1
    2 6 2 3 6 3 6 (1) 1
    2 6 3 3 4 2 4 (1) 1
    2 6 4 3 6 5 6 (1) 1
    2 6 5 3 4 4 4 (1) 1
    2 6 6 3 6 7 6 (1) 1
    2 6 7 3 5 6 5 (1) 1
    2 7 1 3 7 1 7 (1) 1
    2 7 2 3 5 3 5 (1) 1
    2 7 3 3 7 2 7 (1) 1
    2 7 4 3 5 5 5 (1) 1
    2 7 5 3 7 4 7 (1) 1
    2 7 6 3 5 7 5 (1) 1
    2 7 7 3 7 6 7 (1) 1
    3 1 1 2 1 1 1 (1) 1
    3 1 2 2 2 3 2 (1) 1
    3 1 3 2 3 2 3 (1) 1
    3 1 4 2 4 5 4 (1) 1
    3 1 5 2 5 4 5 (1) 1
    3 1 6 2 6 7 6 (1) 1
    3 1 7 2 7 6 7 (1) 1
    3 2 1 2 2 1 2 (1) 1
    3 2 2 2 2 3 2 (1) 1
    3 2 3 2 1 2 1 (1) 1
    3 2 4 2 4 5 4 (1) 1
    3 2 5 2 3 4 3 (1) 1
    3 2 6 2 6 7 6 (1) 1
    3 2 7 2 5 6 5 (1) 1
    3 3 1 2 3 1 3 (1) 1
    3 3 2 2 1 3 1 (1) 1
    3 3 3 2 2 2 2 (1) 1
    3 3 4 2 2 5 2 (1) 1
    3 3 5 2 5 4 5 (1) 1
    3 3 6 2 4 7 4 (1) 1
    3 3 7 2 7 6 7 (1) 1
    3 4 1 2 4 1 4 (1) 1
    3 4 2 2 4 3 4 (1) 1
    3 4 3 2 2 2 2 (1) 1
    3 4 4 2 4 5 4 (1) 1
    3 4 5 2 1 4 1 (1) 1
    3 4 6 2 6 7 6 (1) 1
    3 4 7 2 5 6 5 (1) 1
    3 5 1 2 5 1 5 (1) 1
    3 5 2 2 3 3 3 (1) 1
    3 5 3 2 5 2 5 (1) 1
    3 5 4 2 1 5 1 (1) 1
    3 5 5 2 5 4 5 (1) 1
    3 5 6 2 4 7 4 (1) 1
    3 5 7 2 7 6 7 (1) 1
    3 6 1 2 6 1 6 (1) 1
    3 6 2 2 6 3 6 (1) 1
    3 6 3 2 4 2 4 (1) 1
    3 6 4 2 6 5 6 (1) 1
    3 6 5 2 4 4 4 (1) 1
    3 6 6 2 6 7 6 (1) 1
    3 6 7 2 5 6 5 (1) 1
    3 7 1 2 7 1 7 (1) 1
    3 7 2 2 5 3 5 (1) 1
    3 7 3 2 7 2 7 (1) 1
    3 7 4 2 5 5 5 (1) 1
    3 7 5 2 7 4 7 (1) 1
    3 7 6 2 5 7 5 (1) 1
    3 7 7 2 7 6 7 (1) 1
    4 1 1 5 1 1 1 (1) 1
    4 1 2 5 2 3 2 (1) 1
    4 1 3 5 3 2 3 (1) 1
    4 1 4 5 4 5 4 (1) 1
    4 1 5 5 5 4 5 (1) 1
    4 1 6 5 6 7 6 (1) 1
    4 1 7 5 7 6 7 (1) 1
    4 2 1 5 2 1 2 (1) 1
    4 2 2 5 2 3 2 (1) 1
    4 2 3 5 1 2 1 (1) 1
    4 2 4 5 4 5 4 (1) 1
    4 2 5 5 3 4 3 (1) 1
    4 2 6 5 6 7 6 (1) 1
    4 2 7 5 5 6 5 (1) 1
    4 3 1 5 3 1 3 (1) 1
    4 3 2 5 1 3 1 (1) 1
    4 3 3 5 2 2 2 (1) 1
    4 3 4 5 2 5 2 (1) 1
    4 3 5 5 5 4 5 (1) 1
    4 3 6 5 4 7 4 (1) 1
    4 3 7 5 7 6 7 (1) 1
    4 4 1 5 4 1 4 (1) 1
    4 4 2 5 4 3 4 (1) 1
    4 4 3 5 2 2 2 (1) 1
    4 4 4 5 4 5 4 (1) 1
    4 4 5 5 1 4 1 (1) 1
    4 4 6 5 6 7 6 (1) 1
    4 4 7 5 5 6 5 (1) 1
    4 5 1 5 5 1 5 (1) 1
    4 5 2 5 3 3 3 (1) 1
    4 5 3 5 5 2 5 (1) 1
    4 5 4 5 1 5 1 (1) 1
    4 5 5 5 5 4 5 (1) 1
    4 5 6 5 4 7 4 (1) 1
    4 5 7 5 7 6 7 (1) 1
    4 6 1 5 6 1 6 (1) 1
    4 6 2 5 6 3 6 (1) 1
    4 6 3 5 4 2 4 (1) 1
    4 6 4 5 6 5 6 (1) 1
    4 6 5 5 4 4 4 (1) 1
    4 6 6 5 6 7 6 (1) 1
    4 6 7 5 5 6 5 (1) 1
    4 7 1 5 7 1 7 (1) 1
    4 7 2 5 5 3 5 (1) 1
    4 7 3 5 7 2 7 (1) 1
    4 7 4 5 5 5 5 (1) 1
    4 7 5 5 7 4 7 (1) 1
    4 7 6 5 5 7 5 (1) 1
    4 7 7 5 7 6 7 (1) 1
    5 1 1 4 1 1 1 (1) 1
    5 1 2 4 2 3 2 (1) 1
    5 1 3 4 3 2 3 (1) 1
    5 1 4 4 4 5 4 (1) 1
    5 1 5 4 5 4 5 (1) 1
    5 1 6 4 6 7 6 (1) 1
    5 1 7 4 7 6 7 (1) 1
    5 2 1 4 2 1 2 (1) 1
    5 2 2 4 2 3 2 (1) 1
    5 2 3 4 1 2 1 (1) 1
    5 2 4 4 4 5 4 (1) 1
    5 2 5 4 3 4 3 (1) 1
    5 2 6 4 6 7 6 (1) 1
    5 2 7 4 5 6 4 (1) 1
    5 3 1 4 3 1 3 (1) 1
    5 3 2 4 1 3 1 (1) 1
    5 3 3 4 2 2 2 (1) 1
    5 3 4 4 2 5 2 (1) 1
    5 3 5 4 5 4 5 (1) 1
    5 3 6 4 4 7 4 (1) 1
    5 3 7 4 7 6 7 (1) 1
    5 4 1 4 4 1 4 (1) 1
    5 4 2 4 4 3 4 (1) 1
    5 4 3 4 2 2 2 (1) 1
    5 4 4 4 4 5 4 (1) 1
    5 4 5 4 1 4 1 (1) 1
    5 4 6 4 6 7 6 (1) 1
    5 4 7 4 5 6 5 (1) 1
    5 5 1 4 5 1 5 (1) 1
    5 5 2 4 3 3 3 (1) 1
    5 5 3 4 5 2 5 (1) 1
    5 5 4 4 1 5 1 (1) 1
    5 5 5 4 5 4 5 (1) 1
    5 5 6 4 4 7 4 (1) 1
    5 5 7 4 7 6 7 (1) 1
    5 6 1 4 6 1 6 (1) 1
    5 6 2 4 6 3 6 (1) 1
    5 6 3 4 4 2 4 (1) 1
    5 6 4 4 6 5 6 (1) 1
    5 6 5 4 4 4 4 (1) 1
    5 6 6 4 6 7 6 (1) 1
    5 6 7 4 5 6 5 (1) 1
    5 7 1 4 7 1 7 (1) 1
    5 7 2 4 5 3 5 (1) 1
    5 7 3 4 7 2 7 (1) 1
    5 7 4 4 5 5 5 (1) 1
    5 7 5 4 7 4 7 (1) 1
    5 7 6 4 5 7 5 (1) 1
    5 7 7 4 7 6 7 (1) 1
    6 1 1 7 1 1 1 (1) 1
    6 1 2 7 2 3 3 (1) 1
    6 1 3 7 3 2 4 (1) 1
    6 1 4 7 4 5 5 (1) 1
    6 1 5 7 5 4 6 (1) 1
    6 1 6 7 6 7 7 (1) 1
    6 1 7 7 7 6 7 (1) 1
    6 2 1 7 2 1 2 (1) 1
    6 2 2 7 2 3 2 (1) 1
    6 2 3 7 1 2 1 (1) 1
    6 2 4 7 4 5 4 (1) 1
    6 2 5 7 3 4 3 (1) 1
    6 2 6 7 6 7 6 (1) 1
    6 2 7 7 5 6 5 (1) 1
    6 3 1 7 3 1 3 (1) 1
    6 3 2 7 1 3 1 (1) 1
    6 3 3 7 2 2 2 (1) 1
    6 3 4 7 2 5 2 (1) 1
    6 3 5 7 5 4 5 (1) 1
    6 3 6 7 4 7 4 (1) 1
    6 3 7 7 7 6 7 (1) 1
    6 4 1 7 4 1 4 (1) 1
    6 4 2 7 4 3 4 (1) 1
    6 4 3 7 2 2 2 (1) 1
    6 4 4 7 4 5 4 (1) 1
    6 4 5 7 1 4 1 (1) 1
    6 4 6 7 6 7 6 (1) 1
    6 4 7 7 5 6 5 (1) 1
    6 5 1 7 5 1 5 (1) 1
    6 5 2 7 3 3 3 (1) 1
    6 5 3 7 5 2 5 (1) 1
    6 5 4 7 1 5 1 (1) 1
    6 5 5 7 5 4 5 (1) 1
    6 5 6 7 4 7 4 (1) 1
    6 5 7 7 7 6 7 (1) 1
    6 6 1 7 6 1 6 (1) 1
    6 6 2 7 6 3 6 (1) 1
    6 6 3 7 4 2 4 (1) 1
    6 6 4 7 6 5 6 (1) 1
    6 6 5 7 4 4 4 (1) 1
    6 6 6 7 6 7 6 (1) 1
    6 6 7 7 5 6 5 (1) 1
    6 7 1 7 7 1 7 (1) 1
    6 7 2 7 5 3 5 (1) 1
    6 7 3 7 7 2 7 (1) 1
    6 7 4 7 5 5 5 (1) 1
    6 7 5 7 7 4 7 (1) 1
    6 7 6 7 5 7 5 (1) 1
    6 7 7 7 7 6 7 (1) 1
    7 1 1 6 1 1 1 (1) 1
    7 1 2 6 2 3 2 (1) 1
    7 1 3 6 3 2 3 (1) 1
    7 1 4 6 4 5 4 (1) 1
    7 1 5 6 5 4 5 (1) 1
    7 1 6 6 6 7 6 (1) 1
    7 1 7 6 7 6 7 (1) 1
    7 2 1 6 2 1 2 (1) 1
    7 2 2 6 2 3 2 (1) 1
    7 2 3 6 1 2 1 (1) 1
    7 2 4 6 4 5 4 (1) 1
    7 2 5 6 3 4 3 (1) 1
    7 2 6 6 6 7 6 (1) 1
    7 2 7 6 5 6 5 (1) 1
    7 3 1 6 3 1 3 (1) 1
    7 3 2 6 1 3 1 (1) 1
    7 3 3 6 2 2 2 (1) 1
    7 3 4 6 2 5 2 (1) 1
    7 3 5 6 5 4 5 (1) 1
    7 3 6 6 4 7 4 (1) 1
    7 3 7 6 7 6 7 (1) 1
    7 4 1 6 4 1 4 (1) 1
    7 4 2 6 4 3 4 (1) 1
    7 4 3 6 2 2 2 (1) 1
    7 4 4 6 4 5 4 (1) 1
    7 4 5 6 1 4 1 (1) 1
    7 4 6 6 6 7 6 (1) 1
    7 4 7 6 5 6 5 (1) 1
    7 5 1 6 5 1 5 (1) 1
    7 5 2 6 3 3 3 (1) 1
    7 5 3 6 5 2 5 (1) 1
    7 5 4 6 1 5 1 (1) 1
    7 5 5 6 5 4 5 (1) 1
    7 5 6 6 4 7 4 (1) 1
    7 5 7 6 7 6 7 (1) 1
    7 6 1 6 6 1 6 (1) 1
    7 6 2 6 6 3 6 (1) 1
    7 6 3 6 4 2 4 (1) 1
    7 6 4 6 6 5 6 (1) 1
    7 6 5 6 4 4 4 (1) 1
    7 6 6 6 6 7 6 (1) 1
    7 6 7 6 5 6 5 (1) 1
    7 7 1 6 7 1 7 (1) 1
    7 7 2 6 5 3 5 (1) 1
    7 7 3 6 7 2 7 (1) 1
    7 7 4 6 5 5 5 (1) 1
    7 7 5 6 7 4 7 (1) 1
    7 7 6 6 5 7 5 (1) 1
    7 7 7 6 7 6 7 (1) 1
    ];

SistFuzzy = addrule(SistFuzzy,regrasNovas);       

save SistFuzzy;


%% -----------------------
%Simula��o do Controlador Fuzzy e compara��o com o PID
delta = 3;
vari = 0.00001;
sim('modeloFuzzy',tsim);
figure
plot(t,ref,'k',t,y1,t,y,'r'),
legend('Set-Point','PID response','Fuzzy controler');
xlabel('tempo (s)');
axis([0 tsim 0 3])
title(['delta=',num2str(delta),'    vari�ncia=',num2str(vari)])
grid
