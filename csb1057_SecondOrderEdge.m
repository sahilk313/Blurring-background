function csb1057_SecondOrderEdge( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    sigma = 2.2;
    size = 2;
    [x,y]=meshgrid(-(size):(size),-(size):(size));
    kernel= exp(-(x.^2+y.^2)/(2*sigma*sigma))/(2*pi*sigma*sigma);
    I = image;
    Ig = imfilter(I,kernel);
    h = fspecial('laplacian');
    Ifog = imfilter(Ig,h);
    figure, imshow(10*Ifog);

end

