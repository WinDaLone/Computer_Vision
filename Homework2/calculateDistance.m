function result = calculateDistance(trainImg, trainLabel, centerImg, centerLabel)
    % Calculate the distance
    result = zeros(size(trainImg,1), size(centerImg,1)); % 60000x25
    for i=1:size(centerImg,1) % from 1 - 25
        for j = 1:size(trainImg, 1) % from 1 - 60000
            currentImg = trainImg(j,:);
            currentLabel = trainLabel(j,:);
            distance = twoImageDistance(centerImg(i,:), centerLabel(i,:), currentImg, currentLabel);
            result(j,i) = distance;
        end
    end
end
    