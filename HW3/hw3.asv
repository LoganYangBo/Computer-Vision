%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1
myIm = imread('hw3.jpg');
grayIm = double(rgb2gray(myIm));
N = 3;
C = 100 * 2^N +1;
R = 120 * 2^N + 1;
cropIm = imcrop(grayIm,[0,0,R,C]);
imwrite(uint8(grayIm), 'grayIm.png');
imwrite(uint8(cropIm), 'cropIm.png');

%level 1
blurIm1 = blur(cropIm);
sampleIm1 = sample(blurIm1);
[expandIm1, laplacian1] = interpolation(cropIm, sampleIm1);
imwrite(uint8(blurIm1), 'blurIm1.png');
imwrite(uint8(sampleIm1), 'sampleIm1.png');
imwrite(uint8(laplacian1), 'laplacian1.png');
%level 2
blurIm2 = blur(sampleIm1);
sampleIm2 = sample(blurIm2);
[expandIm2, laplacian2] = interpolation(sampleIm1, sampleIm2);
imwrite(uint8(blurIm2), 'blurIm2.png');
imwrite(uint8(sampleIm2), 'sampleIm2.png');
imwrite(uint8(laplacian2), 'laplacian2.png');

%level 3
blurIm3 = blur(sampleIm2);
sampleIm3 = sample(blurIm3);
[expandIm3, laplacian3] = interpolation(sampleIm2, sampleIm3);
imwrite(uint8(blurIm3), 'blurIm3.png');
imwrite(uint8(sampleIm3), 'sampleIm3.png');
imwrite(uint8(laplacian3), 'laplacian3.png');

%Reconstruction
imagesc(laplacian1);
axis('image');
%pause;
imagesc(laplacian2);
axis('image');
%pause;
imagesc(laplacian3);
axis('image');
%pause;

expandIm3 = interpolation(sampleIm2, sampleIm3);
recon3 = laplacian3 + expandIm3;
expandIm2 = interpolation(sampleIm1, recon3);
recon2 = laplacian2 + expandIm2;
expandIm1 = interpolation(cropIm, recon2);
recon = expandIm1 + laplacian1;



imwrite(uint8(expandIm1), 'expandIm1.png');
imwrite(uint8(expandIm2), 'expandIm2.png');
imwrite(uint8(expandIm3), 'expandIm3.png');
imwrite(uint8(recon), 'Reconstruction.png');
imwrite(uint8(recon2), 'Reconstruction2.png');
imwrite(uint8(recon3), 'Reconstruction3.png');
imagesc(recon);
axis('image');
%pause;








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2

walkIm = double(imread('walk.bmp'));
bgIm = double(imread('bg000.bmp'));
Ta = 35;
B = abs(walkIm - bgIm) > Ta;
imwrite(B, 'p2.png');
imagesc(B);
axis('image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 3

Tb = 35;
for i=1:30
filename = sprintf('bg%03d.bmp', i-1); % if starts with 000
bgIms(:,:,i) = double(imread(filename));
end

std_val = std(bgIms, 0, 3);
inten_mea = mean(bgIms,3);

B3 = ((walkIm - inten_mea).^2 ./ std_val.^2) > Tb^2;
imwrite(B3, 'p3.png');
imagesc(B3);
axis('image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 4

d_bsIm = bwmorph(B3, 'dilate');
imwrite(d_bsIm, 'p4.png');
imagesc(d_bsIm);
axis('image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 5

%[L, num] = bwlabel(d_bsIm, 8);
L = bwareafilt(d_bsIm,1);
imwrite(L, 'p5.png');
imagesc(L);
axis('image');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1 functions
%Blur
function blurIm = blur(Im)
a = 0.4;
wR = [.25-.5*a, .25,a,.25,.25 -.5*a];
wC = transpose(wR);
blurIm = imfilter(Im, wR);
blurIm = imfilter(blurIm, wC);
imagesc(blurIm);
axis('image');
colormap('gray');
end

%Sampling
function sampledImage = sample(blurIm)
sampledImage = blurIm(1:2:end, 1:2:end);
imagesc(sampledImage);
axis('image');
colormap('gray');
end

%Interpolation
function [expandIm, laplacian] = interpolation(cropIm, sampleIm)

[rows, columns] = size(sampleIm);


expand_row = 2*rows -1;
expand_col = 2*columns -1;
expand_row_Im = zeros(expand_row,columns);
expandIm = zeros(expand_row,expand_col);
for i = 1:columns-1
    for j = 1:rows-1
        expand_row_Im(j*2-1,i) = sampleIm(j,i);
        expand_row_Im(j*2,i) = mean([sampleIm(j,i),sampleIm(j+1,i)]);
        if i == columns -1
            expand_row_Im(j*2-1,columns) = sampleIm(j,columns);
            expand_row_Im(j*2,columns) = mean([sampleIm(j,columns),sampleIm(j+1,columns)]);
        end
    end
    
    expand_row_Im(rows*2-1,i) = sampleIm(rows,i);
    expand_row_Im(rows*2-1,columns) = sampleIm(rows,columns);
    
    
end
for i = 1:columns-1
    for j = 1:expand_row-1
        expandIm(j,i*2-1) = expand_row_Im(j,i);
        expandIm(j,i*2) = mean([expand_row_Im(j,i),expand_row_Im(j,i+1)]);
        if i == columns -1
            expandIm(j,columns*2-1) = expand_row_Im(j,columns);
        end
    end
    
    expandIm(expand_row,i*2-1) = expand_row_Im(expand_row,i);
    expandIm(expand_row,i*2) = mean([expand_row_Im(expand_row,i),expand_row_Im(expand_row,i+1)]);
    expandIm(expand_row,expand_col) = expand_row_Im(expand_row,columns);
    
    
end

laplacian = cropIm - expandIm;

imagesc(laplacian);
axis('image');
%pause;
end







