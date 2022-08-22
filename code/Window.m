function varargout = Window(varargin)
% WINDOW MATLAB code for Window.fig
%      WINDOW, by itself, creates a new WINDOW or raises the existing
%      singleton*.
%
%      H = WINDOW returns the handle to a new WINDOW or the handle to
%      the existing singleton*.
%
%      WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW.M with the given input arguments.
%
%      WINDOW('Property','Value',...) creates a new WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Window

% Last Modified by GUIDE v2.5 06-Jun-2017 12:08:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Window_OpeningFcn, ...
                   'gui_OutputFcn',  @Window_OutputFcn, ...
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


% --- Executes just before Window is made visible.
function Window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Window (see VARARGIN)

% Choose default command line output for Window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% -------------------------

% Load black image
background = imread('guiImages/black.png');
panax = axes('Units','normal', 'Position', [0 0 1 1], 'Parent', handles.uipanel1);
imshow(background,'Parent',panax);
% Load button mapping
buttons = imread('guiImages/buttons.png');
buttonAxes = axes('Units','normal', 'Position', [0 0 1 1], 'Parent', handles.uipanel2);
imshow(buttons,'Parent',buttonAxes);
% Set text
set(handles.text15,'string','Drücke Enter zum starten','Foregroundcolor',[1 0 0]);
set(handles.text8,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text9,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text10,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text11,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text12,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text17,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text18,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text20,'string','-','Foregroundcolor',[1 0 0]);
set(handles.text21,'string','');
set(handles.text22,'string','');
set(handles.text23,'string','');
set(handles.text24,'string','');
set(handles.text25,'string','');
set(handles.text26,'string','');
% Name Enter
set(handles.edit1,'Visible','off');
% GUI
data = get(handles.figure1, 'UserData');
data.imagePanel = handles.uipanel1;
data.buttonPanel = handles.uipanel2;
data.panelAxes = panax;
data.panelButtonAxes = buttonAxes;
data.humanAnswer = handles.text8;
data.machineAnswer = handles.text9;
data.groundTruth = handles.text10;
data.humanTime = handles.text11;
data.machineTime = handles.text12;
data.counter = handles.text15;
data.currentRound = handles.text20;
data.humanPoints = handles.text17;
data.machinePoints = handles.text18;
% Language specific texts
data.roundsTextPanel = handles.text19;
data.humanTextPanel = handles.text2;
data.machineTextPanel = handles.text3;
data.classTextPanel = handles.text4;
data.timeTextPanel = handles.text6;
data.pointsTextPanel = handles.text16;
data.groundTruthTextPanel = handles.text14;
% Language specific outputs
data.drawTextOutput = 'Unentschieden';
data.winTextOutput = 'Du gewinnst';
data.loseTextOutput = 'Du verlierst';
data.catTextOutput = 'Katze';
data.dogTextOutput = 'Hund';
data.fishTextOutput = 'Fisch';
data.humanTextOutput = 'Mensch';
data.BeforeStartTextOutput = 'Drücke Enter zum starten';
data.NextRoundTextOutput = 'Drücke Enter für die nächste Runde';
% Name Enter
data.nameInputEditText = handles.edit1;
% HighScoreTable
if exist('HighScore.mat', 'file') == 2
    load('HighScore.mat');
    data.highScoreTable = HS;
    set(handles.figure1,'UserData',data);
else
    HS = [{0,'-'};{0,'-'};{0,'-'};{0,'-'};{0,'-'};{0,'-'}];
    save('HighScore','HS');
    data.highScoreTable = HS;
    set(handles.figure1,'UserData',data);
end;
% HighScore table
data.highScorePointsText0 = handles.text2;
data.highScorePointsText1 = handles.text21;
data.highScorePointsText2 = handles.text8;
data.highScorePointsText3 = handles.text22;
data.highScorePointsText4 = handles.text11;
data.highScorePointsText5 = handles.text23;
data.highScorePointsText6 = handles.text17;
data.highScoreNameText0 = handles.text3;
data.highScoreNameText1 = handles.text24;
data.highScoreNameText2 = handles.text9;
data.highScoreNameText3 = handles.text25;
data.highScoreNameText4 = handles.text12;
data.highScoreNameText5 = handles.text26;
data.highScoreNameText6 = handles.text18;
% Game status
data.isGameOver = false;
data.enterName = false;
data.showHighScore = false;
data.keysDCOpen = false;
data.inWaitStatus = false;
data.humanHasAnswered = false;
data.machineHasAnswered = false;
data.MachineAnswer = 'EMPTY';
data.round = 0;
data.humanPts = 0;
data.machinePts = 0;
data.currentGroundTruth = '';
% Average time
data.reactionTimesHuman = [];
data.reactionTimesMachine = [];
% Random Generator
data.randStream = RandStream('mt19937ar','Seed','shuffle');
% Time computation
data.humanStartTime = datevec(now);
data.humanEndTime = datevec(now);
% Classifier
data.classifier = load('TrainedClassifer');
% Save variables
set(handles.figure1,'UserData',data);  %save it back before return
% Hide Statistics
data2 = get(handles.figure1, 'UserData');
setStatVisibility(data2,'off');

% UIWAIT makes Window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

data = get(handles.figure1, 'UserData');
name = data.nameInputEditText.String;
if(~isempty(name))
    set(data.nameInputEditText,'Visible','off');
    set(data.nameInputEditText,'Enable','off');
    set(data.nameInputEditText,'String','');
    % Save name and points
    data.highScoreTable = [data.highScoreTable;{data.humanPts,name}];
    set(handles.figure1,'UserData',data);
    % Sort HighScore Table
    data.highScoreTable = sortrows(data.highScoreTable);
    set(handles.figure1,'UserData',data);
    data.highScoreTable = flipud(data.highScoreTable);
    set(handles.figure1,'UserData',data);
    % Use first 6 entries
    data.highScoreTable = data.highScoreTable(1:6,:);
    set(handles.figure1,'UserData',data);
    % Update HighScore Table
    showHighScore(data,true);
    % Save new High Score
    HS = data.highScoreTable;
    save('HighScore','HS');
    % Set game over
    data.isGameOver = true;
    set(handles.figure1,'UserData',data);
    return;
else
    return;
end;


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
