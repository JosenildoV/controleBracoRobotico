function [position] = writePosition(serialObject, goalPos)

    fwrite(serialObject, abs(goalPos), 'int8');
    
end