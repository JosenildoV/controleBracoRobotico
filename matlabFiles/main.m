%MATLAB Code for Serial Communication between Arduino and MATLAB

s = serial('COM9','Baudrate',9600); 
fopen(s);

[pos1,pos2,pos3,pos4] = gerador(10);

fscanf(s)

a=1;
while(a<=10)
    fwrite(s, abs(pos1(a)), 'int8');
    fwrite(s, abs(pos2(a)), 'int8');
    fwrite(s, abs(pos3(a)), 'int8');
    fwrite(s, abs(pos4(a)), 'int8');
    a = a + 1;
    
    fscanf(s)
    pause(1);
end 

fclose(s);
delete(s);
clear s;
