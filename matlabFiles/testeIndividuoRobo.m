%Algoritmo de teste

load('melhorIndividuo.mat')
load('entradaSaida.mat')
load('dados.mat')

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

entr = [0 0 80 80];

%Codigo de comunicacao com as cameras
[cam1, cam2] = connectStereoCams;
load('stereoParams.mat');


%Codigo de comunicacao com o robo
 s = serial('COM9','Baudrate',9600,'timeout',15); 
 fopen(s);
 
fwrite(s, 'S');
disp(fscanf(s));

%Comando para ir � posicao para pegar a cor
fwrite(s,'i','uchar');
pause(5);

%Pegar cor base
% stereoParams = quickStereoCalibration(cam1, cam2);
 LAB = getLABColor(cam1, 81);

 
%  fprintf('Dado numero: %d \n',a);
 disp(entr);
 writePosition(s, entr(1));
 writePosition(s, entr(2));
 writePosition(s, entr(3));
 writePosition(s, entr(4));
 disp(fscanf(s));

pause(2);
for a = 1:1
    %Parte de triangulacao de distancia pelas cameras
     stat1 = detectLABColor(cam1, LAB);
     stat2 = detectLABColor(cam2, LAB);
     vetorPos = triangular(stat1, stat2, stereoParams); 
     debug('b', vetorPos);
     debug('w', vetorPos);

    %parte de guardar os dados no arquivo [num motor2 motor3 motor4 motor5 X Y Z]
     fprintf('%d %d %d %d %f %f %f \n', entr(1), entr(2), entr(3), entr(4), vetorPos(1), vetorPos(2), vetorPos(3));
%     fprintf(arquivo,'%d %d %d %d %d \n', a, pos1(a), pos2(a), pos3(a), pos4(a));
    pause(1);
end
pause(2);
 

ysim = lsim(systTest, repmat(entr,length(tout),1), tout);
ysim(length(ysim),:)
clearSerialPort();
% dif = sqrt(sum((ysim(length(tout),:) - saida(i,:)) .^2));
%     ysim(length(tout),:)
% 
% saidaEstimada = [saidaEstimada ysim(length(tout),:)'];
% difTest = [difTest dif];
% 
% 
% saidaEstimadaInvert = saidaEstimada';
% comp = [saida saidaEstimadaInvert difTest'];
% 
% saidaEstimadaX = saidaEstimadaInvert(:,1);
% saidaEstimadaY = saidaEstimadaInvert(:,2);
% saidaEstimadaZ = saidaEstimadaInvert(:,3);
% 
% erroX = saidaX - saidaEstimadaX;
% erroY = saidaY - saidaEstimadaY;
% erroZ = saidaZ - saidaEstimadaZ;
% 
% diffMotor2 = motor2 - motor2(constt);
% diffMotor3 = motor3 - motor3(constt);
% diffMotor4 = motor4 - motor4(constt);
% diffMotor5 = motor5 - motor5(constt);

% saveas(saidaEstimadaInvert,['comp' '.txt']);
