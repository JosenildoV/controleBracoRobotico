%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Evolução Diferencial para Ajuste de PID              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear

warning 'off'

load dados.mat;

global entrada saida tout
T_stop = 200;
tout = 0:.1:T_stop;

%entrada e saida esperados
entrada = [motor2, motor3, motor4, motor5];
saida = [saidaX, saidaY, saidaZ];

Ar_ger = [50, 100, 150, 200];
Ar_ind = [30, 50, 100];
Ar_cru = [0.5, 0.6, 0.65];
Ar_mut = [0.01,0.05,0.1];

for i=1:length(Ar_ger)
    for j=1:length(Ar_ind)
        for k=1:length(Ar_cru)
            for l=1:length(Ar_mut)
                % Parametros
                Param.D = 21;
                Param.ubound_x = 1.*ones(Param.D,1);
                Param.lbound_x = -1.*ones(Param.D,1);

                Param.Num_Gen = Ar_ger(i); % gerações

                Param.Num_Ind = Ar_ind(j); % indivíduos
                Param.F = Ar_cru(k);
                Param.CR = Ar_mut(l);
                Param.StopT = 10;

                disp('Algoritmo DE para Ajuste de PID')

                indiv_mean=[];
                fitness_mean=[];
                generationFitness_mean=[];
                for m=1:10
                    [x_i, fitness_i, generationFitness_i] = fun_DE(Param);
                    [erro_indiv,idx] = min(fitness_i);
                    indiv_i = x_i(idx,:);
                    
                    indiv_mean = [indiv_mean indiv_i'];
                    fitness_mean = [fitness_mean fitness_i'];
                    generationFitness_mean = [generationFitness_mean generationFitness_i'];
                end
                
                indiv = mean(indiv_mean');
                fitness = mean(fitness_mean);
                generationFitness = mean(generationFitness_mean');

                save(['dadoSalvo' int2str(i) int2str(j) int2str(k) int2str(l)],'generationFitness','fitness', 'indiv','indiv_mean');

            end
        end
    end
end
%plotar
figure
plot(1:length(generationFitness),generationFitness,'red')
title('Erro na identificacao por geracao','FontSize', 16)
xlabel('Tempo ','FontSize', 16)
ylabel('Erro','FontSize', 16)
