function res = CornerDetector(img)
img = im2double(img);
% Input image
threshold = 0.05; % Initialize the threshold
a = 0.04; % Initialize alpha as 0.04
sigma = 1; % Initialize sigma as 1
N = sigma * 3; % Define the Gaussian window

[u, v] = meshgrid(-N:N, -N:N); % Initialize u and v

w = exp(-(u .^ 2 + v .^ 2) / (2 * sigma^2)); % Calculate the Gaussian

% Calculate the first gradients of the image
m = [-1,0,1];
tmpX = conv2(m, img);
tmpY = conv2(transpose(m), img);
X = zeros(size(img,1), size(img,2));
Y = zeros(size(img,1), size(img,2));
for i=1:size(img,1)
    for j=1:size(img,2)
        X(i,j) = tmpX(i,j+1);
        Y(i,j) = tmpY(i+1, j);
    end
end

% Calculate each argument of E(x,y)
A = conv2(w, X .^ 2);
B = conv2(w, Y .^ 2);
C = conv2(w, X .* Y);

res = zeros(size(img,1), size(img,2));
temp = zeros(size(img,1), size(img,2));
for i=1:size(res,1)
    for j=1:size(res,2)
        % Define the matrix M around each pixel
        M = [A(i,j) C(i,j); C(i,j) B(i,j)];
        
        % Computer the response function R
        R = det(M) - a * (trace(M) ^ 2);
        temp(i,j) = R;
        % Threshold R
        if (R > threshold)
            res(i,j) = R;
        end
    end
end

% Find local maxima of response function
out = res > imdilate(res, [1 1 1;1 0 1;1 1 1]);

res = out;
end