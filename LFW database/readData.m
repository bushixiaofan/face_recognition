
%% ����˵����
% train_num:ÿ������ѵ��������
% train_data:ѵ������,ÿ�����ݶ�ת����һ��������   
% train_label:ѵ�����ݶ�Ӧ�����
% test_data:��������,ÿ�����ݶ�ת����һ��������   
% test_label:ÿ���������ݵ����
% ��ȡ����ʱ��ʹ��ÿ�������ǰtrain_num��������Ϊѵ�����ݣ�ʣ�µ�������Ϊ��������
%%
clc;
clear all;

%% ��ȡ���ݣ�ʹ��ÿһ�������ȡ ÿ����������� һ������ȡ���������ݽ���ѵ����ʣ�µ����ݽ��в���
% ȡ����Ӧѵ�����Ͳ��Լ�
% load('LFW.mat')%���� LFW ���ݿ�����
% train_data=LFW(:,trainIdx);
% train_label=gnd(trainIdx);
% test_data=LFW(:,testIdx);
% test_label=gnd(testIdx);
% 
% clear testIdx trainIdx;
% clear LFW fea gnd;
% clear num a b i;
%% ��ȡ���ݣ��̶�ʹ��ÿһ��ǰ train_num �����ݽ���ѵ����ʣ�µ����ݽ��в���
% ȡ����Ӧѵ�����Ͳ��Լ�
train_num=1;      %ѡȡ�̶���ѵ����������,�����ֵ���ܳ���11
load('LFW.mat');   %���� LFW ���ݿ�����
index=1;
test_index=1; train_index=1;
k=1;
for i=1:size(gnd,1)   
    fprintf('the %dth data is loading...\t\n',i);
    if k<=train_num
       tempVec(:,1)=LFW(:,index);
       train_data(:,train_index)=tempVec(:)/norm(tempVec);%���ݹ�һ������
       train_label(train_index)=gnd(index);%ѵ���������ݵ����
       train_index=train_index+1;  
    else
       tempVec(:,1)=LFW(:,index);
       test_data(:,test_index)=tempVec(:)/norm(tempVec);%���ݹ�һ������
       test_label(test_index)=gnd(index);%�����������������
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
%% ��������д�Լ��ĳ���



























