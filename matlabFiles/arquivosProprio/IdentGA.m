%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        Identifica??o de sistemas                    %%%
%%%                        usando Algoritmo Gen?tico                    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
warning off;

load dados.mat;

global entrada saida tout
T_stop = 96.1;
tout = 0:.1:T_stop;

%entrada e saida esperados
entrada = [motor2, motor3, motor4, motor5];
saida = [saidaX, saidaY, saidaZ];

%Par?metros do GA
lb = zeros(1,21);    %Limite inferior de x
ub = ones(1,21);       %Limite superior de x
D = length(ub);

options = optimoptions('ga',...
'CrossoverFraction', 0.7,...
'Display', 'off', ...
'FunctionTolerance', 1e-3,...
'MaxGenerations', 1*D,...
'PopulationSize', 30);

% xi = linspace(-6,2,300);
% yi = linspace(-4,4,300);
% [X,Y] = meshgrid(xi,yi);
% Z = ps_example([X(:),Y(:)]);

%GA
[x,erro,~,output] = ga(@ident_problem,D,[],[],[],[],lb,ub,[],options);
%ga(@ps_example,D,[],[],[],[],lb,ub,[],options); 

disp(x);

figure
plot(tout,saida,'black',tout,y,'red')
title('Resposta da Identifica??o usando GA','FontSize', 16)
xlabel('Tempo ','FontSize', 16)
ylabel('Saida','FontSize', 16)
legend('Real','Estimado')

%% Problem
% % function erro = ident_problem(x)
% % 
% % global saida entrada tout
% % %Fun??o de transfer?ncia da planta
% % syst = tf(x(1),[x(2) x(3) x(4)]);
% % y = lsim(syst,entrada,tout);
% % 
% % erro = (sum((saida-y).^2))^(1/2);
% % 
% % end