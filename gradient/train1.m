function a = train(X,Y)
%This function will return a vector, the vector from the training samples
%by gradient descent algorithm.
%       X The training samples with any size m*n
%       Y The training sample output has m colums
%       a is the return vector
error = 0.01;          %初始化迭代精度
learning_rate = 0.1;  %学习步长
e = 1;    %迭代误差
[n,m] = size(X);       %X为训练样本
for i = 1:m            %初始化权向量
    a(i) = 1;
end
while e > error
    A = a;
    for i = 1:n             %求取梯度值,并更新权向量
        g(i) = 0;
        for j = 1:m
            g(i) = g(i) + X(i,j)*a(j);
        end
        if g(i) > 0
            g(i) = 1
        else
            g(i) = -1
        end
        for j = 1:m
            a(j) = a(j) - learning_rate*(g(i) - Y(i))*X(i,j);
        end  
    end
    e = norm(a-A);
end