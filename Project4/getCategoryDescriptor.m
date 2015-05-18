function descriptor = getCategoryDescriptor(src, dir)
    count = 1;
    for a = 1:length(src)
        filename = strcat(dir, src(a).name);
        I = imread(filename);
        [rows, columns, numberOfColorChannels] = size(I);
        if numberOfColorChannels == 3
            I = rgb2gray(I);
        end
        I = im2double(I);
        % Feature Extraction
        % Get the corner position
        %position = corner(I, 'Harris', 'SensitivityFactor', 0.02);
        position = corner(I, 'Harris');
        positionCount = size(position,1);
        % end
        % Feature Description
        for i = 1:positionCount
            descriptor(:,count) = SetDescriptor(I, position(i,2), position(i,1));
            count = count + 1;
        end
    end
    descriptor = descriptor';
end