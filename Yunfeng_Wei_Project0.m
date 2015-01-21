I = imread('/Users/wyf920621/Documents/Computer_Vision/TEST.jpg');
imshow(I);
comp = zeros(size(I));
for i = 1: size(I, 1)
    for j = 1: size(I, 2)
        comp(i, j, 1) = I(i, j, 1);
        %%comp(i, j, 2) = I(i, j, 2);
        %%comp(i, j, 3) = I(i, j, 3);
    end
end
%%imshow(comp);