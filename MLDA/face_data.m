function [class test testname samples names] = face_data()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ȡ����������ѵ�������������ؾ��������������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path = {'TrainingData\','TestingData\'};
samples = [];   %����ѵ������
class = [];
file = dir(path{1});
C = numel(file)-2;  %ѵ�������
for i = 1:C
    filepath = strcat(path{1},sprintf('%d',i),'\');
    files = dir(filepath);
    M = numel(files)-2;
    for  j = 1:M
        names{i,j} = strcat(filepath,sprintf('%d',j),'.bmp');
        class = [class i];  %���ÿһ��ѵ���������������
        I = imread(names{i,j});
        I = im2double(I);
        [height width] = size(I);
        temp = reshape(I,1,height*width);    %�������ͼ������תΪ������
        samples = [samples;temp];
    end
end

test = [];   %��������
file = dir(path{2});
N = numel(file)-2;  %ѵ�������
for i = 1:N
    testname{i} = strcat(path{2},sprintf('%d',i),'.bmp');
    I = imread(testname{i});
    I = im2double(I);
    [height width] = size(I);
    temp = reshape(I,1,height*width);    %�������ͼ������תΪ������
    test = [test;temp];
end