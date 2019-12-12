%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Evolução Diferencial para Ajuste de PID              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear

warning 'off'

% Parametros
Param.D = 3;
Param.ubound_x = 6.*ones(Param.D,1);
Param.lbound_x = -2.*ones(Param.D,1);

Param.Num_Gen = 200; % gerações

Param.Num_Ind = 100; % indivíduos
Param.F = 0.1;
Param.CR = 0.8;
Param.StopT = 10;

disp('Algoritmo DE para Ajuste de PID')

ControlEA_DEnew %Abrir modelo no Simulink

[x, fitness] = fun_DE(Param);

[erro_indiv,idx] = min(fitness);

indiv = x(idx,:);

set_param('ControlEA_DEnew/PID_Controller','P',num2str(indiv(1)))
set_param('ControlEA_DEnew/PID_Controller','I',num2str(indiv(2)))
set_param('ControlEA_DEnew/PID_Controller','D',num2str(indiv(3)))
sim('ControlEA_DEnew',Param.StopT)

figure
plot(tout,erros,'red')
title('Erro no Controle usando DE','FontSize', 16)
xlabel('Tempo ','FontSize', 16)
ylabel('Erro','FontSize', 16)