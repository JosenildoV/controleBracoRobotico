clc
clear
close all

step=2e-4;
Ref =1;
gu= 100;
ge = 50;
gde = 20;
D=20;
tsim = 6; % tempo de simulação

%% -----------------------------------
%Sistema de Inferencia Fuzzy - Tipo Mamdani
%**** PARTE 1 - Definição dos conjuntos fuzzy
SistFuzzy = newfis('ControleFuzzy');
%Input 1 = Erro
SistFuzzy = addvar(SistFuzzy,'input','Erro',[-1 1]);
SistFuzzy = addmf(SistFuzzy,'input',1,'NB','trapmf', [-1 -1 -0.8439 -0.59]);
SistFuzzy = addmf(SistFuzzy,'input',1,'NM','trimf', [-0.8386 -0.537 -0.204]);
SistFuzzy = addmf(SistFuzzy,'input',1,'NS','trimf', [-0.59 -0.2725 0]);
SistFuzzy = addmf(SistFuzzy,'input',1,'ZE','trimf', [-0.2 0 0.2]);
SistFuzzy = addmf(SistFuzzy,'input',1,'PS','trimf', [0 0.2619 0.627]);
SistFuzzy = addmf(SistFuzzy,'input',1,'PM','trimf', [0.2093 0.5163 0.8704]);
SistFuzzy = addmf(SistFuzzy,'input',1,'PB','trapmf', [0.6111 0.8 1 1]);

%Input 2 = Derivada do Erro
SistFuzzy = addvar(SistFuzzy,'input','DerivadaErro',[-1 1]);
SistFuzzy = addmf(SistFuzzy,'input',2,'NB','trapmf', [-1 -1 -0.8439 -0.59]);
SistFuzzy = addmf(SistFuzzy,'input',2,'NM','trimf', [-0.8386 -0.537 -0.204]);
SistFuzzy = addmf(SistFuzzy,'input',2,'NS','trimf', [-0.59 -0.2725 0]);
SistFuzzy = addmf(SistFuzzy,'input',2,'ZE','trimf', [-0.2 0 0.2]);
SistFuzzy = addmf(SistFuzzy,'input',2,'PS','trimf', [0 0.2619 0.627]);
SistFuzzy = addmf(SistFuzzy,'input',2,'PM','trimf', [0.209 0.516 0.87]);
SistFuzzy = addmf(SistFuzzy,'input',2,'PB','trapmf', [0.6111 0.8 1 1]);

%Output = Variação da Tensão
SistFuzzy = addvar(SistFuzzy,'output','VariacaoTensao',[-1 1]);
SistFuzzy = addmf(SistFuzzy,'output',1,'NVB','trapmf', [-1 -1 -0.975 -0.775]);
SistFuzzy = addmf(SistFuzzy,'output',1,'NB','trimf', [-1 -0.75 -0.5]);
SistFuzzy = addmf(SistFuzzy,'output',1,'NM','trimf', [-0.75 -0.5 -0.25]);
SistFuzzy = addmf(SistFuzzy,'output',1,'NS','trimf', [-0.5 -0.25 0]);
SistFuzzy = addmf(SistFuzzy,'output',1,'ZE','trimf', [-0.25 0 0.25]);
SistFuzzy = addmf(SistFuzzy,'output',1,'PS','trimf', [0 0.25 0.5]);
SistFuzzy = addmf(SistFuzzy,'output',1,'PM','trimf', [0.25 0.5 0.75]);
SistFuzzy = addmf(SistFuzzy,'output',1,'PB','trimf', [0.5 0.75 1]);
SistFuzzy = addmf(SistFuzzy,'output',1,'PVB','trapmf', [0.775 0.975 1 1]);

% Variações de funções
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
subplot(3,1,3),plotmf(SistFuzzy,'output',1);

%% -----------------------------------
%**** PARTE 2- inserindo REGRAS
%[Conjunto1 Conjunto2 Conjunto3 Peso Lógica]
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

SistFuzzy = addrule(SistFuzzy,regras);       

save SistFuzzy;


%% -----------------------
%Simulação do Controlador Fuzzy e comparação com o PID
delta = 3;
vari = 0.00001;
sim('modeloFuzzy',tsim);
figure
plot(t,ref,'k',t,y1,t,y,'r'),
legend('Set-Point','PID response','Fuzzy controler');
xlabel('tempo (s)');
axis([0 tsim 0 3])
title(['delta=',num2str(delta),'    variância=',num2str(vari)])
grid
