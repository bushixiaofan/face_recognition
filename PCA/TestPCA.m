function [Train_pro, m, A] = TestPCA(allsample,tre)
allsample = uint8(allsample);

%%%%%%%%%主成分分析（PCA）%%%%%%%%%%%%%%
%%%%%%%%%计算平均图片数据%%%%%%%%%%%
m = mean(allsample,2);   %计算样本每一维平均值 
[pix_num, img_num] = size(allsample);%返回行为图片像素个数，列为图片数目

%%%%%%计算每个图像与均值的差%%%%%%%%%%%%%%
A = zeros(pix_num,img_num);%行为图片像素个数，列为图片数目
m1=ones(1,img_num);%用于构造矩阵运算
A = double(allsample) - m*m1; 
%%%%%%%计算协方差矩阵的特征矢量和特征值%%%%%%
L = A'*A;    %由SVD理论构造矩阵L=A'*A用于计算特征值和特征向量
%[S,x] = svd(A);
%S
[V, D] = eig(L);%计算矩阵A的特征值D和特征向量矩阵V
d1=diag(D);
% 按特征值大小以降序排列
dsort = flipud(d1);
vsort = fliplr(V);
%以下选择95%的能量                                         
dsum = sum(dsort);
dsumtemp = 0;
char_num = 0;%特征值主分量个数
while( dsumtemp/dsum < tre)
    char_num = char_num + 1;
    dsumtemp = sum(dsort(1:char_num));
end

%%%%%%计算特征脸主分量%%%%%%%%%%
U=zeros(pix_num,char_num);%主分量特征向量
vsort=vsort(:,1:char_num);
dsort=dsort(1:char_num).^(-1/2);
dsort=diag(dsort);
U=A* vsort*dsort;%求协方差矩阵的特征向量主分量

%%%%%%计算训练集中人脸在特征空间中的投影表示%%%%%
Train_pro=zeros(char_num,img_num);
Train_pro=U'*A;

