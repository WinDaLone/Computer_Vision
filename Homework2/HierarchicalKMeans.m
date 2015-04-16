% Hierarchical K-Means Clustering
% Name: Yunfeng Wei
% CWID: 10394963
% E-mail: ywei14@stevens.edu

% Read Images
trainImg = loadImages('train-images.idx3-ubyte');
trainLabel = loadLabels('train-labels.idx1-ubyte'); % (60000,1)
trainImg = transpose(trainImg); % (60000,784)

% Randomly choose 5 images
base = 5;
r = randperm(size(trainImg,1));
r = r(1:base);

centerImg = zeros(base, size(trainImg,2));
centerLabel = zeros(base, size(trainLabel,2));
prevCenterImg = zeros(size(centerImg));
prevCenterLabel = zeros(size(centerLabel));

for i=1:5
    centerImg(i,:) = trainImg(r(i),:); % (5, 784)
    centerLabel(i,:) = trainLabel(r(i),:); % (5, 1)
end

e = 1;
c = 0;
d = distanceOfCenter(centerImg, centerLabel, prevCenterImg, prevCenterLabel);

while (d > e)
    c = c + 1;
    distance = calculateDistance(trainImg, trainLabel, centerImg, centerLabel);
    minDistance = zeros(size(distance,1),1);
    for i=1:size(distance,1)
        for j=1:size(distance,2)
            if distance(i,j) == min(distance(i,:))
                minDistance(i,1) = j;
            end
        end
    end
    prevCenterImg = centerImg;
    prevCenterLabel = centerLabel;
    
    % Calculate new centerImg
    centerImg = zeros(base, size(trainImg,2));
    centerLabel = zeros(base, size(trainLabel,2));
    count = zeros(base,1);
    for i = 1:size(minDistance,1)
        % find the set it belongs to and add the columns into it
        centerImg(minDistance(i,1),:) = centerImg(minDistance(i,1),:) + trainImg(i,:);
        centerLabel(minDistance(i,1),:) = centerLabel(minDistance(i,1),:) + trainLabel(i,:);
        count(minDistance(i,1)) = count(minDistance(i,1)) + 1;
    end
    
    for i = 1:size(centerImg,1)
        %Calculate the mean value
        for j = 1:size(centerImg,2)
            centerImg(i,j) = centerImg(i,j) / count(i);
        end
        centerLabel(i) = centerLabel(i) / count(i);
    end
    
    d = distanceOfCenter(centerImg, centerLabel, prevCenterImg, prevCenterLabel);
end

firstRoundCenterImg = centerImg;
firstRoundCenterLabel = centerLabel;

firstRoundNumber = zeros(base,1);
for i = 1:base
   for j = 1:size(minDistance,1)
       if minDistance(j,1) == i
           firstRoundNumber(i) = firstRoundNumber(i) + 1;
       end
   end
end

finalCenterImg = zeros(base*base, size(trainImg,2));
finalCenterLabel = zeros(base*base, size(trainLabel,2));
% Next, do sub K-meanst
for i = 1:base
    subTrainImg = zeros(firstRoundNumber(i), size(trainImg, 2));
    subTrainLabel = zeros(firstRoundNumber(i), size(trainLabel, 2));
    k = 1;
    for j=1:size(subTrainImg,1) % j from 1-N
        while k <= size(trainImg,1) % from 1-60000
            if minDistance(k,1) == i
                subTrainImg(j,:) = trainImg(k,:);
                subTrainLabel(j,:) = trainLabel(k,:);
                k = k + 1;
                break;
            end
            k = k + 1;
        end
    end
    
    r = randperm(size(subTrainImg,1));
    r = r(1:base);
    subCenterImg = zeros(base,size(subTrainImg,2));
    subCenterLabel = zeros(base,size(subTrainLabel,2));
    subPrevCenterImg = zeros(size(centerImg));
    subPrevCenterLabel = zeros(size(centerLabel));
    
    for j=1:base
        subCenterImg(j,:) = subTrainImg(r(j),:);
        subCenterLabel(j,:) = subTrainLabel(r(j),:);
    end
    
    e = 2;
    c = 0;
    d = distanceOfCenter(subCenterImg, subCenterLabel, subPrevCenterImg, subPrevCenterLabel);
    
    while (d > e)
        c = c + 1;
        subDistance = calculateDistance(subTrainImg, subTrainLabel,subCenterImg, subCenterLabel);
        subMinDistance = zeros(size(subDistance,1),1);
        for j = 1:size(subDistance,1)
            for k = 1:size(subDistance,2)
                if subDistance(j,k) == min(subDistance(j,:))
                    subMinDistance(j,1) = k;
                end
            end
        end
        
        subPrevCenterImg = subCenterImg;
        subPrevCenterLabel = subCenterLabel;
        
        %Calculate new subCenterImg
        subCenterImg = zeros(base, size(subTrainImg,2));
        subCenterLabel = zeros(base, size(subTrainLabel,2));
        count = zeros(base,1);
        for j=1:size(subMinDistance,1)
            subCenterImg(subMinDistance(j,1),:) = subCenterImg(subMinDistance(j,1),:) + subTrainImg(j,:);
            subCenterLabel(subMinDistance(j,1),:) = subCenterLabel(subMinDistance(j,1),:) + subTrainLabel(j,:);
            count(subMinDistance(j,1)) = count(subMinDistance(j,1)) + 1;
        end
        
        for j =1:size(subCenterImg,1)
            for k=1:size(subCenterImg,2)
                subCenterImg(j,k) = subCenterImg(j,k) / count(j);
            end
            subCenterLabel(j) = subCenterLabel(j) / count(j);
        end
        
        d = distanceOfCenter(subCenterImg, subCenterLabel, subPrevCenterImg, subPrevCenterLabel);
        
    end
    
    for temp=1:base
        finalCenterImg((i-1)*base+temp,:) = subCenterImg(temp,:);
        finalCenterLabel((i-1)*base+temp,:) = subCenterLabel(temp,:);
    end
end


dlmwrite('HierarchicalKMeansCenterImage.txt', (finalCenterImg), ';');
dlmwrite('HierarchicalKMeansCenterLabel.txt', (finalCenterLabel), ';');

    


