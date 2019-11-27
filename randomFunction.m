for i = 1:50
    r1 = randi([-90,90],1);
    r2 = randi([0,110],1);
    r3 = randi([-r2,min([150,(160-r2)])]);
    r4 = randi([max([-90,(-r2-r3)]),min([110,(160-r2-r3)])]);
   
    fprintf('  Serial.println("     Ordem: %i");\n',i);
    disp(['  SetPositionMulti(' int2str(r1) ',' int2str(r2) ',' int2str(r3) ',' int2str(r4) ', 0);']);
    
end