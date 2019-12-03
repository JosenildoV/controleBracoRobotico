%MATLAB Code for Serial Communication between Arduino and MATLAB

s = serial('COM9','Baudrate',9600); 
fopen(s);

[pos1,pos2,pos3,pos4] = gerador(10);

fscanf(s)

a=1;
while(a<=10)
    writePosition(s, pos1(a));
    writePosition(s, pos2(a));
    writePosition(s, pos3(a));
    writePosition(s, pos4(a));

    a = a + 1;
    
    fscanf(s)
    pause(1);
end 

fclose(s);
delete(s);
clear s;
