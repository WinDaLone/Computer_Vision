% K-Means Clustering
% Name: Yunfeng Wei
% CWID: 10394963
% E-mail: ywei14@stevens.edu

% Read images
trainImg = loadImages('train-images.idx3-ubyte');
trainLabel = loadLabels('train-labels.idx1-ubyte');
trainImg = transpose(trainImg);

% Randomly choose 25 image
base = 25;
r = randperm(size(trainImg,1));
r = r(1:base);
centerImg = zeros(base, size(trainImg,2));
centerLabel = zeros(base, size(trainLabel, 2));
prevCenterImg = zeros(size(centerImg));
prevCenterLabel = zeros(size(centerLabel));

for i = 1:base
    centerImg(i,:) = trainImg(r(i),:);
    centerLabel(i,:) = trainLabel(r(i),:);
end

e = 2;
c = 0;
d = distanceOfCenter(centerImg, centerLabel, prevCenterImg, prevCenterLabel);

while (d > e)
    c = c + 1;
    distance = calculateDistance(trainImg, trainLabel, centerImg, centerLabel);
    minDistance = zeros(size(distance,1),1);
    for i = 1:size(distance,1)
        for j = 1:size(distance,2)
            if distance(i,j) == min(distance(i,:))
                minDistance(i,1) = j;
            end
        end
    end
    prevCenterImg = centerImg;
    prevCenterLabel = centerLabel;
    
    % Calculate new centerImg
    centerImg = zeros(base, size(trainImg, 2)); % centerImg 25 x 784
    centerLabel = zeros(base, size(trainLabel, 2)); % centerLabel 25 x 1
    count = zeros(base, 1);
    for i = 1:size(minDistance, 1)
        % find the set it belongs to and add the columns into it
        centerImg(minDistance(i,1),:) = centerImg(minDistance(i,1),:) + trainImg(i,:);
        centerLabel(minDistance(i,1),:) = centerLabel(minDistance(i,1),:) + trainLabel(i,:);
        count(minDistance(i,1)) = count(minDistance(i,1)) + 1;
    end

    for i = 1:size(centerImg,1)
        % Calculate the mean value
        for j = 1:size(centerImg,2)
            centerImg(i,j) = centerImg(i,j) / count(i);
        end
        centerLabel(i) = centerLabel(i) / count(i); % Problem
    end
    d = distanceOfCenter(centerImg, centerLabel, prevCenterImg, prevCenterLabel);
end

finalCenterImg = centerImg;
finalCenterLabel = centerLabel;

dlmwrite('KMeansCenterImage.txt', (finalCenterImg), ';');
dlmwrite('KMeansCenterLabel.txt', (finalCenterLabel), ';');