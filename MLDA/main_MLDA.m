function varargout = main_MLDA(varargin)
% MAIN_MLDA MATLAB code for main_MLDA.fig
%      MAIN_MLDA, by itself, creates a new MAIN_MLDA or raises the existing
%      singleton*.
%
%      H = MAIN_MLDA returns the handle to a new MAIN_MLDA or the handle to
%      the existing singleton*.
%
%      MAIN_MLDA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MLDA.M with the given input arguments.
%
%      MAIN_MLDA('Property','Value',...) creates a new MAIN_MLDA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_MLDA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_MLDA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_MLDA

% Last Modified by GUIDE v2.5 10-Jul-2013 09:22:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_MLDA_OpeningFcn, ...
                   'gui_OutputFcn',  @main_MLDA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main_MLDA is made visible.
function main_MLDA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_MLDA (see VARARGIN)

% Choose default command line output for main_MLDA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes main_MLDA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_MLDA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%读取所有的测试样本，并显示所有的测试样本
%class 为每个训练样本所对应的类别
%test为测试样本
%testname为测试样本的文件名
%samples 为训练样本
%names为训练样本的文件名
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get default command line output from handles structure
global class;
global test;
global testname;
global train;
global names;
global targets;
% [class test testname samples names] = face_data();
% m = size(testname,2);
% n = ceil(m/5);
% axes(handles.axes1); 
% for i = 1:m
%     I = imread(testname{i});
%     subplot(5,n,i);
%     imshow(I);
%     hold on;
% end
% %uiwait(handles.figure1)

path = {'TrainingData\','TestingData\'};
test = [];   %测试样本
file = dir(path{2});
N = numel(file)-2;  %测试样本数
n = ceil(N/5);
%axes(handles.axes1); 
for i = 1:N
    testname{i} = strcat(path{2},sprintf('%d',i),'.bmp');
    I = imread(testname{i});
    
    subplot(5,n,i);
    imshow(I);
    hold on;
    I = im2double(I);
    [height width] = size(I);
    temp = reshape(I,1,height*width);    %将读入的图像数据转为行向量
    test = [test;temp];
end


class = [];
targets = [];
file = dir(path{1});
C = numel(file)-2;  %训练类别数
for i = 1:C
    filepath = strcat(path{1},sprintf('%d',i),'\');
    files = dir(filepath);
    M = numel(files)-2;
    samples = [];   %各类训练样本
    for  j = 1:M
        names{i,j} = strcat(filepath,sprintf('%d',j),'.bmp');
        targets = [targets i];  %标记每一个训练样本所属的类别
        I = imread(names{i,j});
        I = im2double(I);
        [height width] = size(I);
        temp = reshape(I,1,height*width);    %将读入的图像数据转为行向量
        samples = [samples;temp];
    end
    class(i) = i;
    train{i} = samples;
end



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global class;
global test;
global testname;
global train;
global names;
global targets;

%W = MLDA(train);
C = size(train,2);
X = [];   %所有的训练样本
for i = 1:C
    X = [X;train{i}];
    num(i) = size(train{i},1);   %各类样本的样本数
end
[W newTrain] = MLDA(train);
%save xiangliangw w
%[W newTrain] = MultipleDiscriminantAnalysis(X', targets);
%save xiangliang W
newTest = W*test';
for i=1:size(newTest,2)
    [d pos] =  Distance(newTrain,newTest(:,i));
    testClass(i) = targets(pos);
end
B = unique(testClass);
times = histc(testClass,B);
for i = 1:size(B,2)
    figure;
    q  = ceil(times(i)/3);
    k = 0;
    for j=1:size(testClass,2)
        if find(B(i) == testClass(j))
            k = k + 1;
            I = imread(testname{j});
            subplot(3,q,k);
            imshow(I);
            class = sprintf('%d',testClass(j));
            title(strcat(class,'--',testname{j}));
            hold on;
            clc;
        end
    end
end 



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1); 