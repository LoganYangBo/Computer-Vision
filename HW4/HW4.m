%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1

Im1 = im2double(imread('boxIm1.bmp'));
NvalsIm1 = similitudeMoments(Im1);
disp(NvalsIm1);

Im2 = im2double(imread('boxIm2.bmp'));
NvalsIm2 = similitudeMoments(Im2);
disp(NvalsIm2);

Im3 = im2double(imread('boxIm3.bmp'));
NvalsIm3 = similitudeMoments(Im3);
disp(NvalsIm3);

Im4 = im2double(imread('boxIm4.bmp'));
NvalsIm4 = similitudeMoments(Im4);
disp(NvalsIm4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2

%% Load the data
clear; close all;
load eigdata.txt;
X = eigdata;
subplot(5,1,1);
plot(X(:,1),X(:,2),'b.');
axis('equal');
%% mean-subtract data
m = mean(X);
Y = X - ones(size(X,1),1)*m;
subplot(5,1,2);
plot(Y(:,1),Y(:,2),'r.');
axis('equal');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 3
cov_Y = cov(Y);
[U,V] = eig(cov_Y);
C = 9;
x_axis = U(:,1) * (sqrt(C *V(1,1)));
y_axis = U(:,2) * (sqrt(C *V(2,2)));
subplot(5,1,3);
plot(Y(:,1),Y(:,2),'r.');
hold on
plot([0,x_axis(1)],[0,x_axis(2)] , 'b');
plot([0,y_axis(1)],[0,y_axis(2)], 'b');
plot([0,-x_axis(1)],[0,-x_axis(2)] , 'b');
plot([0,-y_axis(1)],[0,-y_axis(2)], 'b');
axis('equal'); 
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 4

subplot(5,1,4);
Y = U' * Y';
Y = fliplr(Y');
plot(Y(:,1),Y(:,2),'r.');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 5
subplot(5,1,5);
h = histogram(Y(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function for problem 1
%similitude moments
function n_pq =  spatial_central_moments(image, p, q)
    m00 = sum(sum(image));
    [y,x] = size(image);
    
    m10 = 0;
    m01 = 0;
    for row = 1 :y
        for column=1:x
            m10 = m10 + column * image(row,column);
            m01 = m01 + row * image(row,column);
            
        end
    end
    x_bar = m10/m00;
    y_bar = m01/m00;
    
    u_pq = 0;
    for row = 1 :y
        for column=1:x
            u_pq = u_pq + ((column - x_bar)^p) * ((row - y_bar)^q) * image(row,column);
        end
    n_pq = u_pq / (m00 ^ (1+ ((p+q)/2)));
    end
end
function Nvals =  similitudeMoments(image)

       Nvals = [spatial_central_moments(image,0, 2), spatial_central_moments(image, 0, 3),...
           spatial_central_moments(image, 1, 1), spatial_central_moments(image, 1, 2),...
           spatial_central_moments(image, 2, 0), spatial_central_moments(image, 2, 1),...
           spatial_central_moments(image, 3, 0)];
end