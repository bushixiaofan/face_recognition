function [class test testname samples names] = face_data()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%读取测试样本和训练样本，并返回矩阵向量化后的人脸数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path = {'TrainingData\','TestingData\'};
samples = [];   %各类训练样本
class = [];
file = dir(path{1});
C = numel(file)-2;  %训练类别数
for i = 1:C
    filepath = strcat(path{1},sprintf('%d',i),'\');
    files = dir(filepath);
    M = numel(files)-2;
    for  j = 1:M
        names{i,j} = strcat(filepath,sprintf('%d',j),'.bmp');
        class = [class i];  %标记每一个训练样本所属的类别
        I = imread(names{i,j});
        I = im2double(I);
        [height width] = size(I);
        temp = reshape(I,1,height*width);    %将读入的图像数据转为行向量
        samples = [samples;temp];
    end
end

test = [];   %测试样本
file = dir(path{2});
N = numel(file)-2;  %训练类别数
for i = 1:N
    testname{i} = strcat(path{2},sprintf('%d',i),'.bmp');
    I = imread(testname{i});
    I = im2double(I);
    [height width] = size(I);
    temp = reshape(I,1,height*width);    %将读入的图像数据转为行向量
    test = [test;temp];
end