function result = distanceOfCenter(centerImg, centerLabel, prevCenterImg, prevCenterLabel)
    distance = 0;
    for i = 1:size(centerImg,1)
        for j = 1:size(centerImg,2)
            distance = distance + (centerImg(i,j) - prevCenterImg(i,j)) ^ 2;
        end
        distance = distance + (centerLabel(i) - prevCenterLabel(i)) ^ 2;
    end
    result = sqrt(distance);
end