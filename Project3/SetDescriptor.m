function res = SetDescriptor(img, i, j)
    % Find the 5x5 patch and set the 25x1 descriptor for the point
    res = zeros(25,1);
    row = size(img,1);
    col = size(img,2);
    if i > 2 && j > 2
        res(1,1) = img(i-2,j-2);
    else
        res(1,1) = 0;
    end
    if i > 2 && j > 1
        res(2,1) = img(i-2,j-1);
    else
        res(2,1) = 0;
    end
    if i > 2
        res(3,1) = img(i-2,j);
    else
        res(3,1) = 0;
    end
    
    if i > 2 && j < col
        res(4,1) = img(i-2,j+1);
    else
        res(4,1) = 0;
    end
    if i > 2 && j < col - 1
        res(5,1) = img(i-2,j+2);
    else
        res(5,1) = 0;
    end
        
        
    if i > 1 && j > 2
        res(6,1) = img(i-1,j-2);
    else
        res(6,1) = 0;
    end
    
    if i > 1 && j > 1
        res(7,1) = img(i-1,j-1);
    else
        res(7,1) = 0;
    end
    if i > 1
        res(8,1) = img(i-1,j);
    else
        res(8,1) = 0;
    end
    
    if i > 1 && j < col
        res(9,1) = img(i-1,j+1);
    else
        res(9,1) = 0;
    end
    
    if i > 1 && j < col - 1
        res(10,1) = img(i-1,j+2);
    else
        res(10,1) = 0;
    end
    
    if j > 2
        res(11,1) = img(i,j-2);
    else
        res(11,1) = 0;
    end
    if j > 1
        res(12,1) = img(i,j-1);
    else
        res(12,1) = 0;
    end
    
    res(13,1) = img(i,j);
    
    if j < col
        res(14,1) = img(i,j+1);
    else
        res(14,1) = 0;
    end
    
    if j < col - 1
        res(15,1) = img(i,j+2);
    else
        res(15,1) = 0;
    end
    
    if i < row && j > 2
        res(16,1) = img(i+1,j-2);
    else
        res(16,1) = 0;
    end
    if i < row && j > 1
        res(17,1) = img(i+1,j-1);
    else
        res(17,1) = 0;
    end
    
    if i < row
        res(18,1) = img(i+1,j);
    else
        res(18,1) = 0;
    end
    
    if i < row && j < col
        res(19,1) = img(i+1,j+1);
    else
        res(19,1) = 0;
    end
    
    if i < row && j < col - 1
        res(20,1) = img(i+1,j+2);
    else
        res(20,1) = 0;
    end
    
    if i < row - 1 && j > 2
        res(21,1) = img(i+2,j-2);
    else
        res(21,1) = 0;
    end
    if i < row - 1 && j > 1
        res(22,1) = img(i+2,j-1);
    else
        res(22,1) = 0;
    end
    if i < row - 1
        res(23,1) = img(i+2,j);
    else
        res(23,1) = 0;
    end
    if i < row - 1 && j < col
        res(24,1) = img(i+2,j+1);
    else
        res(24,1) = 0;
    end
    if i < row - 1 && j < col - 1
        res(25,1) = img(i+2,j+2);
    else
        res(25,1) = 0;
    end
end