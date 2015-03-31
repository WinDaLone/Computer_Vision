% Project 1
% Name: Yunfeng Wei
% CWID: 10394963

% Read the foreground and background images
bgI = imread('background.png');
fgI = imread('foreground.png');

frequency = 50; % The frequency for the foreground gaussian filter
frequency_back = 10; % The frequency for the background gaussian filter

% Create the gaussian filter
fGaus = fspecial('gaussian', frequency*4+1, frequency);
bGaus = fspecial('gaussian', frequency_back*4+1, frequency_back);

% Gaussian for background image
bgFilterI = imfilter(bgI, bGaus, 'replicate');

% Laplacian for foreground image (original image minus the low-pass
% filtered image)
fgFilterI = fgI - imfilter(fgI, fGaus, 'replicate');

% Change the size of the foreground image to be the same as the background image.
fgNewFilterI = uint8(zeros(946,1266,3));
for i=1:3
    for j=1:1266
        for k=1:944
            fgNewFilterI(k,j,i)=fgFilterI(k,j,i);
        end
    end
end

% Add two filtered image together
finalImg = fgNewFilterI + bgFilterI;

% Show the image
figure('name','Foreground Filtered Image');
imshow(fgNewFilterI);
figure('name','Background Filtered Image');
imshow(bgFilterI);
figure('name','Hybrid Image');
imshow(finalImg);