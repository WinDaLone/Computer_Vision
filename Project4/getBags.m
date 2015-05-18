function res = getBags(descriptor, center)
    min = 0;
    minDist = 10; % max = 5
    for i = 1:size(center, 1)
        dist = norm(descriptor - center(i,:));
        if (dist < minDist)
            min = i;
            minDist = dist;
        end
    end
    res = min;
end