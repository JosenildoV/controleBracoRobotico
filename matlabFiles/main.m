
% Salvar arquivos da posi??o
adress = '';
nome_arq = strcat(adress, 'dados.txt');
id_arq = fopen(nome_arq, 'wt');

%
% As cameras s?o sens?veis, n?o se desconectam facilmente.
%
%%
% PASSO O: Conectar as c?meras e ver seu estado.
%[cam1, cam2] = connectStereoCams;

%
% Recebe os par?metros da C?mera que ser?o utilizados em fun??o que ir?
% retornar a dist?ncia da c?mera para a da cor-objetivo na tela.
%

%%
% PASSO P: Calibrar a c?mera que pode estar em posi??o alterada.
%load('stereoParams.mat')
%stereoParams = quickStereoCalibration(cam1, cam2);

%
% Recebe os par?metros da C?mera que ser?o utilizados em fun??o que ir?
% retornar a dist?ncia da c?mera para a da cor-objetivo na tela.
%

%%
% PASSO N: Use getHSVColor(path) para estimar a m?dia do valor de HSV.
%LAB = getLABColor(cam1, 81);

%MATLAB Code for Serial Communication between Arduino and MATLAB
s = serial('COM9','Baudrate',9600, 'timeout',60); 
fopen(s);

% Quantidade de posicoes geradas
quant = 10;

% Gerar posições aleatorias
[pos1,pos2,pos3,pos4] = gerador(quant);

%fscanf(s)

a=1;
while(a<quant)
    disp([pos1(a),pos2(a),pos3(a),pos4(a)]);
    writePosition(s, pos1(a));
    %writePosition(s, pos2(a));
    %writePosition(s, pos3(a));
    %writePosition(s, pos4(a));

    a = a + 1;

    disp(fscanf(s));
    pause(2);
    
    
    %%
    % PASSO M: Use a m?dia de cada cor para detec??o na imagem passada e passe
    % para fun??o colorDetectHSV(imagem, corLab)
%     stat1 = detectLABColor(cam1, LAB);
%     stat2 = detectLABColor(cam2, LAB);
    %
    % Ao fim, ser? repassada a posi??o relativa de cada cor em uma matriz, onde
    % linha M ? cada uma das posi??es da cor, em ordem de ?rea, e cada coluna N
    % ? uma posi??o no plano cartesiano X, Y, Z, no quarto quadrante, apenas Z
    % positivo.
    %
    
    %%
    % PASSO K: Verificar consist?ncia e s? depois disso, triangular.

%     vetorPos(a, :) = triangular(stat1, stat2, stereoParams);
% 
%     debug('b', vetorPos(a, :));       %apenas debug.REMOVER
%     debug('w', vetorPos(a, :));       %apenas debug.REMOVER
    
    %
    % Faz algumas checagens para ver se t? tudo ok, para ent?o retornar uma
    % posi??o X, Y e Z v?lida.
    %

    %%
    % PASSO V: Guardar em arquivo que ser? enviado a Ardu?no
%     fprintf(id_arq, '%d %f %f %f \n', a, vetorPos(a, 1), vetorPos(a, 2), vetorPos(a, 3));
%     if ~(vetorPos(a, 1) ==0 && vetorPos(a, 2) ==0 && vetorPos(a, 3)==0)
%         [vetorPos(a, 1), vetorPos(a, 2), vetorPos(a, 3)]
%     end
%     
    
end 

fclose(s);
delete(s);
clear s;
