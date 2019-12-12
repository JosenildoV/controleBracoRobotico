%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Evolucao Diferencial                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x, fitness, list_Offspring_fitness, list_Offspring_fitness_best, list_Offitness_best] = fun_DE(Param, entradaTreinamento, saidaTreinamento, tout)

%Parâmetros do algoritmo
Ger = Param.Num_Gen ;             %Total de Gerações
NP = Param.Num_Ind;               %Tamanho da população
F = Param.F ;               %Probabilidade de Cruzamento
CR = Param.CR;               %Probabilidade de Mutação
lbound = Param.lbound_x';           %Limite inferior de x
ubound = Param.ubound_x' ;           %Limite superior de x
D = Param.D ;          %Dimensão de x
StopT = Param.StopT;

%Inicialização da população
x = bsxfun(@plus,lbound,bsxfun(@times,ubound-lbound,rand(NP,D)));

%Avaliação dos individuos
for i=1:NP
    erro = ident_problem(x(i,:),entradaTreinamento, saidaTreinamento, tout);
    fitness(i,1) = erro;
end

index = 1;
while Ger>0 && min(fitness)>1e-5
    Ger = Ger-1;
    disp(Ger)
    
    % Seleção dos indivíduos para mutação
    MatingPool = [1:NP,randi(NP,1,2*NP)];
    Offspring = DE(x(MatingPool,:),Param);
    %Avaliar Filhos
    for i=1:NP
        erro = ident_problem(Offspring(i,:),entradaTreinamento, saidaTreinamento, tout);
        Offspring_fitness(i,1) = erro;
    end
    
    for i = 1:NP
        % Selecao da proxima geracao
        if fitness(i) > Offspring_fitness(i)
            x(i,:) = Offspring (i,:);
            fitness(i,1) = Offspring_fitness(i);
        end
    end
    list_Offspring_fitness(index)= mean(Offspring_fitness);
    list_Offspring_fitness_best(index) = min(Offspring_fitness);
    list_Offitness_best(index) = min(fitness);
    index = index+ 1;
end

end


function Offspring = DE(Parent,Param)
% Differental evolution operator

CR = Param.CR;
F = Param.F;

ParentDec    = Parent([1:end,1:ceil(end/3)*3-end],:);
[N,D]     = size(ParentDec);

%% Differental evolution
Parent1Dec   = ParentDec(1:N/3,:);
Parent2Dec   = ParentDec(N/3+1:N/3*2,:);
Parent3Dec   = ParentDec(N/3*2+1:end,:);
OffspringDec = Parent1Dec;

Site = rand(N/3,D) < CR;
OffspringDec(Site) = OffspringDec(Site) + F*(Parent2Dec(Site)-Parent3Dec(Site));

%% Polynomial mutation
Lower = repmat(Param.lbound_x',N/3,1);
Upper = repmat(Param.ubound_x',N/3,1);

%% Repair non-feasible solutions
idx_gt = bsxfun(@gt,OffspringDec,Upper); %Greater than
idx_lt = bsxfun(@lt,OffspringDec,Lower); %	Less than
OffspringDec(idx_gt) =  Upper(idx_gt);
OffspringDec(idx_lt) =  Lower(idx_lt);

Offspring = OffspringDec;

end
