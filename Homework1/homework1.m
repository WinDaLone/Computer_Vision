% Load the sample data
newData1 = load('linear_regression.mat', '-mat');

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end
% Load ended

% because the original trainY is 1 x 4649, transpose it to be a 4649 x 1 vector
trainY = trainY';

aveX = zeros(1, size(trainX, 2)); % Define a 1 * 256 vector called aveX
% Store the average value of X into the aveX
for i = 1 : size(trainX, 1) % sum all 4649 values
    aveX = aveX + trainX(i,:);
end
aveX = aveX / size(trainX, 1); % divide 4649 to calculate the average value

X = zeros(size(trainX, 1), size(trainX, 2)); % Define the data matrix
% Calculate the data matrix
for i = 1 : size(trainX, 1) % calculate each row
    X(i,:) = trainX(i,:) - aveX;
end

aveY = zeros(1, size(trainY, 2)); % Define a variable called aveY
% Store the average value of y into aveY
for i = 1:size(trainY, 1)
    aveY = aveY + trainY(i,:);
end
aveY = aveY / size(trainY, 1);

Y = zeros(size(trainY, 1), size(trainY, 2)); % Define the response vector called Y
% Calculate the response vector
for i = 1:size(trainY, 1)
    Y(i,:) = trainY(i,:) - aveY;
end

% Calculate the unique global optimum
% Store the value into w
w = inv(X' * X) * X' * Y;

% Calculate b and store it into b
b = zeros(1, 1);
for i = 1:size(trainY, 1)
    b = b + w' * trainX(i,:)' - trainY(i,:);
end
b = -b/size(trainY, 1);

%Test the data
testAns = zeros(size(testX, 1), 1);
for i = 1:size(testX, 1)
    testAns(i, 1) = w' * (testX(i, :))' + b;
end

testRes = uint8(testAns);
% For any value which is greater than 10, set to 10; any value which is
% smaller than 0, set to 0;
for i = 1:size(testX, 1)
    if testRes(i,1) >= 10
        testRes(i,1) = 10;
    elseif testRes(i,1) <= 0
        testRes(i,1) = 0;
    end
end

% Write the testY into 'testY.txt'
dlmwrite('testY.txt', (testRes), ';');
