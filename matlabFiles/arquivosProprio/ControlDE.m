%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Evolução Diferencial para Ajuste de PID              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear

warning 'off'

load dados.mat;

% global entrada saida entradaTeste entradaTreinamento saidaTeste saidaTreinamento tout
T_stop = 20;
tout = 0:.1:T_stop;

%entrada e saida esperados
entrada = [motor2, motor3, motor4, motor5];
saida = [saidaX, saidaY, saidaZ];

Ar_ger = [16];
Ar_ind = [12];
Ar_cru = [0.8];
Ar_mut = [0.05];

aux = length(entrada)/10;

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

                erroTest_total = [];
                indiv_total = [];
                fitness_total = [];
                generationFitness_total = [];
                generationFitness_best_total = [];
                fitness_bestByGeneration_total = [];
                
                for m=1:4
                    disp(['loop num: ' int2str(m)]);
                    
                    %vetor booleano para separar entrada e sainda em teste e treinamento
                    boolVector = ones(length(entrada),1); 
                    boolVector(((m-1)*aux)+1:m*aux) = 0;
                    
                    %separacao da entrada e saida entre teste e treinamento
                    entradaTeste = entrada(logical(~boolVector),:);
                    entradaTreinamento = entrada(logical(boolVector),:);
                    saidaTeste = saida(logical(~boolVector),:);
                    saidaTreinamento = saida(logical(boolVector),:);
                    
                    %Algoritmo de treinamento
                    [x_i, fitness_i, generationFitness_i, generationFitness_best, fitness_bestByGeneration] = fun_DE(Param, entradaTreinamento, saidaTreinamento, tout);
                    [erro_indiv,idx] = min(fitness_i);
                    indiv = x_i(idx,:);
                    
                    %Algoritmo de teste
                    C = eye(3);

                    A = [indiv(1) indiv(2) indiv(3)
                        indiv(4) indiv(5) indiv(6)
                        indiv(7) indiv(8) indiv(9)];

                    B = [indiv(10) indiv(11) indiv(12) indiv(13)
                        indiv(14) indiv(15) indiv(16) indiv(17)
                        indiv(18) indiv(19) indiv(20) indiv(21)];
                    
                    systTest = ss(A,B,C,0);
                    difTest = [];
                    for a=1:length(entradaTeste)
                        ent = entradaTeste(a,:);
                        ysim = lsim(systTest, repmat(ent,length(tout),1), tout);
                        difTest(a) = sqrt(sum((ysim(length(tout),:) - saidaTeste(a,:)) .^2));
                    end
                    erroTest = mean(difTest);
                    
                    erroTest_total = [erroTest_total erroTest'];
                    indiv_total = [indiv_total indiv'];
                    fitness_total = [fitness_total fitness_i];
                    generationFitness_total = [generationFitness_total generationFitness_i'];
                    generationFitness_best_total = [generationFitness_best_total generationFitness_best'];
                    fitness_bestByGeneration_total = [fitness_bestByGeneration_total fitness_bestByGeneration'];
                end
                
%                 indiv = mean(indiv_mean');
%                 fitness = mean(fitness_mean);
%                 generationFitness = mean(generationFitness_mean,2);

                save(['dadoSalvo_' int2str(Ar_ger(i)) '_' int2str(Ar_ind(j)) '_' num2str(Ar_cru(k)) '_' num2str(Ar_mut(l)) '.mat'] ...
                    ,'Param','generationFitness_total','fitness_total','indiv_total','generationFitness_best_total','fitness_bestByGeneration_total', 'erroTest_total');

            end
        end
    end
end
% %plotar
% figure
% plot(1:length(generationFitness),generationFitness,'red')
% title('Erro na identificacao por geracao','FontSize', 16)
% xlabel('Tempo ','FontSize', 16)
% ylabel('Erro','FontSize', 16)
