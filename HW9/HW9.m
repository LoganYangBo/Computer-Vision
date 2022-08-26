%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 1

D2 = readtable('2Dpoints.txt');
D3 = readtable('3Dpoints.txt');

x = table2array(D2(:,1));
y = table2array(D2(:,2));

Xw = table2array(D3(:,1));
Yw = table2array(D3(:,2));
Zw = table2array(D3(:,3));

length = size(x);
z = 1;
for i = 1:length(1) 
    for j = 1:2
        if mod(j, 2) ~= 0
            A(z,1:12) = [Xw(i), Yw(i), Zw(i), 1, 0, 0, 0, 0, -1*Xw(i)*x(i), -1*Yw(i)*x(i), -1*Zw(i)*x(i), -1*x(i)];
        else
            A(z,1:12) = [0,0,0,0, Xw(i), Yw(i), Zw(i), 1, -1*Xw(i)*y(i), -1*Yw(i)*y(i), -1*Zw(i)*y(i), -1*y(i)];
        end
        z = z+1;
    end
end

B = A' * A;

[eVec, eVal] = eig(B);
m = min(eVal(eVal ~= 0));
[minRow,minColumn] = find(eVal == m);
pPrev = eVec(1:12,minColumn);
p = reshape(pPrev,[4,3])';
disp("P = ");
disp(p);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 2
vector1(1:length(1)) = 1;
d3h = [Xw'; Yw';Zw';vector1];
D2h = p * d3h;
D2 = table2array(D2);
for i = 1:length(1)
    D2P(i,1) = D2h(1,i)/D2h(3,i);
    D2P(i,2) = D2h(2,i)/D2h(3,i);
    distance(i) = (D2P(i,1) - D2(i,1)) ^ 2 + (D2P(i,2) - D2(i,2)) ^2;
    
end
sumOfSquared = sum(distance, 'all');
disp("sum-of-squared error = ");
disp(sumOfSquared);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 3
clear; close all;
points = readtable('homography.txt');

x1 = table2array(points(:,1));
y1 = table2array(points(:,2));

x2 = table2array(points(:,3));
y2 = table2array(points(:,4));

x1_mean = mean(x1);
y1_mean = mean(y1);

x2_mean = mean(x2);
y2_mean = mean(y2);

length = size(x1);
for i = 1:length(1)
 
    distance1(i) = sqrt((x1(i) - x1_mean) ^ 2 + (y1(i) - y1_mean) ^2);
    distance2(i) = sqrt((x2(i) - x2_mean) ^ 2 + (y2(i) - y2_mean) ^2);
    
end

s1 = sqrt(2) / mean(distance1);
s2 = sqrt(2) / mean(distance2);

z = 1;
for i = 1:length(1)
    
    for j = 1:2
        if mod(j, 2) ~= 0
            A(z,1:9) = [s1*(x1(i)-x1_mean), s1*(y1(i)-y1_mean), 1, 0, 0, 0, -1*s1*(x1(i)-x1_mean)*s2*(x2(i)-x2_mean), -1*s1*(y1(i)-y1_mean)*s2*(x2(i)-x2_mean), -1*s2*(x2(i)-x2_mean)];
        else
            A(z,1:9) = [0, 0, 0, s1*(x1(i)-x1_mean), s1*(y1(i)-y1_mean), 1, -1*s1*(x1(i)-x1_mean)*s2*(y2(i)-y2_mean), -1*s1*(y1(i)-y1_mean)*s2*(y2(i)-y2_mean), -1*s2*(y2(i)-y2_mean)];
        end
        z = z+1;
    end
end

T1 = [s1, 0, -1*s1*x1_mean;
      0 , s1, -1*s1*y1_mean;
      0, 0, 1];
  
T2 = [s2, 0, -1*s2*x2_mean;
      0 , s2, -1*s2*y2_mean;
      0, 0, 1];

B = A' * A;

[eVec, eVal] = eig(B);
m = min(eVal(eVal ~= 0));
[minRow,minColumn] = find(eVal == m);
hPrev = eVec(1:9,minColumn);
h_hat = reshape(hPrev,[3,3])';
H = inv(T2) * h_hat * T1;
disp("H = ");
disp(H);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 4
vector1(1:length(1)) = 1;

d2h = [x1'; y1';vector1];
D2h = H * d2h;

for i = 1:length(1)
    x2_p(i) = D2h(1,i)/D2h(3,i);
    y2_p(i) = D2h(2,i)/D2h(3,i);
    
    distance(i) = (x2_p(i) - x2(i)) ^ 2 + (y2_p(i) - y2(i)) ^2;
    
end

figure;
hold on;
plot(x2_p,y2_p,'bx','MarkerSize',15);
plot(x2,y2,'r.','MarkerSize',15);
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem 5
sumOfSquared = sum(distance, 'all');
disp("sum-of-squared error = ");
disp(sumOfSquared);