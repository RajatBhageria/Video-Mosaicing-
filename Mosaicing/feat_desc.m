% File name: feat_desc.m
% Author:
% Date created:

function [descs] = feat_desc(img, x, y)
% Input:
%    img = double (height)x(width) array (grayscale image) with values in the
%    range 0-255
%    x = nx1 vector representing the column coordinates of corners
%    y = nx1 vector representing the row coordinates of corners

% Output:
%   descs = 64xn matrix of double values with column i being the 64 dimensional
%   descriptor computed at location (xi, yi) in im


%define row as y and col as x for simpler debugging 
col = x;
row = y;

numCorners = size(x,1); 

%define a windowSize in each direction. 
windowSize = 20; 

%find the size of the image
[n,m] = size(img); 

%initialize the final output
descs = zeros(64,numCorners); 

%find a feature descriptor for each of the corners
for corner = 1:numCorners
    corneri = row(corner); 
    cornerj = col(corner); 
        
    %find the windowSizex2 by windowSizex2 window 
    upI = 0; 
    downI = 0; 
    
    leftJ = 0; 
    rightJ = 0; 
    
    %upperRow Index 
    if (corneri - windowSize > 0)
        upI = corneri - windowSize; 
    else 
        upI = 0;
    end 
    
    %lowerRow index 
    if (corneri + windowSize <= n) 
        downI = corneri + windowSize-1; 
    else
        downI = n; 
    end
    
    %leftCol Index
    if (cornerj - windowSize > 0)
        leftJ = cornerj - windowSize; 
    else 
        leftJ = 0;
    end 
    
    %rightCol index 
    if (cornerj + windowSize <= n) 
        rightJ = cornerj + windowSize-1; 
    else
        rightJ = m; 
    end 
    
    %select the window 
    window = img(upI:downI, leftJ:rightJ); 
    
    %do a gaussian filter of window 
    gaussian = imgaussfilt(window);
    
    %resize the image to an new size 
    newDimension = 8; 
    resized = imresize(gaussian, [newDimension, newDimension]); 
    
    %resize the 8x8 patch into a column 
    column  = resized(:); 
    
    %put the 64x1 column for each feature into the return matrix. 
    descs(:,corner) = column; 
end 

end