%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1
for i=1:22
filename = sprintf('aerobic-%03d.bmp', i); % if starts with 001
Ims(:,:,i) = double(imread(filename));
end

T = 5;
for i = 2:22
    
    Im_diff(:,:,i-1) = abs(Ims(:,:,i)-Ims(:,:,i-1)) >= T;
    Im_diff(:,:,i-1) = bwareaopen(Im_diff(:,:,i-1),50,8);
    
    imwrite(Im_diff(:,:,i-1), sprintf('diff-%03d.bmp', i-1));
    imagesc(Im_diff(:,:,i-1));
    axis('image');
    colormap('gray');
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2

%MHI
d = 21;
[r,c] = size(Im_diff(:,:,1));
MHI = zeros(r,c);
for i = 2:22
    temp = Im_diff(:,:,i-1);
    [y,x] = size(temp);
    for row = 1:y
        for column = 1:x
            if temp(row,column) ~= 0
                MHI(row,column) = i;
            elseif MHI(row,column) < i -d
                    MHI(row,column) = 0;
            end
        end
    end

    
end

%MEI
MEI = max(Im_diff(:,:,1),Im_diff(:,:,2));
for i = 3:21
    MEI = max(MEI, Im_diff(:,:,i));
end
%normailize

for row = 1:r
    for column = 1:c
        MHI(row,column) = max(0, (MHI(row,column) - 1)/21.0);
    end
end


%similitude moments
NvalsMHI = similitudeMoments(MHI);
NvalsMEI = similitudeMoments(MEI);
disp(NvalsMHI);
disp(NvalsMEI);
    imagesc(MHI);
    axis('image');
    colormap('gray');
    %pause;
    imagesc(MEI);
    axis('image');
    colormap('gray');
    %pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 3

whitebox1 = zeros(101,101);
whitebox1(40:61,6:27) = 255;

whitebox2 = zeros(101,101);
whitebox2(41:62,7:28) = 255;

Ft = whitebox2 - whitebox1;

imagesc(whitebox2);
axis('image');
colormap('gray');
%pause;
imagesc(whitebox2);
axis('image');
colormap('gray');
%pause;
imagesc(Ft);
axis('image');
colormap('gray');
%pause;

Fx = -fspecial('sobel')'/8;
Fy = -fspecial('sobel')/8;

Fx = imfilter(whitebox2,Fx);
Fy = imfilter(whitebox2,Fy);

deli = sqrt(Fx.^2 + Fy.^2);
deli (deli == 0) =1;
Fx = Fx./deli;
Fy = Fy./deli;
Ft = (-Ft)./deli;


u = Fx .* Ft;
v = Fy .*Ft;

imagesc(Ft);
axis('image');
colormap('gray');
hold on
quiver(u,v,2,'r')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2
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




