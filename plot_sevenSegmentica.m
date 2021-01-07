% plot_sevenSegmentica() - An EEGLAB plugin to perform ICA demo. see
%                          pop_sevenSegmentica() help for detail.

% History:
% 10/08/2020 Makoto. Updated.
% 06/14/2019 Makoto. Created.

% Copyright (C) 2019, Makoto Miyakoshi (mmiyakoshi@ucsd.edu) , SCCN,INC,UCSD
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
% THE POSSIBILITY OF SUCH DAMAGE.

function varargout = plot_sevenSegmentica(varargin)
% PLOT_SEVENSEGMENTICA MATLAB code for plot_sevenSegmentica.fig
%      PLOT_SEVENSEGMENTICA, by itself, creates a new PLOT_SEVENSEGMENTICA or raises the existing
%      singleton*.
%
%      H = PLOT_SEVENSEGMENTICA returns the handle to a new PLOT_SEVENSEGMENTICA or the handle to
%      the existing singleton*.
%
%      PLOT_SEVENSEGMENTICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_SEVENSEGMENTICA.M with the given input arguments.
%
%      PLOT_SEVENSEGMENTICA('Property','Value',...) creates a new PLOT_SEVENSEGMENTICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_sevenSegmentica_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_sevenSegmentica_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_sevenSegmentica

% Last Modified by GUIDE v2.5 13-Jun-2019 18:39:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_sevenSegmentica_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_sevenSegmentica_OutputFcn, ...
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


% --- Executes just before plot_sevenSegmentica is made visible.
function plot_sevenSegmentica_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_sevenSegmentica (see VARARGIN)

% Obtain precalculated data.
try
    sevenSegmenticaData = evalin('base', 'sevenSegmenticaData');
catch
    error('Please press ''Mix them'' button first.')
end

% Set the popup memu.
originalSignalIdx = find(var(sevenSegmenticaData.sourceActivations,0,2)>0);
icIdxList = '';
for originalSignalIdxIdx = 1:length(originalSignalIdx)
    icIdxList = [icIdxList ['Input signal: "' num2str(originalSignalIdx(originalSignalIdxIdx)) '"']];
    if originalSignalIdxIdx ~= length(originalSignalIdx)
        icIdxList = sprintf([icIdxList '\n']);
    end
end

groundTruthIdxPopupmenuHandle = findobj('tag', 'groundTruthIdxPopupmenu');
set(groundTruthIdxPopupmenuHandle, 'String', icIdxList);

% Choose default command line output for plot_sevenSegmentica
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_sevenSegmentica wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_sevenSegmentica_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function groundTruthIdxPopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to groundTruthIdxPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in groundTruthIdxPopupmenu.
function groundTruthIdxPopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to groundTruthIdxPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns groundTruthIdxPopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from groundTruthIdxPopupmenu


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Obtain precalculated data. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    sevenSegmenticaData = evalin('base', 'sevenSegmenticaData');
catch
    error('Please press ''Mix them'' button first.')
end
groundTruthSignals = sevenSegmenticaData.sourceActivations;
mixedNoScaling     = sevenSegmenticaData.mixedNoScaling;
icasphere          = sevenSegmenticaData.icasphere;
icaweights         = sevenSegmenticaData.icaweights;
constantMultiplyer = sevenSegmenticaData.constantMultiplyer;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot source activation. %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
originalSignalIdx = find(var(groundTruthSignals,0,2)>0);
groundTruthIdxHandle = findobj('tag', 'groundTruthIdxPopupmenu');
userInputIdx = get(groundTruthIdxHandle, 'value');
currentlySelectedGroundTruthIdx = originalSignalIdx(userInputIdx);

% Overlay signals.
mixedNoScalingDemeaned = bsxfun(@minus, mixedNoScaling, mean(mixedNoScaling,2));
estimatedSources = icaweights*icasphere*mixedNoScalingDemeaned;
estimatedSources = bsxfun(@rdivide, estimatedSources, std(estimatedSources,[],2));
meanSd = mean(std(estimatedSources,0,2));
offsetDC = repmat([(1:7)*meanSd*constantMultiplyer]', [1 length(mixedNoScalingDemeaned)]);
currentlySelectedGroundTruth  = groundTruthSignals(currentlySelectedGroundTruthIdx,:);
overlaySelectedGroundTruth    = repmat(currentlySelectedGroundTruth, [7 1]) + offsetDC;
% overlaySelectedGroundTruth    = currentlySelectedSignalRepmat/diminishingConstant+offsetDC;
set(findobj('tag', 'overlaySignal1'), 'YData', overlaySelectedGroundTruth (1,:))
set(findobj('tag', 'overlaySignal2'), 'YData', overlaySelectedGroundTruth (2,:))
set(findobj('tag', 'overlaySignal3'), 'YData', overlaySelectedGroundTruth (3,:))
set(findobj('tag', 'overlaySignal4'), 'YData', overlaySelectedGroundTruth (4,:))
set(findobj('tag', 'overlaySignal5'), 'YData', overlaySelectedGroundTruth (5,:))
set(findobj('tag', 'overlaySignal6'), 'YData', overlaySelectedGroundTruth (6,:))
set(findobj('tag', 'overlaySignal7'), 'YData', overlaySelectedGroundTruth (7,:))

% Update the sample 7seg display.
sample7SegHandle = findobj('tag', 'sample7SegAxes');
draw7SegNumbers(sample7SegHandle, currentlySelectedGroundTruthIdx, 1);

% Compute correlation coefficient and PVAF.
corrCoeffList = zeros(7,1);
ic1TextHandle = findobj('tag', 'ic1LineText');
corrCoeffMatrix = corr([estimatedSources(1,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic1TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(1) = corrCoef;

ic2TextHandle = findobj('tag', 'ic2LineText');
corrCoeffMatrix = corr([estimatedSources(2,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic2TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(2) = corrCoef;

ic3TextHandle = findobj('tag', 'ic3LineText');
corrCoeffMatrix = corr([estimatedSources(3,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic3TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(3) = corrCoef;

ic4TextHandle = findobj('tag', 'ic4LineText');
corrCoeffMatrix = corr([estimatedSources(4,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic4TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(4) = corrCoef;

ic5TextHandle = findobj('tag', 'ic5LineText');
corrCoeffMatrix = corr([estimatedSources(5,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic5TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(5) = corrCoef;

ic6TextHandle = findobj('tag', 'ic6LineText');
corrCoeffMatrix = corr([estimatedSources(6,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic6TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(6) = corrCoef;

ic7TextHandle = findobj('tag', 'ic7LineText');
corrCoeffMatrix = corr([estimatedSources(7,:)' currentlySelectedGroundTruth']);
corrCoef = corrCoeffMatrix(1,2);
set(ic7TextHandle, 'string', sprintf('r=%.2f', corrCoef), 'ForegroundColor', [0 0 0.4]);
corrCoeffList(7) = corrCoef;

[~, maxCorrIdx] = max(corrCoeffList);
excusingString = sprintf('set(ic%.0fTextHandle, ''ForegroundColor'', [1 0 0])', maxCorrIdx);
eval(excusingString)