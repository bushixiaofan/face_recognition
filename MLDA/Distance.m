function [d pos] = Distance(X,test)
%This function will calculate between two vectors in n-dimensional Euclidean distance function 
%Suppose that X is an h*w dimensional matrix, and the test is a h dimensional vector 
%Then the return value d is a minimal distance and pos is the postion of
%the distance.

[h,w] = size(X); 
% sum = 0; 
% for i = 1:z %计算测试样本与训练样本之间的欧氏距离
%     sum = sum + (features(i) - test(i))^2;
% end
% distance = sqrt(sum);
for i = 1:w
    square = sum((X(:,i) - test).^2);
    distances(i) = sqrt(square);
end
[d pos] = min(distances);