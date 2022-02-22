modelCovMatrix = [47.917 0 -146.636 -141.572 -123.269;
0 408.250 68.487 69.828 53.479;
-146.636 68.487 2654.285 2621.672 2440.381;
-141.572 69.828 2621.672 2597.818 2435.368;
-123.269 53.479 2440.381 2435.368 2404.923];

Im = double(imread('target.jpg'));

[y,x,z] = size(Im);
for r = 1: (y-69)
    for c = 1:(x-23)
        window(1:70,1:24,1:z) = Im(r:r+69,c:c+23,1:z);
        [j,i,k] = size(window);
        w = 1;
        for row = 1:j
            for column = 1:i
                window_fk(w,1:5) = [column,row,window(row,column,1),...
                    window(row,column,2),window(row,column,3)];
                w = w+1;
            end
        end
        candidatCovMatrix = cov(window_fk,1);
        eigenV = eig(modelCovMatrix,candidatCovMatrix);
        sum = 0;
        for e = 1:length(eigenV)
            if eigenV(e) ~= 0
                sum = sum + log(eigenV(e))^2;
            end
        end
        
       results(r,c) = sqrt(sum);
        
    end
    
end
surf(results);
imagesc(results);

result = min(results(:));
[r,c] = find(results==result);

disp(r)
disp(c)
result_Im(1:70,1:24,1:3) = Im(r:r+69,c:c+23,1:3);

imagesc(uint8(result_Im));
axis('image');