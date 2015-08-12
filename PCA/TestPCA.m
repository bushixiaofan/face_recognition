function [Train_pro, m, A] = TestPCA(allsample,tre)
allsample = uint8(allsample);

%%%%%%%%%���ɷַ�����PCA��%%%%%%%%%%%%%%
%%%%%%%%%����ƽ��ͼƬ����%%%%%%%%%%%
m = mean(allsample,2);   %��������ÿһάƽ��ֵ 
[pix_num, img_num] = size(allsample);%������ΪͼƬ���ظ�������ΪͼƬ��Ŀ

%%%%%%����ÿ��ͼ�����ֵ�Ĳ�%%%%%%%%%%%%%%
A = zeros(pix_num,img_num);%��ΪͼƬ���ظ�������ΪͼƬ��Ŀ
m1=ones(1,img_num);%���ڹ����������
A = double(allsample) - m*m1; 
%%%%%%%����Э������������ʸ��������ֵ%%%%%%
L = A'*A;    %��SVD���۹������L=A'*A���ڼ�������ֵ����������
%[S,x] = svd(A);
%S
[V, D] = eig(L);%�������A������ֵD��������������V
d1=diag(D);
% ������ֵ��С�Խ�������
dsort = flipud(d1);
vsort = fliplr(V);
%����ѡ��95%������                                         
dsum = sum(dsort);
dsumtemp = 0;
char_num = 0;%����ֵ����������
while( dsumtemp/dsum < tre)
    char_num = char_num + 1;
    dsumtemp = sum(dsort(1:char_num));
end

%%%%%%����������������%%%%%%%%%%
U=zeros(pix_num,char_num);%��������������
vsort=vsort(:,1:char_num);
dsort=dsort(1:char_num).^(-1/2);
dsort=diag(dsort);
U=A* vsort*dsort;%��Э����������������������

%%%%%%����ѵ�����������������ռ��е�ͶӰ��ʾ%%%%%
Train_pro=zeros(char_num,img_num);
Train_pro=U'*A;

