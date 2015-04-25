function res = CalculateCount(logImg)
    res = 0;
    for i = 1:size(logImg,1)
        for j = 1:size(logImg,2)
            if logImg(i,j) == 1
                res = res + 1;
            end
        end
    end
end