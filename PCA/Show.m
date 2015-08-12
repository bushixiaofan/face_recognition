function varargout = Show(varargin)
% SHOW M-file for Show.fig
%      SHOW by itself, creates a new SHOW or raises the
%      existing singleton*.
%
%      H = SHOW returns the handle to a new SHOW or the handle to
%      the existing singleton*.
%
%      SHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW.M with the given input arguments.
%
%      SHOW('Property','Value',...) creates a new SHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Show_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Show_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Show

% Last Modified by GUIDE v2.5 03-Jul-2013 09:11:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Show_OpeningFcn, ...
                   'gui_OutputFcn',  @Show_OutputFcn, ...
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

% --- Executes just before Show is made visible.
function Show_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Show (see VARARGIN)

% Choose default command line output for Show
handles.output = 'Yes';
handles.bool = 0;

% Update handles structure
guidata(hObject, handles);
 

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end

% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap
load dialogicons.mat

IconData=questIconData;
questIconMap(256,:) = get(handles.figure1, 'Color');
IconCMap=questIconMap;

set(handles.figure1, 'Colormap', IconCMap);

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes Show wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Show_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%打开一个文件并显示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global pathName;  %测试样本的文件路径
global fileName;  %测试样本的文件名
global names;  %训练样本文件名
global T; %训练样本
global K;

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
if handles.bool == 0
    K = 1; %训练样本个数
    dimension = 20;
    files=dir('orl\');   %Read files information in the folder
    N = numel(files);  %the number of the segmentate images
    T = [];
    for i = 3:N    % 训练样本文件夹个数
        s = files(i).name;
        path = strcat('orl\',s,'\');  %跳转到子文件夹
        file = dir(path);
        M = numel(file);
        for j = 3:M     %获取每一个子文件夹下的文件，并将其矩阵向量化
            names{K} = strcat(path,file(j).name);
            I = imread(names{K});
            [height width] = size(I);
            temp=reshape(I,height*width,1);
            T = [T temp];
            K = K + 1;
        end
    end
end
[fileName,pathName]=uigetfile(...
    { '*.pgm','PGM(*.pgm)';...
     '*.bmp','BMP(*.bmp)';...
     '*.jpg','JPG(*.jpg)';...
    '*.*','All Files(*.*)'},...
    'Select ');
filePath=[pathName fileName];
if fileName == 0
    msgbox('Please select a file!','Message');
else
    handles.bool = 1;         %控制执行一次，只对训练样本PCA一次，减少运行时间
    guidata(hObject,handles);
end
origImage=imread(filePath);
axes(handles.axes2);
imshow(origImage);      %显示图像
set(handles.edit1,'string',fileName);
uiwait(handles.figure1);
cla(handles.axes2,'reset');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathName;
global fileName;
global names;
global train;
global z;
global K;
global T;  
global resultDis;  %测试样本和样本库中每一个样本的距离
z = 0;
if pathName == 0
    msgbox('Please select a file!','Message');
end
files=dir(pathName);   %Read files information in the folder
N = numel(files);  %the number of the segmentate images
pos = 0;
for i = 3:N    % 测试样本文件个数，将其矩阵向量化
    s = files(i).name;
    if strcmpi(s,fileName)
        pos = i-2;
    end
    name{i-2} = strcat(pathName,s);
    I = imread(name{i-2});
    [height width] = size(I);
    temp=reshape(I,height*width,1);
    T = [T temp];
end
[matrixPCA M A]= TestPCA(T,0.95);

AvgImg = reshape(M,height,width);
AvgImgInt=uint8(AvgImg);
axes(handles.axes12);
imshow(AvgImgInt)%显示平均脸 



train = matrixPCA(:,1:K-1);
test = matrixPCA(:,K:K+N-3);
x = size(train,1);
for i = 1:K-1
    distance(i) = Distance(train(:,i),test(:,pos));
end
[dis index] = sort(distance);   %对距离排序，并记住索引
resultDis = [index' dis'];

% testPca = test(:,pos);
% if size(testPca,1)< 190
%     for i = size(testPca,1):190
%         testPca(i) = 0;
%     end
% end
% for p = 1:19
%     for q = 1:10
%         tpca(p,q) = testPca((p-1)*10 + q);
%     end
% end
train = A(:,1:K-1);

%隐藏的部分用来显示最终降维后的结果
% test = A(:,K:K+N-3);
% testPca = test(:,pos);
% tpca = reshape(testPca,height,width);
% tpca =uint8(tpca);
% 
% axes(handles.axes12);
% imshow(tpca);
% for i = 1:4
%     img = imread(names{resultDis(i,1)});
%     trainPca = train(:,resultDis(i,1));
%     if size(trainPca,1)< 190
%         for j = size(trainPca,1):190
%             trainPca(j) = 0;
%         end
%     end
%     for p = 1:19
%         for q = 1:10
%             Ipca(p,q) = trainPca((p-1)*10 + q);
%         end
%     end
%     if rem(i,4) == 0
%         axes(handles.axes11);
%         imshow(img);
%         axes(handles.axes16);
%         imshow(Ipca);
%     end
%     if rem(i,4) == 1
%         axes(handles.axes3);
%         imshow(img);
%         axes(handles.axes13);
%         imshow(Ipca);
%     end
%     if rem(i,4) == 2
%         axes(handles.axes9);
%         imshow(img);
%         axes(handles.axes14);
%         imshow(Ipca);
%     end
%     if rem(i,4) == 3
%         axes(handles.axes10);
%         imshow(img);
%         axes(handles.axes15);
%         imshow(Ipca);
%     end
%     z = z + 1;
% end
%如果想显示最终降维后的结果，只需将上面的部分取消注释，并注释一下部分就行
for i = 1:4
    img = imread(names{resultDis(i,1)});
    trainPca = train(:,resultDis(i,1));
    Ipca = reshape(trainPca,height,width);
    Ipca =uint8(Ipca);
    if rem(i,4) == 0
        axes(handles.axes11);
        imshow(img);
        axes(handles.axes16);
        imshow(Ipca);
    end
    if rem(i,4) == 1
        axes(handles.axes3);
        imshow(img);
        axes(handles.axes13);
        imshow(Ipca);
    end
    if rem(i,4) == 2
        axes(handles.axes9);
        imshow(img);
        axes(handles.axes14);
        imshow(Ipca);
    end
    if rem(i,4) == 3
        axes(handles.axes10);
        imshow(img);
        axes(handles.axes15);
        imshow(Ipca);
    end
    z = z + 1;
end
%到此为止

uiwait(handles.figure1);
cla(handles.axes3,'reset');
cla(handles.axes9,'reset');
cla(handles.axes10,'reset');
cla(handles.axes11,'reset');
cla(handles.axes12,'reset');
cla(handles.axes13,'reset');
cla(handles.axes14,'reset');
cla(handles.axes15,'reset');
cla(handles.axes16,'reset');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global names;
global z;
global train;
global resultDis;
 i = z + 1;
% if i < 36
%     for i = z + 1:z + 5
%         img = imread(names{resultDis(i,1)});
%         trainPca = train(:,resultDis(i,1));
%         if size(trainPca,1)< 190
%             for j = size(trainPca,1):190
%                 trainPca(j) = 0;
%             end
%         end
%         for p = 1:19
%             for q = 1:10
%                 Ipca(p,q) = trainPca((p-1)*10 + q);
%             end
%         end
%         if rem(i,4) == 0
%             axes(handles.axes11);
%             imshow(img);
%             axes(handles.axes16);
%             imshow(Ipca);
%         end
%         if rem(i,4) == 1
%             axes(handles.axes3);
%             imshow(img);
%             axes(handles.axes13);
%             imshow(Ipca);
%         end
%         if rem(i,4) == 2
%             axes(handles.axes9);
%             imshow(img);
%             axes(handles.axes14);
%             imshow(Ipca);
%         end
%         if rem(i,4) == 3
%             axes(handles.axes10);
%             imshow(img);
%             axes(handles.axes15);
%             imshow(Ipca);
%         end
%             z = z + 1;
%     end
%同上
if i < 36
    for i = z + 1:z + 5
        img = imread(names{resultDis(i,1)});
        [height width] = size(img);
        trainPca = train(:,resultDis(i,1));
        Ipca = reshape(trainPca,height,width);
        Ipca =uint8(Ipca);
        if rem(i,4) == 0
            axes(handles.axes11);
            imshow(img);
            axes(handles.axes16);
            imshow(Ipca);
        end
        if rem(i,4) == 1
            axes(handles.axes3);
            imshow(img);
            axes(handles.axes13);
            imshow(Ipca);
        end
        if rem(i,4) == 2
            axes(handles.axes9);
            imshow(img);
            axes(handles.axes14);
            imshow(Ipca);
        end
        if rem(i,4) == 3
            axes(handles.axes10);
            imshow(img);
            axes(handles.axes15);
            imshow(Ipca);
        end
            z = z + 1;
    end
    %到此为止
else
    msgbox('It is the last page!','Message');
end
uiwait(handles.figure1);
cla(handles.axes3,'reset');
cla(handles.axes9,'reset');
cla(handles.axes10,'reset');
cla(handles.axes11,'reset');
cla(handles.axes13,'reset');
cla(handles.axes14,'reset');
cla(handles.axes15,'reset');
cla(handles.axes16,'reset');



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
