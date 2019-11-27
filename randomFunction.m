for i = 1:10
    r1 = randi([-90,90],1);
    r2 = randi([0,110],1);
    r3 = randi([-r2,min([150,(160-r2)])]);
    %%round(((rand*2)-1) * min([150,(160-r2)]));
    r4 = randi([max([-90,(-r2-r3)]),min([150,(160-r2-r3)])]);
    %%round(((rand*2)-1) * min([150,(160-r2-r3)]));
    %{
    fprintf('\n  Serial.println("Ordem: %i");\n',i);
    disp(['  SetPosition(2,degree2pos(' int2str(r1) '));'])
    disp('  delay(300);')
    disp(['  SetPosition(3,degree2pos(' int2str(r2) '));'])
    disp('  delay(300);')
    disp(['  SetPosition(4,degree2pos(' int2str(r3) '));'])
    disp('  delay(300);')
    disp(['  SetPosition(5,degree2pos(' int2str(r4) '));'])
    disp('  delay(3000);')
    %}
    fprintf('\n  Serial.println("Ordem: %i");\n',i);
    disp(['  SetPositionExt(2,' int2str(r1) ');'])
    disp(['  SetPositionExt(3,' int2str(r2) ');'])
    disp(['  SetPositionExt(4,' int2str(r3) ');'])
    disp(['  SetPositionExt(5,' int2str(r4) ');'])
    
end;