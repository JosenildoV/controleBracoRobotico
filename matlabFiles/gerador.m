function [motor2,motor3,motor4,motor5] = gerador(num)
    for i = 1:num
        motor2(i) = randi([-90,90],1);
        motor3(i) = randi([0,110],1);
        if motor3(i) <= 90
            motor4(i) = randi([-motor3(i),min([150,(150-motor3(i))])]);
            motor5(i) = randi([max([-90,(-motor3(i)-motor4(i))]),min([110,(150-motor3(i)-motor4(i))])]);
            
        else
            motor4(i) = randi([-motor3(i),min([150,(150-motor3(i)-(3*(motor3(i)-90)))])]);
            motor5(i) = randi([max([-90,(-motor3(i)-motor4(i))]),min([110,(150-motor3(i)-motor4(i)-(3*(motor3(i)-90)))])]);
        end
        %[motor2(i),motor3(i),motor4(i),motor5(i)]
        
        %fprintf('  Serial.println("     Ordem: %i");\n',i);
        %disp(['  SetPositionMulti(' int2str(r1) ',' int2str(r2) ',' int2str(r3) ',' int2str(r4) ', 0);']);

    end
    
end