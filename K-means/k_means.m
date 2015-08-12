function [cid,nr,centers] = k_means(x,k,nc)
[n,d] = size(x);
% 设置cid为分类结果显示矩阵
cid = zeros(1,n); 
oldcid = ones(1,n);
nr = zeros(1,k); 
maxgn= 100;
iter = 1;
while iter < maxgn
%计算每个数据到聚类中心的距离
for i = 1:n
  dist = sum((repmat(x(i,:),k,1)-nc).^2,2);
  [m,ind] = min(dist); % 将当前聚类结果存入cid中
  cid(i) = ind;
end
for i = 1:k
%找到每一类的所有数据，计算他们的平均值，作为下次计算的聚类中心
  ind = find(cid==i);
  nc(i,:) = mean(x(ind,:));
  % 统计每一类的数据个数
  nr(i) = length(ind);
end
  iter = iter + 1;
end
centers = nc;
