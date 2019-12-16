%Algoritmo de teste

% load('melhorIndividuo.mat')

T_stop = 100;
tout = 0:.1:T_stop;

C = eye(3);

A = [melhorIndividuo(1) melhorIndividuo(2) melhorIndividuo(3)
    melhorIndividuo(4) melhorIndividuo(5) melhorIndividuo(6)
    melhorIndividuo(7) melhorIndividuo(8) melhorIndividuo(9)];

B = [melhorIndividuo(10) melhorIndividuo(11) melhorIndividuo(12) melhorIndividuo(13)
    melhorIndividuo(14) melhorIndividuo(15) melhorIndividuo(16) melhorIndividuo(17)
    melhorIndividuo(18) melhorIndividuo(19) melhorIndividuo(20) melhorIndividuo(21)];

systTest = ss(A,B,C,0);

saidaEstimada = [];
difTest = [];
for i = 1:length(entrada)
    entr = entrada(i,:);

    ysim = lsim(systTest, repmat(entr,length(tout),1), tout);
    dif = sqrt(sum((ysim(length(tout),:) - saida(i,:)) .^2));
%     ysim(length(tout),:)

    saidaEstimada = [saidaEstimada ysim(length(tout),:)'];
    difTest = [difTest dif];
end
saidaEstimadaInvert = saidaEstimada';
comp = [saida saidaEstimadaInvert difTest'];
mean(difTest')
% saveas(saidaEstimadaInvert,['comp' '.txt']);
