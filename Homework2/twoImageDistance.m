function result = twoImageDistance(centerImage, centerLabel, currentImage, currentLabel)
    % Calculate the distance between two image
    distance = 0;
    for i = 1:size(centerImage, 2)
        distance = distance + ((centerImage(1,i) - currentImage(1,i)) ^ 2);
    end
    distance = distance + ((centerLabel - currentLabel) ^ 2);
    result = sqrt(distance);
end