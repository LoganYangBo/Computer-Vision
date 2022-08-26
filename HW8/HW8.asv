%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1
myIm = double(imread('checker.png'));

[Gx, Gy] = gaussDeriv2D(0.7);
Gx = Gx ./ sum(abs(Gx), 'all');
Gy = Gy ./ sum(abs(Gy), 'all');
Ix = imfilter(myIm, Gx, 'replicate');
Iy = imfilter(myIm, Gy, 'replicate');

Ix2 = Ix.^2;
Iy2 = Iy.^2;
IxIy = Ix .* Iy;

sigma=1; 
G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
gIx2 = imfilter(Ix2, G, 'replicate');
gIy2 = imfilter(Iy2, G, 'replicate');
gIxIy = imfilter(IxIy, G, 'replicate');

R = gIx2 .* gIy2 - gIxIy .^ 2 - 0.05 .* ((gIx2 + gIy2) .^2);

R(17:23, 17:23)

imagesc(R(17:23, 17:23));
colormap('gray');

sum(abs(Gy),'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remove 
%Threshold



[x,y] = size(R);
for i = 1: x
    for j = 1 : y
        if R(i,j) < 1000000
            RemovedR(i,j) = 0;
        else
            RemovedR(i,j) = R(i,j);
        end
    end
end

imagesc(RemovedR);
colormap('gray');
axis('image');
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%unique max
nonMaxX = [];
nonMaxY = [];
for i = 1+1: x-1
    for j = 1+1: y-1
        neibor = RemovedR(i-1:i+1, j-1:j+1);
        count = 0;
        for rN = 1:3
            for cN = 1:3
                if neibor(rN, cN) == RemovedR(i,j)
                    count = count+1;
                end
            end
        end
        
        if RemovedR(i,j) == max(neibor, [],'all') & count == 1
            nonMax(i,j) = RemovedR(i,j);
            nonMaxX(end+1) = i;
            nonMaxY(end+1) = j;
        else
            nonMax(i,j) = 0;
        end
    end
end

figure;

imagesc(myIm);
colormap('gray');
axis('image');
hold on;
plot(nonMaxY,nonMaxX,'r.','MarkerSize',15);
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2

myIm = imread('tower.png');

[fastX10, fastY10] = fast(myIm, 10);
[fastX20, fastY20] = fast(myIm, 20);
[fastX30, fastY30] = fast(myIm, 30);
[fastX50, fastY50] = fast(myIm, 50);



figure;
imshow(myIm);
hold on;
plot(fastY10,fastX10,'r.');
hold off;

figure;
imshow(myIm);
hold on;
plot(fastY20,fastX20,'r.');
hold off;

figure;
imshow(myIm);
hold on;
plot(fastY30,fastX30,'r.');
hold off;


figure;

imshow(myIm);
hold on;
plot(fastY50,fastX50,'r.');
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2 function
function [fastX, fastY] = fast(myIm, T)
[x,y] = size(myIm);
r = 3;
n = 9;
fastX = [];
fastY = [];
for i = 4:x-3
    for j = 4:y-3
        upper = myIm(i,j) + T;
        lower = myIm(i,j) - T;
        grayScales = [myIm(i-3,j), myIm(i-3,j+1), myIm(i-2,j+2), myIm(i-1,j+3),...
                      myIm(i,j+3), myIm(i+1,j+3), myIm(i+2,j+2), myIm(i+3,j+1),...
                      myIm(i+3,j), myIm(i+3,j-1), myIm(i+2,j-2), myIm(i+1,j-3),...
                      myIm(i,j-3), myIm(i-1,j-3), myIm(i-2,j-2), myIm(i-3,j-1)];
        nu = 0;
        nl = 0;
        added = 0;
        for k = 1:16
            if grayScales(k) > upper
                nl = 0;
                nu = nu + 1;
                if nu >= n
                    fastX(end+1) = i;
                    fastY(end+1) = j;
                    added = 1;
                    break
                end
            elseif grayScales(k) < lower 
                    nu = 0;
                    nl = nl + 1;
                    if nl >= n
                        fastX(end+1) = i;
                        fastY(end+1) = j;
                        added = 1;
                        break
                    end
            else
                nu = 0;
                nl = 0;
            end
        end
        
        
        if grayScales(1) > upper & grayScales(16) > upper & added ==0 
            for k = 1:16
                if grayScales(k) > upper
                    nu = nu + 1;
                    if nu >= n
                        fastX(end+1) = i;
                        fastY(end+1) = j;
                        added = 1;
                        break
                    end
                else
                     nu = 0;
                     break
                end
            end
        elseif grayScales(1) < lower & grayScales(16) < lower & added ==0 
            for k = 1:16
                if grayScales(k) < lower
                    nl = nl + 1;
                    if nl >= n
                        fastX(end+1) = i;
                        fastY(end+1) = j;
                        added = 1;
                    break
                    end
                else
                    nl = 0;
                    break
                end
            end
        end
        
        
        
    end
end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1 Functions
function [Gx, Gy] = gaussDeriv2D(sigma)


 mask_size = 2*ceil(3*sigma)+1;
 Gx = zeros(mask_size, mask_size);
 Gy = zeros(mask_size, mask_size);
 y = -ceil(3*sigma);
for i = 1: mask_size
     x = -ceil(3*sigma);
    for j = 1:mask_size
        Gx(i,j) = (exp((-1)*(x^2 + y^2)/ (2*sigma^2))) * (((1) *x)/(2* pi*sigma^4));
       Gy(i,j) = (exp((-1)*(x^2 + y^2)/ (2*sigma^2))) * (((1) *y)/(2* pi*sigma^4));
       x = x + 1;
    end
    y = y + 1;
end
end