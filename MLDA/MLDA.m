function [W patterns]= MLDA(train)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ú�����Ҫͨ�������б����������һ��C-1��Ȩֵ������ɵľ���W������CΪ�����
%trainΪѵ��������ÿһ������ݶ�Ӧһ��Cell
%classΪÿ��ѵ����������Ӧ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C = unique(class);  %��������Щ���

C = size(train,2);

%����ÿһ��������������ֵ
X = [];   %���е�ѵ������
M = [];
for i = 1:C
    X = [X;train{i}];
    temp = mean(train{i});
    M = [M;temp];    %����������������ֵ
    num(i) = size(train{i},1);   %����������������
end
%�����ܵ�������ֵ
Mz = mean(X);    %�ܵ�������ֵ
%��������ɢ������S
S = [];
for i = 1:C
    temp = 0;
    for j = 1:num(i)
       temp = temp + (train{i}(j,:) - M(i,:))' * (train{i}(j,:) - M(i,:));
    end
    S{i} = temp;
end
h = size(Mz,2);
%�����ܵ�����ɢ������Sw
Sw = zeros(h,h);
for i = 1:C
    if size(Sw) == size(S{i})
        Sw = Sw + S{i};
    end
end
%�������ɢ������Sb
Sb = zeros(h,h);
for i = 1:C
    Sb = Sb + num(i)*(M(i,:)-Mz)'*(M(i,:)-Mz);
end
%��������������ɢ������ST
St = Sb + Sw;
%��ȡ����W
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