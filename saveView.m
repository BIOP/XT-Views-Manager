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

% Last Modified by GUIDE v2.5 20-Jun-2017 17:17:31

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

handles.ImarisApp = varargin{1};
handles.current_index = 1;
handles.view = {};
set(handles.list_views,'String', {});
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
contents = cellstr(get(handles.list_views,'String'));

if(get(handles.chk_reset_extents,'Value') == 1)
    ResetExtents(handles.ImarisApp);
end
% Get size of current table
i = size(handles.view,2);
contents{i+1,1} = sprintf('View %2.f', i+1);

handles.view{i+1} = storeSceneProperties(handles.ImarisApp);

set(handles.list_views,'String', contents);

guidata(hObject, handles);


% --- Executes on button press in btn_load_view.
function btn_load_view_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.chk_reset_extents,'Value') == 1)
    ResetExtents(handles.ImarisApp);
end
applySceneProperties(handles.ImarisApp, handles.view{get(handles.list_views,'Value')});


% --- Executes on button press in btn_delete.
function btn_delete_Callback(hObject, eventdata, handles)
% hObject    handle to btn_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = (get(handles.list_views,'String'));
if size(handles.view,2) == 1
    names = [];
    handles.view = {};
    contents = [];
end
if ~isempty(handles.current_index)&&~isempty(contents)
    contents(handles.current_index) = [];
    names = cellstr(contents);
    handles.view(handles.current_index) = [];
    for i=1:size(names,1)
        names{i} = sprintf('View %2.f', i);
    end
end
set(handles.list_views,'String', names,'Value',1);
handles.current_index=1;
guidata(hObject, handles);



% --- Executes on selection change in list_views.
function list_views_Callback(hObject, eventdata, handles)
% hObject    handle to list_views (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_views contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_views

handles.current_index = get(hObject,'Value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function list_views_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_views (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_import.
function btn_import_Callback(hObject, eventdata, handles)
% hObject    handle to btn_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile('*.m','Load Settings');
D = load([PathName FileName], '-mat');

set(handles.list_views,'String', D.names_list);
handles.view = D.view;
guidata(hObject, handles);


% --- Executes on button press in btn_export.
function btn_export_Callback(hObject, eventdata, handles)
% hObject    handle to btn_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uiputfile('settings.m','Export Views');

% Save the cell array and the list with the names
names_list = get(handles.list_views,'String');
view = handles.view;
save([PathName FileName],'names_list', 'view');


function ResetExtents(ImarisApp)

aDataSet = ImarisApp.GetDataSet;

extentMin = [aDataSet.GetExtendMinX, aDataSet.GetExtendMinY, aDataSet.GetExtendMinZ];
extentMax = [aDataSet.GetExtendMaxX, aDataSet.GetExtendMaxY, aDataSet.GetExtendMaxZ];

aDataSet.SetExtendMinX(0);
aDataSet.SetExtendMinY(0);
aDataSet.SetExtendMinZ(0);
aDataSet.SetExtendMaxX(extentMax(1)-extentMin(1));
aDataSet.SetExtendMaxY(extentMax(2)-extentMin(2));
aDataSet.SetExtendMaxZ(extentMax(3)-extentMin(3));

function cam = storeSceneProperties(ImarisApp)
camera = ImarisApp.GetSurpassCamera;
cam.focus = camera.GetFocus;
cam.height = camera.GetHeight;
cam.ori = camera.GetOrientationQuaternion;
cam.orth = camera.GetOrthographic;
cam.persp = camera.GetPerspective;
cam.pos = camera.GetPosition;

function applySceneProperties(ImarisApp, cam)
camera = ImarisApp.GetSurpassCamera;
camera.SetFocus(cam.focus);
camera.SetHeight(cam.height);
camera.SetOrientationQuaternion(cam.ori);
camera.SetOrthographic(cam.orth);
camera.SetPerspective(cam.persp);
camera.SetPosition(cam.pos);


% --- Executes on button press in chk_reset_extents.
function chk_reset_extents_Callback(hObject, eventdata, handles)
% hObject    handle to chk_reset_extents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_reset_extents
