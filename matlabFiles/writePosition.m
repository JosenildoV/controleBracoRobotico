function [signalPos,pos1,pos2] = writePosition(serialObject, goalPos)

    %   signalPos = 0 -> numero negativo  || signalPos = 1 -> numero positivo/zero
    if(goalPos < 0)
        signalPos = 1;
    else
        signalPos = 0;
    end
    
    % posGoalPos -> posição em números positivos
    posGoalPos = abs(goalPos);

    % pos1 -> será modulo da posição por 256
    pos1 = mod(posGoalPos,256);
    % pos2 -> será a divisão da posição por 256
    pos2 = floor(posGoalPos/256);
    %depois para juntar novamente será ((pos2 * 256) + pos1) * signalPos

    fwrite(serialObject, signalPos, 'int8');
    fwrite(serialObject, pos1, 'int8');
    fwrite(serialObject, pos2, 'int8');
    
end