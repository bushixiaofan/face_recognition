clc;
clear all;
%% 数据说明：
% train_data:训练数据   
% train_label:训练数据对应的类标
% test_data:测试数据
% test_label:每个测试数据的类标
% c:本数据库总的类别数
% 读取数据时，使用每个类别中前train_num个数据作为训练数据，剩下的数据作为测试数据
%%

c=68;%这个数据库总的类别数
train_num=10;%每个个体的训练样本数目

load('PIE_32x32');%加载数据库

test_0=1; train_0=1; index=1; k=1;
for i=1:size(gnd,1)   
    fprintf('The %dth sample is loading...\t\n',i);
    %取出前train_num个数据作为训练样本
    if k<=train_num
       tempVec(1,:)=fea(index,:);
       train_data(train_0,:)=tempVec(:)/norm(tempVec);
       train_label(train_0)=gnd(index);
       train_0=train_0+1;  
    else
    %剩下的数据作为测试样本
       tempVec(1,:)=fea(index,:);
       test_data(test_0,:)=tempVec(:)/norm(tempVec);
       test_label(test_0)=gnd(index);
       test_0=test_0+1; 
    end
    if i~=size(gnd,1) && gnd(index)~=gnd(index+1)
       k=0;
    end
    index=index+1;
    k=k+1;
end

clear fea gnd i index tempVec;
clear test_0 train_0 k; 
%% 请在下面添加你要写的代码：




