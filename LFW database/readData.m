
%% 数据说明：
% train_num:每个类别的训练样本数
% train_data:训练数据,每个数据都转换成一个列向量   
% train_label:训练数据对应的类标
% test_data:测试数据,每个数据都转换成一个列向量   
% test_label:每个测试数据的类标
% 读取数据时，使用每个类别中前train_num个数据作为训练数据，剩下的数据作为测试数据
%%
clc;
clear all;

%% 读取数据，使用每一个体随机取 每类的样本总数 一半向下取整个的数据进行训练，剩下的数据进行测试
% 取出相应训练集和测试集
% load('LFW.mat')%加载 LFW 数据库数据
% train_data=LFW(:,trainIdx);
% train_label=gnd(trainIdx);
% test_data=LFW(:,testIdx);
% test_label=gnd(testIdx);
% 
% clear testIdx trainIdx;
% clear LFW fea gnd;
% clear num a b i;
%% 读取数据，固定使用每一类前 train_num 个数据进行训练，剩下的数据进行测试
% 取出相应训练集和测试集
train_num=1;      %选取固定的训练样本个数,这个数值不能超过11
load('LFW.mat');   %加载 LFW 数据库数据
index=1;
test_index=1; train_index=1;
k=1;
for i=1:size(gnd,1)   
    fprintf('the %dth data is loading...\t\n',i);
    if k<=train_num
       tempVec(:,1)=LFW(:,index);
       train_data(:,train_index)=tempVec(:)/norm(tempVec);%数据归一化处理
       train_label(train_index)=gnd(index);%训练样本数据的类标
       train_index=train_index+1;  
    else
       tempVec(:,1)=LFW(:,index);
       test_data(:,test_index)=tempVec(:)/norm(tempVec);%数据归一化处理
       test_label(test_index)=gnd(index);%测试样本的数据类标
       test_index=test_index+1; 
    end
    if i~=size(gnd,1) && gnd(index)~=gnd(index+1)
       k=0;
    end
    index=index+1;
    k=k+1;
end

clear train_index test_index;
clear tempVec testIdx trainIdx;
clear index k i a b;
clear LFW fea num gnd;
%% 请在下面写自己的程序：



























