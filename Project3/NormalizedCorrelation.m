function res = NormalizedCorrelation(x, y) % 25 x 1
    x = double(x);
    y = double(y);
    up = dot(x,y); % Calculate x (dot product) y
    normX = norm(x,2);
    normY = norm(y,2);
    down = normX * normY; % Calculate ||x||*||y||
    res = up / down; % Calculate the normalized correlation
end