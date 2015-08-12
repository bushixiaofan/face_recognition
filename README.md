# face_recognition
A project of face recognition of pattern classification.

1. 任务说明：
对LFW，SCface，Extend_YaleB和CMU PIE四个数据库的人脸分类识别。
要求完成四个数据库中的所有人脸数据库的识别任务，分类识别正确率越高越好。

2. 数据说明：
(1) LFW人脸数据库两种实验方式：
      1>分别选取每个个体的前M个人脸图像作为训练数据，其余的人脸图像作为测试数据，M不大于9
      2>随机选取每个个体样本总数的一半人脸图像行训练，剩下的人脸图像作为测试数据(程序都给出)
(2) SCface，Extend_YaleB和CMU PIE人脸数据实验方式：
      分别选取每个个体的前M个人脸作为训练数据，其余的人脸图像作为测试数据  
(3) Extend_YaleB人脸数据实验结果要求：
      分别选取每个个体的前M个人脸图像作为训练数据
      要求统计出训练样本个数M为5,10,20,30时，识别正确率分别为多少

 (4) CMU PIE人脸数据实验结果要求：
      分别选取每个个体的前M个人脸图像作为训练数据
      要求统计出训练样本个数M为5,10,20,30时，识别正确率分别为多少

3 .文件说明：
readData.m 为所在文件夹中，读取人脸数据库数据的matlab程序；
LFW.mat文件:为LFW人脸数据库的子集存入mat矩阵后的数据
resized_300by300文件:为SCface人脸数据库的子集人脸图像
yaleb重新编号文件:为YaleB和Extended_YaleB人脸数据库子集人脸图像
PIE_32x32.mat:为CMU_PIE人脸数据库的子集存入mat矩阵后的数据

