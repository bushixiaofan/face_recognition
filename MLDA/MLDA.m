function [W patterns]= MLDA(train)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%该函数主要通过多重判别分析，返回一个C-1个权值向量组成的矩阵W，其中C为类别数
%train为训练样本，每一类的数据对应一个Cell
%class为每个训练样本所对应的类别
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C = unique(class);  %计算有哪些类别

C = size(train,2);

%计算每一类样本的样本均值
X = [];   %所有的训练样本
M = [];
for i = 1:C
    X = [X;train{i}];
    temp = mean(train{i});
    M = [M;temp];    %各类样本的样本均值
    num(i) = size(train{i},1);   %各类样本的样本数
end
%计算总的样本均值
Mz = mean(X);    %总的样本均值
%计算类内散布矩阵S
S = [];
for i = 1:C
    temp = 0;
    for j = 1:num(i)
       temp = temp + (train{i}(j,:) - M(i,:))' * (train{i}(j,:) - M(i,:));
    end
    S{i} = temp;
end
h = size(Mz,2);
%计算总的类内散布矩阵Sw
Sw = zeros(h,h);
for i = 1:C
    if size(Sw) == size(S{i})
        Sw = Sw + S{i};
    end
end
%计算类间散布矩阵Sb
Sb = zeros(h,h);
for i = 1:C
    Sb = Sb + num(i)*(M(i,:)-Mz)'*(M(i,:)-Mz);
end
%计算总体样本的散布矩阵ST
St = Sb + Sw;
%求取向量W
A = repmat(0.1,[1,size(Sw,1)]);
B = diag(A);
[V,L]=eig(inv(Sw + B)*Sb);
[a b] = sort(diag(L),'descend');
W = [];
save tezhengxiangliang a
for i =1:10
    W = [W V(:,b(i))];
end
W = W';
patterns = W*X';