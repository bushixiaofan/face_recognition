clc;
clear all;
%% ����˵����
% train_data:ѵ������   
% train_label:ѵ�����ݶ�Ӧ�����
% test_data:��������
% test_label:ÿ���������ݵ����
% c:�����ݿ��ܵ������
% ��ȡ����ʱ��ʹ��ÿ�������ǰtrain_num��������Ϊѵ�����ݣ�ʣ�µ�������Ϊ��������
%%

c=68;%������ݿ��ܵ������
train_num=10;%ÿ�������ѵ��������Ŀ

load('PIE_32x32');%�������ݿ�

test_0=1; train_0=1; index=1; k=1;
for i=1:size(gnd,1)   
    fprintf('The %dth sample is loading...\t\n',i);
    %ȡ��ǰtrain_num��������Ϊѵ������
    if k<=train_num
       tempVec(1,:)=fea(index,:);
       train_data(train_0,:)=tempVec(:)/norm(tempVec);
       train_label(train_0)=gnd(index);
       train_0=train_0+1;  
    else
    %ʣ�µ�������Ϊ��������
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
%% �������������Ҫд�Ĵ��룺




