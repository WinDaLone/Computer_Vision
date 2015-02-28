%% Project0
%% Student: Yunfeng Wei
%% CWID: 10394963

% Load the color JPEG image from the directory into a 3D array
I = imread('SOURCE.jpg');
figure('name', 'Origin Image'); % Create Figure 1
imshow(I); % Display the image in Figure 1 on the screen

% Create a 3D array with the same size as the color image, set all elements
% to zero -- this array will contain the RED components from the input
% image
comp1 = zeros(size(I));

for i = 1: size(I, 1) % Loop each row
    for j = 1: size(I, 2) % Loop each column
        % Assign the RED components from the input image to the
        % corresponding entry in the 3D array "comp" and keep the elements
        % of the other two components to be zero
        comp1(i, j, 1) = I(i, j, 1);
    end
end

figure('name', 'RED COMPONENTS'); % Create Figure 2
% Display the "comp1" image in Figure 2 on the screen
imshow(comp1);

% Create a 3D array with the same size as the color image, set all elements
% to zero -- this array will contain the GREEN components from the input
% image
comp2 = zeros(size(I));

for i = 1: size(I, 1) % Loop each row
    for j = 1: size(I, 2) % Loop each column
        % Assign the GREEN components from the input image to the
        % corresponding entry in the 3D array "comp" and keep the elements
        % of the other two components to be zero
        comp2(i, j, 2) = I(i, j, 2);
    end
end

figure('name', 'GREEN COMPONENTS'); % Create Figure 3
% Display the "comp2" image in Figure 3 on the screen
imshow(comp2);


% Create a 3D array with the same size as the color image, set all elements
% to zero -- this array will contain the BLUE components from the input
% image
comp3 = zeros(size(I));

for i = 1: size(I, 1) % Loop each row
    for j = 1: size(I, 2) % Loop each column
        % Assign the BLUE components from the input image to the
        % corresponding entry in the 3D array "comp3" and keep the elements
        % of the other two components to be zero
        comp3(i, j, 3) = I(i, j, 3);
    end
end

figure('name', 'BLUE COMPONENTS'); % Create Figure 4
% Display the "comp3" image in Figure 4 on the screen
imshow(comp3);