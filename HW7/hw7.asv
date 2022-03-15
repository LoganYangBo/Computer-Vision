%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1
myIm = imread('hw7.jpg');
figure
%different campactness
N = 500;
[L, NumLabels] = superpixels(myIm, N, 'Compactness', 100);
BW = boundarymask(L);
subplot(2,3,1), imshow(imoverlay(myIm,BW,'black')) 
disp(NumLabels)

N = 500;
[L, NumLabels] = superpixels(myIm, N, 'Compactness', 20);
BW = boundarymask(L);
subplot(2,3,2),imshow(imoverlay(myIm,BW,'black')) 
disp(NumLabels)

N = 500;
[L, NumLabels] = superpixels(myIm, N, 'Compactness', 1);
BW = boundarymask(L);
subplot(2,3,3), imshow(imoverlay(myIm,BW,'black')) 
disp(NumLabels)

N = 1000;
[L, NumLabels] = superpixels(myIm, N, 'Compactness', 20);
BW = boundarymask(L);
subplot(2,3,4), imshow(imoverlay(myIm,BW,'black')) 
disp(NumLabels)

N = 200;
[L, NumLabels] = superpixels(myIm, N, 'Compactness', 20);
BW = boundarymask(L);
subplot(2,3,5), imshow(imoverlay(myIm,BW,'black')) 
disp(NumLabels)

N = 10;
[L, NumLabels] = superpixels(myIm, N, 'Compactness', 20);
BW = boundarymask(L);
subplot(2,3,6), imshow(imoverlay(myIm,BW,'black')) 
disp(NumLabels)

%pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2
clear; close all;
OriIm = double(imread('search.png'));
T = double(imread('template.png'));
[yO,xO,zO] = size(OriIm);
[yT,xT,zT] = size(T);
n = yT*xT -1;

Center = round([yT xT]/2) ;
i = 1;
for r = 1: (yO-(yT-1))
    for c = 1:(xO - (xT -1))
         P(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:zO);
         if r < Center(1) || c < Center(2)
            P_center_r = Center(1) - r;
            P_center_c = Center(2) - c;
         end
         sum = 0;
         for z = 1: zT
             meanP = mean(P(:,:,z),'all');
             meanT = mean(T(:,:,z),'all');
             denominator = std(P(:,:,z), 0,'all') * std(T(:,:,z), 0,'all');
             for y = 1: yT
                 for x = 1: xT
                        %numerator = (P(y, x, z) - mean(P(:,:,z),'all')) * (T(y, x, z) - mean(T(:,:,z),'all'));
                        numerator = (P(y, x, z) - meanP) * (T(y, x, z) - meanT);
                       % denominator = std(P(:,:,z), 1,'all') * std(T(:,:,z), 1,'all');
                        sum = sum + (numerator/denominator);

                 end
             end
         end
         resule_c(r,c) = sum/n;
         result_l(i) = sum/n;
         i = i+1;
         
        
        
        
    end
end



sorted = sort(result_l, 'descend');

fprintf('%.3f',sorted(1));
[r,c] = find(resule_c == sorted(1));
result_Im(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:3);
imagesc(uint8(result_Im));
axis('image');
pause;


[r,c] = find(resule_c == sorted(2));
result_Im(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:3);
imagesc(uint8(result_Im));
axis('image');
pause;



[r,c] = find(resule_c == sorted(5));
result_Im(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:3);
imagesc(uint8(result_Im));
axis('image');
pause;

[r,c] = find(resule_c == sorted(10));
result_Im(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:3);
imagesc(uint8(result_Im));
axis('image');
pause;

[r,c] = find(resule_c == sorted(100));
result_Im(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:3);
imagesc(uint8(result_Im));
axis('image');
pause;

[r,c] = find(resule_c == sorted(500));
result_Im(1:yT,1:xT,1:zT) = OriIm(r:r+(yT-1),c:c+(xT -1),1:3);
imagesc(uint8(result_Im));
axis('image');
pause;


plot(sorted, 0 * sorted,'ob');