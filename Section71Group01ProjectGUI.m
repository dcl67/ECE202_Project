function varargout = Section71Group01ProjectGUI(varargin)
% SECTION71GROUP01PROJECTGUI MATLAB code for Section71Group01ProjectGUI.fig
%      SECTION71GROUP01PROJECTGUI, by itself, creates a new SECTION71GROUP01PROJECTGUI or raises the existing
%      singleton*.
%
%      H = SECTION71GROUP01PROJECTGUI returns the handle to a new SECTION71GROUP01PROJECTGUI or the handle to
%      the existing singleton*.
%
%      SECTION71GROUP01PROJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION71GROUP01PROJECTGUI.M with the given input arguments.
%
%      SECTION71GROUP01PROJECTGUI('Property','Value',...) creates a new SECTION71GROUP01PROJECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section71Group01ProjectGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section71Group01ProjectGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section71Group01ProjectGUI

% Last Modified by GUIDE v2.5 31-Jul-2015 17:31:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section71Group01ProjectGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Section71Group01ProjectGUI_OutputFcn, ...
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


% --- Executes just before Section71Group01ProjectGUI is made visible.
function Section71Group01ProjectGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section71Group01ProjectGUI (see VARARGIN)

% Choose default command line output for Section71Group01ProjectGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section71Group01ProjectGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section71Group01ProjectGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openSerial.
function openSerial_Callback(hObject, eventdata, handles)
% hObject    handle to openSerial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in closeSerial.
function closeSerial_Callback(hObject, eventdata, handles)
% hObject    handle to closeSerial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in easydifficulty.
function easydifficulty_Callback(hObject, eventdata, handles)
% hObject    handle to easydifficulty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in harddifficulty.
function harddifficulty_Callback(hObject, eventdata, handles)
% hObject    handle to harddifficulty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
