function res = EightPoint(x, y) % x: 8x3 y: 8x3
    x = double(x);
    y = double(y);
    
    M = zeros(8,8,'double');
    I = zeros(8,1,'double');
    for i = 1:8
        I(i,1) = 1;
    end
    % Calculate M
    for i = 1:8
        M(i,1) = x(i,1) * y(i,1);
        M(i,2) = x(i,1) * y(i,2);
        M(i,3) = x(i,1);
        M(i,4) = x(i,2) * y(i,1);
        M(i,5) = x(i,2) * y(i,2);
        M(i,6) = x(i,2);
        M(i,7) = y(i,1);
        M(i,8) = y(i,2);
    end
    
    
    F = -M \ I;
    finalF = zeros(3,3);
    finalF(1,1) = F(1,1);
    finalF(1,2) = F(2,1);
    finalF(1,3) = F(3,1);
    finalF(2,1) = F(4,1);
    finalF(2,2) = F(5,1);
    finalF(2,3) = F(6,1);
    finalF(3,1) = F(7,1);
    finalF(3,2) = F(8,1);
    finalF(3,3) = 1;
    
    % Take SVD of finalF and throw out the smallest singular value
    [U,D,V] = svd(finalF,0);
    res = U * diag([D(1,1) D(2,2) 0]) * V';
    
end