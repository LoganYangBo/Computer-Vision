% Bo Yang
% CSE5524- HW2
% 01/23/2022

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 1

%sigma 20
sigma=20; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_20.bmp');

%sigma 10
sigma=10; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_10.bmp');

%sigma 9
sigma=9; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_9.bmp');

%sigma 8
sigma=8; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_8.bmp');

%sigma 7
sigma=7; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_7.bmp');

%sigma 6
sigma=6; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_6.bmp');

%sigma 2
sigma=2; % use different values
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
faceIm = double(imread('affleck_gray.png'));
gIm = imfilter(faceIm, G, 'replicate');
imshow(gIm/255); % double images need range of 0-1
imwrite(uint8(gIm), 'gIm_2.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 2 at end of file



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 3

[Gx, Gy] = gaussDeriv2D(3.0);
myIm = imread('hw2.jpg');
myIm = double(rgb2gray(myIm)); 
gxIm = imfilter(myIm, Gx, 'replicate');
gyIm = imfilter(myIm, Gy, 'replicate');
magIm = sqrt(gxIm.^2 + gyIm.^2);
imagesc(gxIm);
%pause;
imwrite(gxIm, 'gxIm.bmp');
imagesc(gyIm);
%pause;
imwrite(gyIm, 'gyIm.bmp');
imagesc(magIm);
%pause;
imwrite(magIm, 'magIm.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 4
tIm = magIm > 0.1;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_0.1.bmp');

tIm = magIm > 2;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_2.bmp');

tIm = magIm > 5;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_5.bmp');

tIm = magIm > 10;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_10.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 5
Im = imread('hw2.jpg');
Im = double(rgb2gray(Im));
Fx = -fspecial('sobel')';
fxIm = imfilter(Im,Fx);
Fy = -fspecial('sobel');
fyIm = imfilter(Im,Fy);
magIm = sqrt(fxIm.^2 + fyIm.^2);

tIm = magIm > 0.1;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_sobel_0.1.bmp');

tIm = magIm > 2;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_sobel_2.bmp');

tIm = magIm > 5;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_sobel_5.bmp');

tIm = magIm > 10;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_sobel_10.bmp');

tIm = magIm > 50;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_sobel_50.bmp');

tIm = magIm > 90;
imagesc(tIm);
%pause;
imwrite(tIm, 'tIm_sobel_90.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 6

Im = imread('hw2.jpg');
grayIm = rgb2gray(Im); 
edges = edge(grayIm,'canny');
imagesc(edges);
%pause;
imwrite(edges, 'edges.bmp');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Problem 2
function [Gx, Gy] = gaussDeriv2D(sigma)


 mask_size = 2*ceil(3*sigma)+1;
 Gx = zeros(mask_size, mask_size);
 Gy = zeros(mask_size, mask_size);
 y = -ceil(3*sigma);
for i = 1: mask_size
     x = -ceil(3*sigma);
    for j = 1:mask_size
        Gx(i,j) = (exp((-1)*(x^2 + y^2)/ (2*sigma^2))) * (((-1) *x)/(2* pi*sigma^4));
       Gy(i,j) = (exp((-1)*(x^2 + y^2)/ (2*sigma^2))) * (((-1) *y)/(2* pi*sigma^4));
       x = x + 1;
    end
    y = y + 1;
 end
imagesc(Gx);
axis('image');
colormap('gray');
imwrite(uint8(Gx), 'Gx.bmp');
%pause;
plot(Gx)
%pause;
plot(Gy)
%pause;
imagesc(Gy);
axis('image');
colormap('gray');
imwrite(uint8(Gy), 'Gy.bmp');
%pause;


end