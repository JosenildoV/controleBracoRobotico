arquivo = fopen('dados.txt','w');

%Codigo de comunicacao com as cameras
% [cam1, cam2] = connectStereoCams;
% load('stereoParams.mat')
% stereoParams = quickStereoCalibration(cam1, cam2);
% LAB = getLABColor(cam1, 81);


%Codigo de comunicacao com o robo
s = serial('COM9','Baudrate',9600,'timeout',15); 
fopen(s);

qntd = 10;

[pos1,pos2,pos3,pos4] = gerador(qntd);

fwrite(s, 'S');
disp(fscanf(s));    

a=1;
while(a<=qntd)
    %Parte de envio e recebimento das posicoes para o robo
    disp([pos1(a), pos2(a), pos3(a), pos4(a)]);
    writePosition(s, pos1(a));
    writePosition(s, pos2(a));
    writePosition(s, pos3(a));
    writePosition(s, pos4(a));
    disp(fscanf(s));
%     [motor2, motor3, motor4, motor5] = fscanf(s);
%     [motor2, motor3, motor4, motor5]
    
    %Parte de triangulacao de distancia pelas cameras
%     stat1 = detectLABColor(cam1, LAB);
%     stat2 = detectLABColor(cam2, LAB);
%     vetorPos(a, :) = triangular(stat1, stat2, stereoParams); 
%     debug('b', vetorPos(a, :));
%     debug('w', vetorPos(a, :));
    
    %parte de guardar os dados no arquivo [num motor2 motor3 motor4 motor5 X Y Z]
%     fprintf(arquivo,'%d %f %f %f %f %f %f %f \n', a, pos1(a), pos2(a), pos3(a), pos4(a), vetorPos(a, 1), vetorPos(a, 2), vetorPos(a, 3));
    fprintf(arquivo,'%d %d %d %d %d \n', a, pos1(a), pos2(a), pos3(a), pos4(a));
    
    a = a + 1;
    pause(2);
end

fclose(s);
delete(s);
clear s;
