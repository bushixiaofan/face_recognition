
%% 数据说明：
% c:本数据库总的类别数
% m：每个类别中总的样本数
% train_num:每个类别的训练样本数
% train_data:训练数据,每个数据都转换成一个列向量
% train_label:训练数据对应的类标
% test_data:测试数据,每个数据都转换成一个列向量
% test_label:测试数据对应的类标
% 读取数据时，使用每个类别中前train_num个数据作为训练数据，剩下的数据作为测试数据
%% 
clc;
clear all;

m=9;%每个类别中总的样本数
c=130;%本数据库中总的类别数

train_num=1;%每个类别的训练样本数
test_num=m-train_num;%每个类别的测试样本数

folder='resized_300by300';
%% 简单易懂，但是麻烦的读取方法
% for i=1:c
%     fileName=[folder '\' num2str(i,'%03d') '_frontal.jpg'];
%     img=imread(fileName);
%     tmpimg = rgb2gray(img);
%     image=resize(tmpimg,0.5);
%     dataBase(i,1,:,:)=image;
% end
% for i=1:c
%     for j=1:4
%         fileName=[folder '\' num2str(i,'%03d') '_L' num2str(j) '.jpg'];
%         img=imread(fileName);
%          tmpimg = rgb2gray(img);
%         image=resize(tmpimg,0.5);
%         dataBase(i,j+1,:,:)=image;
%     end
% end
% for i=1:c
%     for j=1:4
%         fileName=[folder '\' num2str(i,'%03d') '_R' num2str(j) '.jpg'];
%         img=imread(fileName);
%         tmpimg = rgb2gray(img);
%         image=resize(tmpimg,0.5);
%         dataBase(i,j+5,:,:)=image;
%     end
% end
%% 简单的读取方法
dirlist = dir(folder);%获取文件名字列表
for i=3:length(dirlist)-1
    fprintf('The %dth image is loading...\t\n',i-2);
    image=imread([folder '/' dirlist(i).name]);%读取图像文件
    tmpImg = rgb2gray(image);%彩色图像转换为灰度图像
    img=imresize(tmpImg,0.5);%将图像变为原图像的一半大小（注：原图像大小为300*300）
    [row col]=size(img);%获取转换后图像大小
    dataBase(:,i-2)=reshape(img,row*col,1);%转换为列向量存于矩阵
end
dataBase=double(dataBase);%将矩阵变为double类型

% 取出相应训练集和测试集
test_index=1; train_index=1;
for i=1:c
    for k=1:m
        if k<=train_num
           tmpVec(:,1)=dataBase(:,(i-1)*m+k);
           train_data(:,train_index)=tmpVec/norm(tmpVec);%数据归一化
           train_label(1,train_index)=i;%训练样本数据类标
           train_index=train_index+1;
        else
           tmpVec(:,1)=dataBase(:,(i-1)*m+k);
           test_data(:,test_index)=tmpVec/norm(tmpVec);%数据归一化
           test_label(1,test_index)=i;%测试样本数据类标
           test_index=test_index+1; 
        end
    end
end


clear dirlist file folder;
clear image img tmpImg tmpVec;
clear train_index test_index;
clear dataBase;
clear i k row col;
%% 请在下面添加你的代码




