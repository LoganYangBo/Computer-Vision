%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1

OriIm = double(imread('right.png'));
T = double(imread('left.png'));
[yO,xO] = size(OriIm);
[yT,xT] = size(T);
n = 11*11 -1;

for r = 1: (yT-(11-1))
    
    for c = 1:(xT - (11-1))
         Window(1:11,1:11) = T(r:r+(11-1),c:c+(11 -1));
         result_location = zeros(256,256);
         result_l = [];
         i = 1;
         if c >= 50
             for c2 = (c-49):c
                 P(1:11,1:11) = OriIm(r:r+(11-1),c2:c2+(11-1));
                 sum = 0;

                 meanP = mean(P,'all');
                 meanW = mean(Window,'all');
                 denominator = std(P, 0,'all') * std(Window, 0,'all');
                 if denominator == 0
                     denominator = 1;
                 end
                 for y = 1: 11
                     for x = 1: 11
                            %numerator = (P(y, x, z) - mean(P(:,:,z),'all')) * (T(y, x, z) - mean(T(:,:,z),'all'));
                            numerator = (P(y, x) - meanP) * (Window(y, x) - meanW);
                           % denominator = std(P(:,:,z), 1,'all') * std(T(:,:,z), 1,'all');
                            sum = sum + (numerator/denominator);

                     end
                 end
                 result_location(r,c2) = sum/n;
                 result_l(i) = sum/n;
                 i = i+1;
             end
             
         else
             for c2 = 1:c
                 P(1:11,1:11) = OriIm(r:r+(11-1),c2:c2+(11-1));
                 sum = 0;

                 meanP = mean(P,'all');
                 meanW = mean(Window,'all');
                 denominator = std(P, 0,'all') * std(Window, 0,'all');
                 if denominator == 0
                     denominator = 1;
                 end
                 for y = 1: 11
                     for x = 1: 11
                            %numerator = (P(y, x, z) - mean(P(:,:,z),'all')) * (T(y, x, z) - mean(T(:,:,z),'all'));
                            numerator = (P(y, x) - meanP) * (Window(y, x) - meanW);
                           % denominator = std(P(:,:,z), 1,'all') * std(T(:,:,z), 1,'all');
                            sum = sum + (numerator/denominator);

                     end
                 end
                 result_location(r,c2) = sum/n;
                 result_l(i) = sum/n;
                 i = i+1;
             end
             
         end
         sorted = sort(result_l, 'descend');
         [M,I] = max(result_l, [], 'all', 'linear');
         fr = 0;
         fc = 0;
         [fr,fc] = find(result_location == sorted(1));
         resule_c(r,c) = sorted(1);
         D(r,c) = abs(c -fc(1));
         
        
        
        
    end
end
imagesc(D, [0 50]);
axis equal;
colormap gray;
%pause;

imagesc(D(:,50:end), [0 50]);
axis equal;
colormap gray;
%pause;

imagesc(D);
axis equal;
colormap gray;
pause;