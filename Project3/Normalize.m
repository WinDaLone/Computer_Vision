function [res, T] = Normalize(x) % Nx3
    x = x';
    % Find the indices
    ind = find(abs(x(3,:)) > eps);
    
    x(1, ind) = x(1, ind) ./ x(3, ind);
    x(2, ind) = x(2, ind) ./ x(3, ind);
    x(3, ind) = 1;
    
    % Calculate the mean value of the points pair
    c = mean(x(1:2, ind));
    % Shift the origin to centroid
    temp(1, ind) = x(1, ind) - c(1);
    temp(2, ind) = x(2, ind) - c(2);
    
    % Calculate the distance of each point
    dist = sqrt(temp(1,ind).^2 + temp(2,ind).^2);
    meanDist = mean(dist(:));
    
    % Calculate the scale
    scale = 2 / meanDist;
    
    T = [scale, 0, -scale*c(1); 0, scale, -scale*c(2); 0, 0, 1];
    res = T * x;
    res = res';
end