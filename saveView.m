function varargout = saveView(varargin)
% SAVEVIEW MATLAB code for saveView.fig
%      SAVEVIEW, by itself, creates a new SAVEVIEW or raises the existing
%      singleton*.
%
%      H = SAVEVIEW returns the handle to a new SAVEVIEW or the handle to
%      the existing singleton*.
%
%      SAVEVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEVIEW.M with the given input arguments.
%
%      SAVEVIEW('Property','Value',...) creates a new SAVEVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saveView_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saveView_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saveView

% Last Modified by GUIDE v2.5 20-Jun-2017 12:53:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saveView_OpeningFcn, ...
                   'gui_OutputFcn',  @saveView_OutputFcn, ...
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


% --- Executes just before saveView is made visible.
function saveView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saveView (see VARARGIN)

% Choose default command line output for saveView
handles.output = hObject;

handles.X = EasyXT;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saveView wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = saveView_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_save_view.
function btn_save_view_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.X.storeSceneProperties;


% --- Executes on button press in btn_load_view.
function btn_load_view_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.X.applySceneProperties;
