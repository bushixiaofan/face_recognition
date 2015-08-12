
%% ����˵����
% c:�����ݿ��ܵ������
% m��ÿ��������ܵ�������
% train_num:ÿ������ѵ��������
% train_data:ѵ������,ÿ�����ݶ�ת����һ��������
% train_label:ѵ�����ݶ�Ӧ�����
% test_data:��������,ÿ�����ݶ�ת����һ��������
% test_label:�������ݶ�Ӧ�����
% ��ȡ����ʱ��ʹ��ÿ�������ǰtrain_num��������Ϊѵ�����ݣ�ʣ�µ�������Ϊ��������
%% 
clc;
clear all;

m=9;%ÿ��������ܵ�������
c=130;%�����ݿ����ܵ������

train_num=1;%ÿ������ѵ��������
test_num=m-train_num;%ÿ�����Ĳ���������

folder='resized_300by300';
%% ���׶��������鷳�Ķ�ȡ����
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
%% �򵥵Ķ�ȡ����
dirlist = dir(folder);%��ȡ�ļ������б�
for i=3:length(dirlist)-1
    fprintf('The %dth image is loading...\t\n',i-2);
    image=imread([folder '/' dirlist(i).name]);%��ȡͼ���ļ�
    tmpImg = rgb2gray(image);%��ɫͼ��ת��Ϊ�Ҷ�ͼ��
    img=imresize(tmpImg,0.5);%��ͼ���Ϊԭͼ���һ���С��ע��ԭͼ���СΪ300*300��
    [row col]=size(img);%��ȡת����ͼ���С
    dataBase(:,i-2)=reshape(img,row*col,1);%ת��Ϊ���������ھ���
end
dataBase=double(dataBase);%�������Ϊdouble����

% ȡ����Ӧѵ�����Ͳ��Լ�
test_index=1; train_index=1;
for i=1:c
    for k=1:m
        if k<=train_num
           tmpVec(:,1)=dataBase(:,(i-1)*m+k);
           train_data(:,train_index)=tmpVec/norm(tmpVec);%���ݹ�һ��
           train_label(1,train_index)=i;%ѵ�������������
           train_index=train_index+1;
        else
           tmpVec(:,1)=dataBase(:,(i-1)*m+k);
           test_data(:,test_index)=tmpVec/norm(tmpVec);%���ݹ�һ��
           test_label(1,test_index)=i;%���������������
           test_index=test_index+1; 
        end
    end
end


clear dirlist file folder;
clear image img tmpImg tmpVec;
clear train_index test_index;
clear dataBase;
clear i k row col;
%% �������������Ĵ���




