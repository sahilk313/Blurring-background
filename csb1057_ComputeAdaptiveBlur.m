function csb1057_ComputeAdaptiveBlur( imagee, outimage )
    
I=imagee;
im = csb1057_ExtractStatistics(imagee);
%imshow(I);
% 
% for j=1:5:590
%     for i=1:5:590
%         notblack = 0;
%         for m=i:i+4
%             for n=j:j+4
%                 if im(m,n)~=0
%                     notblack = notblack + 1;
%                 end
%             end
%         end
%         sigma = 5.01 - notblack/5;
%         kern = fspecial('gaussian',5,sigma);
%         newim = zeros(5);
%         for m=i:i+4
%             for n=j:j+4
%                 newim(m,n) = I(m,n);
%             end
%         end
%         %disp('ooh');
%         newimG = imfilter(newim,kern);
%         for m=i:i+4
%             for n=j:j+4
%                 I(m,n) = newimG(m,n);
%             end
%         end
%     end
%     disp(j);
% end
% figure, imshow(I);
hsize = 3;
kern = zeros(hsize);
image = imagee;
[rows, columns, dimensions] = size(image);
w = floor(hsize/2);
for dim =1:dimensions
for col = w+1 : columns - w
	for row = w+1 : rows - w
            numblack = 0;           
            rowl = row - w;
            rowr = rowl + hsize - 1;
            coll = col - w;
            colr = coll + hsize - 1;
            sizee = 0;
            for i=rowl:rowr
                for j=coll:colr
                    if(im(i,j)==0)
                        numblack = numblack + 1;
                    end
                    sizee = sizee + 1;
                end
            end
            sigma = 10.01 - 10*(sizee-numblack)/sizee;
            kernel = fspecial('gaussian', hsize, sigma);
            subImage = double(image(rowl:rowr, coll:colr,dim));
            subImage = double(subImage(1:rowr-rowl+1, 1:colr-coll+1));
            temp = subImage .* kernel;
            newval = uint8(sum(temp(:)));
            image(row, col,dim) = newval;   
	end
end
end
origimg = imagee;
kernell = fspecial('gaussian',3,10);
flblr = imfilter(origimg,kernell);
figure, imshow(origimg);
figure, imshow( flblr);
figure, imshow( image);
%title('1.original image                               2.image fully blurred(sigma=10)               3.background blurred(sigma in (0,10))');
imwrite(image,outimage);

end

