function erro = ident_problem(x)

global saida entrada tout
%Função de transferência da planta
syst = tf([x(1) x(2) x(3)],[x(4) x(5) x(6) x(7)]);
disp(x);
disp(syst);
disp(entrada);
disp(tout);
y = lsim(syst,entrada,tout);

erro = (sum((saida-y).^2))^(1/2);

end