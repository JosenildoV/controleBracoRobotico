%MATLAB Code for Serial Communication between Arduino and MATLAB

s = serial('COM9','Baudrate',9600,'timeout',15); 
fopen(s);

quant = 10;

[pos1,pos2,pos3,pos4] = gerador(quant);

fwrite(s, 'S');
disp(fscanf(s));    

a=1;
while(a<=quant)
    disp([pos1(a), pos2(a), pos3(a), pos4(a)]);
    writePosition(s, pos1(a));
    writePosition(s, pos2(a));
    writePosition(s, pos3(a));
    writePosition(s, pos4(a));
    a = a + 1;
    
    disp(fscanf(s));
    pause(5);
end 

fclose(s);
delete(s);
clear s;
