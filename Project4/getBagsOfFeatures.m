function res = getBagsOfFeatures(src, dir, C)
    for i = 1:length(src)
        filename = strcat(dir, src(i).name);
        I = imread(filename);
        [rows columns numberOfColorChannels] = size(I);
        if (numberOfColorChannels == 3)
            I = rgb2gray(I);
        end
        I = im2double(I);
        % Feature Extraction
        % Get the corner position
        position = corner(I, 'Harris', 'SensitivityFactor', 0.02);
        positionCount = size(position,1);
        % end
        % Feature Description
        for j = 1:positionCount
            descriptor = SetDescriptor(I, position(j,2), position(j,1));
            descriptor = descriptor';
            tmpFeature(j) = getBags(descriptor, C);
        end
        feature = zeros(1, size(C,1));
        for j = 1:length(tmpFeature)
            k = tmpFeature(j);
            feature(1,k) = feature(1,k) + 1;
        end
        feature = normalizeFeature(feature);
        features(i,:) = feature;
        clear descriptor
    end
    res = features;
end