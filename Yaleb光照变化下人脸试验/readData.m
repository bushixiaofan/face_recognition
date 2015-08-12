
clc;
clear all;

%% ����˵����
% train_data:ѵ������,ÿ�����ݶ�ת����һ��������
% train_label:ѵ�����ݶ�Ӧ�����
% test_data:��������,ÿ�����ݶ�ת����һ��������
% test_label:ÿ���������ݵ����
% train_num:ÿ������ѵ��������
% test_num:ÿ�����Ĳ���������
% c:�����ݿ����е������
% m:ÿ��������е�������
% ��ȡ����ʱ��ʹ��ÿ�������ǰtrain_num��������Ϊѵ�����ݣ�ʣ�µ�������Ϊ��������
%%
m=64;%ÿһ����𣨸��壩�����е�������
c=38;%������ݿ��ܵ���𣨸��壩��

train_num=10;%ÿһ������ѵ��������

test_num=m-train_num;%ÿһ�����Ĳ���������

folder='yaleb���±��';
for i=1:c
    for j=1:m
        filename=[folder '\' num2str(i) '_' num2str(j) '.tif']
        dataBase(i,j,:,:)=imread(filename);
    end
end
dataBase=double(dataBase);%�������Ϊdouble����
%% ȡ����Ӧѵ�����Ͳ��Լ�  
test_0=1; train_0=1;
for i=1:c
    for k=1:m
        % ȡ��ѵ����
        if k<=train_num
           temptVec(1,:)=dataBase(i,k,:);
           train_data(train_0,:)=temptVec/norm(temptVec);%��һ������
           train_label(train_0,1)=i;%��¼ѵ���������
           train_0=train_0+1;  
        else
        % ȡ�����Լ�
           temptVec(1,:)=dataBase(i,k,:);
           test_data(test_0,:)=temptVec/norm(temptVec);
           test_label(test_0,1)=i;%��¼���Լ������
           test_0=test_0+1; 
        end
    end
end

clear dataBase temptVec train_0 test_0 k i j;
clear filename folder;
%% �������������Ĵ��룺





