% Project #3
% Name: Yunfeng Wei
% CWID: 10394963
% E-mail: ywei14@stevens.edu

% Load images
imgLeft = imread('uttower_left.JPG');
imgRight = imread('uttower_right.JPG');
imgLeft = rgb2gray(imgLeft);
imgRight = rgb2gray(imgRight);

% Find the corner coordinate
imgLeftDot = CornerDetector(imgLeft); 
imgRightDot = CornerDetector(imgRight);

count = CalculateCount(imgLeftDot); % Calculate the total number of the corners
descriptorLeft = zeros(25, count, 'uint8');
positionLeft = zeros(3, count, 'uint16');
current = 1;
for i = 1:size(imgLeftDot,1)
    for j = 1:size(imgLeftDot,2)
        if imgLeftDot(i,j) == 1
            % Extract 5x5 image patches
            % Set the descriptor for the each corner point
            descriptorLeft(:,current) = SetDescriptor(imgLeft, i, j);
            % Store its corrdinate
            positionLeft(1,current) = i;
            positionLeft(2,current) = j;
            positionLeft(3,current) = 1;
            current = current + 1;
        end
    end
end

count = CalculateCount(imgRightDot);
descriptorRight = zeros(25, count, 'uint8');
positionRight = zeros(3, count,'uint16');
current = 1;
for i = 1:size(imgRightDot,1)
    for j = 1:size(imgRightDot,2)
        if imgRightDot(i,j) == 1
            % Extract 5x5 image patches
            % Set the descriptor for the each corner point
            descriptorRight(:,current) = SetDescriptor(imgRight, i, j);
            % Store its corrdinate
            positionRight(1,current) = i;
            positionRight(2,current) = j;
            positionRight(3,current) = 1;
            current = current + 1;
        end
    end
end

normCorl = zeros(size(descriptorLeft,2), size(descriptorRight,2));
count = 0;
for i = 1:size(descriptorLeft,2)
    for j = 1:size(descriptorRight,2)
        % Calculate the normalized correlation in the range [-1, 1]
        % between one image and the other image.
        normCorl(i,j) = NormalizedCorrelation(descriptorLeft(:,i), descriptorRight(:,j));
        if normCorl(i,j) > 1
            count = count + 1;
        end
    end
end

% Select the top descriptor pairs with the largest normalized correlation
% values
pairs = zeros(size(normCorl,1),1);
for i = 1:size(normCorl,1)
    temp = -1;
    for j = 1:size(normCorl,2)
        if normCorl(i,j) > temp
            temp = normCorl(i,j);
            pairs(i,1) = j;
        end
    end
end

positionLeft = double(positionLeft);
positionRight = double(positionRight);

base = 8; % select eight points
count = 0;
finalCount = count;
F = zeros(3,3,'double'); % Initialize F
finalF = F;
N = 1; % Initialize Number of samples
sample_count = 0; % Initialize current loop times
p = 0.9; % Initialize probability for inlier

while N > sample_count
    % Randomly choose 8 points
    r = randperm(size(normCorl,1)); % 1-807
    r = r(1:base);
    x = zeros(base,3); % 8 * 3
    y = zeros(base,3); % 8 * 3
    for i = 1:base
        x(i,1) = positionLeft(1,r(i));
        x(i,2) = positionLeft(2,r(i));
        x(i,3) = positionLeft(3,r(i));
        temp = pairs(r(i));
        y(i,1) = positionRight(1,temp);
        y(i,2) = positionRight(2,temp);
        y(i,3) = positionRight(3,temp);
    end
    % Normalized X so that the mean squared distance between the
    % origin and the data points is 2 pixels
    [newX, Tx] = Normalize(x); 
    [newY, Ty] = Normalize(y);
    % Use eight-point algorithm to compute F
    % and enforce the rank-2 constraint
    F = EightPoint(newX,newY);
    % Transfrom F back to original units
    F = Tx' * F * Ty;
    
    % Calculate the error as threshold
    error = 0;
    x = double(x);
    y = double(y);
    for i = 1:base
        value = (x(i,:) * F * transpose(y(i,:))) ^ 2;
        error = error + value;
    end
    
    % For each point pairs, calculate if error is smaller than threshold
    % If true, increment count by 1
    count = 0;
    value = 0;
    for i = 1:size(normCorl,1)
        pointX = [positionLeft(1,i), positionLeft(2,i), 1];
        temp = pairs(i);
        pointY = [positionRight(1,temp), positionRight(2,temp), 1];
        pointX = double(pointX);
        pointY = double(pointY);
        value = pointX * F * transpose(pointY);
        value = value ^ 2;
        if (value < error)
            count = count + 1;
        end
    end
    % If the inliner number is the greatest, set current F
    % as the finalF
    if (count > finalCount)
        finalCount = count;
        finalF = F;
    end
    % Calculate the outlier ratio
    e = 1 - count / size(normCorl,1);
    % Calculate the samples number
    N = log(1-p) / log(1-(1-e)^base);
    % Increment current loop times by 1
    sample_count = sample_count + 1;
end

% This is the final fundamental matrix for these two images
fundMatrix = finalF;