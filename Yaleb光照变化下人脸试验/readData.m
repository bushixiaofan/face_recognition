
clc;
clear all;

%% 数据说明：
% train_data:训练数据,每个数据都转换成一个列向量
% train_label:训练数据对应的类标
% test_data:测试数据,每个数据都转换成一个列向量
% test_label:每个测试数据的类标
% train_num:每个类别的训练样本数
% test_num:每个类别的测试样本数
% c:本数据库所有的类别数
% m:每个类别所有的样本数
% 读取数据时，使用每个类别中前train_num个数据作为训练数据，剩下的数据作为测试数据
%%
m=64;%每一个类别（个体）的所有的样本数
c=38;%这个数据库总的类别（个体）数

train_num=10;%每一个类别的训练样本数

test_num=m-train_num;%每一个类别的测试样本数

folder='yaleb重新编号';
for i=1:c
    for j=1:m
        filename=[folder '\' num2str(i) '_' num2str(j) '.tif']
        dataBase(i,j,:,:)=imread(filename);
    end
end
dataBase=double(dataBase);%将矩阵变为double类型
%% 取出相应训练集和测试集  
test_0=1; train_0=1;
for i=1:c
    for k=1:m
        % 取出训练集
        if k<=train_num
           temptVec(1,:)=dataBase(i,k,:);
           train_data(train_0,:)=temptVec/norm(temptVec);%归一化数据
           train_label(train_0,1)=i;%记录训练集的类标
           train_0=train_0+1;  
        else
        % 取出测试集
           temptVec(1,:)=dataBase(i,k,:);
           test_data(test_0,:)=temptVec/norm(temptVec);
           test_label(test_0,1)=i;%记录测试集的类标
           test_0=test_0+1; 
        end
    end
end

clear dataBase temptVec train_0 test_0 k i j;
clear filename folder;
%% 请在下面添加你的代码：





