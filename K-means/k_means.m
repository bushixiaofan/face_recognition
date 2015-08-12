function [cid,nr,centers] = k_means(x,k,nc)
[n,d] = size(x);
% ����cidΪ��������ʾ����
cid = zeros(1,n); 
oldcid = ones(1,n);
nr = zeros(1,k); 
maxgn= 100;
iter = 1;
while iter < maxgn
%����ÿ�����ݵ��������ĵľ���
for i = 1:n
  dist = sum((repmat(x(i,:),k,1)-nc).^2,2);
  [m,ind] = min(dist); % ����ǰ����������cid��
  cid(i) = ind;
end
for i = 1:k
%�ҵ�ÿһ����������ݣ��������ǵ�ƽ��ֵ����Ϊ�´μ���ľ�������
  ind = find(cid==i);
  nc(i,:) = mean(x(ind,:));
  % ͳ��ÿһ������ݸ���
  nr(i) = length(ind);
end
  iter = iter + 1;
end
centers = nc;
