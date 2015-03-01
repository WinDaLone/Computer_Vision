% Load the sample data
newData1 = load('linear_regression.mat', '-mat');

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end
% Load ended

aveX = zeros(1, 256);
for i = 1 : size(trainX, 1)
    aveX = aveX + trainX(i,:);
end

aveX = aveX / 256;
X = zeros(4649, 256);
for i = 1 : 4649
    X(i,:) = trainX(i,:) - aveX;
end

aveY = zeros(1, 1);
for i = 1:size(trainY, 2)
    aveY = aveY + trainY(1, i);
end
aveY = aveY / 4649;

Y = zeros(4649, 1);
for i = 1:4649
    Y(i,1) = trainY(1,i) - aveY;
end

w = inv(X' * X) * X' * Y;
b = zeros(1, 1);
for i = 1:4649
    b = b + w' * trainX(i,:)' - trainY(1,i);
end
b = -b/4649;

%Test the data
testAns = zeros(4649, 1);
for i = 1:4649
    testAns(i, 1) = w' * (testX(i, :))' + b;
end

testRes = uint8(testAns);
for i = 1:4649
    if testRes(i,1) >= 10
        testRes(i,1) = 10;
    elseif testRes(i,1) <= 0
        testRes(i,1) = 0;
    end
end

dlmwrite('test_data_out.out', testRes, ';');
type test_data_out.out

