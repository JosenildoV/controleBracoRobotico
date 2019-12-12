function normalized = normal(array)

    %maxA = max(array);
    %minA = abs(min(array));
    %maxA = max(maxA, minA);
    %normalized = array/maxA;
    normalized = 2*((array-min(array))/(max(array)-min(array))) -1;

end