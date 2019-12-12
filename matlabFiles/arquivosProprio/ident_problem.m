function erro = ident_problem(x)

global saida entrada tout

C = eye(3);

A = [x(1) x(2) x(3)
    x(4) x(5) x(6)
    x(7) x(8) x(9)];

B = [x(10) x(11) x(12) x(13)
    x(14) x(15) x(16) x(17)
    x(18) x(19) x(20) x(21)];

%Função de transferência da simulacao
syst = ss(A,B,C,0);
%disp(syst.InputGroup);
a=0;
while(a<length(entrada))
%     disp(a);
    a=a+1;
    ent = entrada(a,:);
    ysim = lsim(syst, repmat(ent,length(tout),1), tout);
    dif(a) = sqrt(sum((ysim(length(tout),:) - saida(a,:)) .^2));
end

erro = mean(dif);
end