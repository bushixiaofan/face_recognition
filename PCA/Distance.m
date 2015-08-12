function d = Distance(features,test)
%This function will calculate between two vectors in n-dimensional Euclidean distance function 
%Suppose that X is an m*n dimensional matrix, and the test is a n dimensional vector 
%Then the return value D is a vector in m-dimensional.

[m,n] = size(features);
[h,w] = size(test); 
sum = 0; 
z = min(m,h);
for i = 1:z %计算测试样本与训练样本之间的欧氏距离
    sum = sum + (features(i) - test(i))^2;
end
d = sqrt(sum);

