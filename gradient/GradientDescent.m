function result = GradientDescent(a,test)
%This function will be a linear classification with
%the gradient descent algorithm .
%       a is the return vector
%       test the test sample  has n colums
[n,m] = size(test);       %X为训练样本
result = 0.0;
t = im2double(test);
for i = 1:m
    result = (result + a(i)*t(i));    %获得判别函数
end

