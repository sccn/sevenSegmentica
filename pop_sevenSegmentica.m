% pop_sevenSegmentica() - An EEGLAB plugin to perform ICA demo. Uses EEGLAB
%                         functions to demonstrate unmixing using ICA using
%                         seven segment display.
%
% Links to related websites:
%      Swartz Center Wiki page    https://sccn.ucsd.edu/wiki/SevenSegmenticaDemo
%      Youtube video for the demo https://youtu.be/CGOw04Ukqws
%
% How to run the demo:
%
%   1. Choose which numbers to mix (top row, check boxes.)
%   2. Set kurtosis, data length, and white noise level.
%   3. Press 'Mix them' button. This generates pink noises (normalized
%      variance) and assign them to each ground truth numbers. Kurtosis
%      modulcation is not applied to white nose.
%   4. Press 'Play the movie' if you want to see how the mixed numbers plus
%      noise should look like (samples50 equally separated points).
%   5. Press 'Decompose the mixture' to run extended informax with all EEGLAB
%      default options. You may turn on realtime update for every 10/20/50
%      steps by changing the setting from the popup menu right to the
%      'Decompose the mixture' button.
%   6. When calculation is done, geographics correlations of the independent
%      components are displayed at the bottom row. Residual variance is
%      evaluated, which is defined as (X1-X2)/X2 where X1 and X2 are both 
%      1x7 normalized values for each of the seven segment display, anx X1
%      is the decomposed results, and X2 is the selected ground truth.
%   7. The other figure automatically pops up where original channel and
%      independent component probability density functions are plotted. On
%      the top left, you can specify which ground truth to overlay upon the 
%      obtained independent component activation (the first 1000 points are
%      shown). Also, the correlation coefficient across all the data points
%      as well as percent variance accounted for (PVAF), which is defined
%      as 100-100*var(Y1-Y2)/var(Y2) where Y1 is ground truth time series
%      and Y2 is independent component activation.
% 
% How to evaluate the results:
% 
%    Source PDF kurtosis -- larger means more kurtotic and easier to
%                           decompose for ICA.
%
%    Data length in frame -- longer means easier for ICA to decompose. Note
%                            that SCCN has been traditionally recommending
%                            the rule of thum of (ch^2)*30, but this
%                            recommended data length does not seem to work
%                            in this 7-channel demo. You probably need much
%                            larger than that here.
%
%   Background white noise variance -- smaller means easier for ICA to
%                                      decompose. This white noise is
%                                      independetly generated for each
%                                      channel.
%  
%    min r.v. -- minimum residual variance. Smaller means more similar to the
%                ground truth. Note that 'minimum' means that the given
%                decomposition is compared against all ground truth numbers,
%                and minimum r.v. is reported. This is due to the fact that
%                ICA results does not automatically identify itself with one
%                of the ground truths.
%
%    r -- correlation coefficient between the obtained IC activation and the
%         ground truth time series. Larger means more similar to the ground truth.
%
%    PVAF -- percent variance accounted for (PVAF) which is defined as
%            100-100*var(Y1-Y2)/var(Y2) where Y1 is ground truth time series
%            and Y2 is independent component activation. Larger means more
%            similar to the ground truth. Note that negative PVAF values are
%            truncated to be 0.
% 
% References:
% Jeremy Chen (2020). Simple Digital Clock (https://www.mathworks.com/matlabcentral/fileexchange/26488-simple-digital-clock), MATLAB Central File Exchange. Retrieved October 8, 2020.
% Hristo Zhivomirov (2020). Pink, Red, Blue and Violet Noise Generation with Matlab (https://www.mathworks.com/matlabcentral/fileexchange/42919-pink-red-blue-and-violet-noise-generation-with-matlab), MATLAB Central File Exchange. Retrieved October 8, 2020.
% E. Cheynet (2020). Non-Gaussian process generation (https://www.mathworks.com/matlabcentral/fileexchange/52193-non-gaussian-process-generation), MATLAB Central File Exchange. Retrieved October 8, 2020.

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



function varargout = pop_sevenSegmentica(varargin)
% POP_SEVENSEGMENTICA MATLAB code for pop_sevenSegmentica.fig
%      POP_SEVENSEGMENTICA, by itself, creates a new POP_SEVENSEGMENTICA or raises the existing
%      singleton*.
%
%      H = POP_SEVENSEGMENTICA returns the handle to a new POP_SEVENSEGMENTICA or the handle to
%      the existing singleton*.
%
%      POP_SEVENSEGMENTICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POP_SEVENSEGMENTICA.M with the given input arguments.
%
%      POP_SEVENSEGMENTICA('Property','Value',...) creates a new POP_SEVENSEGMENTICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pop_sevenSegmentica_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pop_sevenSegmentica_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pop_sevenSegmentica

% Last Modified by GUIDE v2.5 02-Oct-2020 10:35:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pop_sevenSegmentica_OpeningFcn, ...
                   'gui_OutputFcn',  @pop_sevenSegmentica_OutputFcn, ...
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


% --- Executes just before pop_sevenSegmentica is made visible.
function pop_sevenSegmentica_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pop_sevenSegmentica (see VARARGIN)

draw7SegNumbers(handles.disp0, 0, 1);
draw7SegNumbers(handles.disp1, 1, 1);
draw7SegNumbers(handles.disp2, 2, 1);
draw7SegNumbers(handles.disp3, 3, 1);
draw7SegNumbers(handles.disp4, 4, 1);
draw7SegNumbers(handles.disp5, 5, 1);
draw7SegNumbers(handles.disp6, 6, 1);
draw7SegNumbers(handles.disp7, 7, 1);
draw7SegNumbers(handles.disp8, 8, 1);
draw7SegNumbers(handles.disp9, 9, 1);

% Choose default command line output for pop_sevenSegmentica
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pop_sevenSegmentica wait for user response (see UIRESUME)
% uiwait(handles.ICADEMO_Fig1);


% --- Outputs from this function are returned to the command line.
function varargout = pop_sevenSegmentica_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox0.
function checkbox0_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox0


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkboxNoise.
function checkboxNoise_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxNoise


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function whiteNoiseLevelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to whiteNoiseLevelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of whiteNoiseLevelEdit as text
%        str2double(get(hObject,'String')) returns contents of whiteNoiseLevelEdit as a double


% --- Executes during object creation, after setting all properties.
function whiteNoiseLevelEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to whiteNoiseLevelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kurtosisEdit_Callback(hObject, eventdata, handles)
% hObject    handle to kurtosisEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kurtosisEdit as text
%        str2double(get(hObject,'String')) returns contents of kurtosisEdit as a double


% --- Executes during object creation, after setting all properties.
function kurtosisEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kurtosisEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kEdit_Callback(hObject, eventdata, handles)
% hObject    handle to kEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kEdit as text
%        str2double(get(hObject,'String')) returns contents of kEdit as a double


% --- Executes during object creation, after setting all properties.
function kEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in icaUpdatePopupmenu.
function icaUpdatePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to icaUpdatePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns icaUpdatePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from icaUpdatePopupmenu


% --- Executes during object creation, after setting all properties.
function icaUpdatePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icaUpdatePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MixThemPushbutton.
function MixThemPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to MixThemPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Initial input check. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check if at least 1 signal is selected.
if      get(handles.checkbox1, 'value') == 0 & ...
        get(handles.checkbox2, 'value') == 0 & ...
        get(handles.checkbox3, 'value') == 0 & ...
        get(handles.checkbox4, 'value') == 0 & ...
        get(handles.checkbox5, 'value') == 0 & ...
        get(handles.checkbox6, 'value') == 0 & ...
        get(handles.checkbox7, 'value') == 0 & ...
        get(handles.checkbox8, 'value') == 0 & ...
        get(handles.checkbox9, 'value') == 0 & ...
        get(handles.checkbox0, 'value') == 0
    
    error('Choose at least one ground truth input.')
end

% Check if <= 7 numbers are selected.
if sum([get(handles.checkbox1, 'value') ...
        get(handles.checkbox2, 'value') ...
        get(handles.checkbox3, 'value') ...
        get(handles.checkbox4, 'value') ...
        get(handles.checkbox5, 'value') ...
        get(handles.checkbox6, 'value') ...
        get(handles.checkbox7, 'value') ...
        get(handles.checkbox8, 'value') ...
        get(handles.checkbox9, 'value') ...
        get(handles.checkbox0, 'value')]) > 7
    
    error('Maximum 7 numbers may be selected.')
end

% Check if White Noise is non-zero.
noiseLevelStr = get(handles.whiteNoiseLevelEdit, 'String');
if isempty(noiseLevelStr)
    error('Noise level must be > 0');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Define the mixing matrix. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define conversion from number to 7seg indices.
numDisp0_7segIdx = [1:6];
numDisp1_7segIdx = [2 3];
numDisp2_7segIdx = [1 2 4 5 7];
numDisp3_7segIdx = [1 2 3 4 7];
numDisp4_7segIdx = [2 3 6 7];
numDisp5_7segIdx = [1 3 4 6 7];
numDisp6_7segIdx = [1 3 4 5 6 7];
numDisp7_7segIdx = [1:3];
numDisp8_7segIdx = [1:7];
numDisp9_7segIdx = [1:4 6 7];

% Define mixing matrix.
mixingMatrix = cat(2, [0 1 1 0 0 0 0]', ...
                      [1 1 0 1 1 0 1]', ...
                      [1 1 1 1 0 0 1]', ...
                      [0 1 1 0 0 1 1]', ...
                      [1 0 1 1 0 1 1]', ...
                      [1 0 1 1 1 1 1]', ...
                      [1 1 1 0 0 0 0]', ...
                      [1 1 1 1 1 1 1]', ...
                      [1 1 1 1 0 1 1]', ...
                      [1 1 1 1 1 1 0]');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Generate kertotic pink noise for each segment. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataLength = str2num(get(handles.kEdit, 'string')); % ch^2*30 from SCCN rule of thumb.
sourceActivations = zeros(10, dataLength);

if get(handles.checkbox1, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(1,:) = currentSignal;
end

if get(handles.checkbox2, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(2,:) = currentSignal;
end

if get(handles.checkbox3, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(3,:) = currentSignal;
end

if get(handles.checkbox4, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(4,:) = currentSignal;
end

if get(handles.checkbox5, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(5,:) = currentSignal;
end

if get(handles.checkbox6, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(6,:) = currentSignal;
end

if get(handles.checkbox7, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(7,:) = currentSignal;
end

if get(handles.checkbox8, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(8,:) = currentSignal;
end

if get(handles.checkbox9, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(9,:) = currentSignal;
end

if get(handles.checkbox0, 'value')
    currentSignal = pinknoise(dataLength,1)'; 
    currentSignal = MBHTM(currentSignal, 0, str2num(get(handles.kurtosisEdit, 'String')));
    sourceActivations(10,:) = currentSignal;
end

        % NEVER normalized channelwise! ICA will practically fail.
        %
        % % Normalize to SD = 1.
        % nonzeroIdx = find(mean(sourceActivations,2));
        % sourceActivationsNorm = sourceActivations;
        % sourceActivationsNorm(nonzeroIdx,:) = bsxfun(@rdivide, sourceActivations(nonzeroIdx,:), std(sourceActivations(nonzeroIdx,:),[],2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Backproject signals to 7seg. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
backprojSignals = mixingMatrix*sourceActivations;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calclate white noise scaling factor. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
whiteNoise = randn(7, dataLength);
noiseLevel = str2num(noiseLevelStr);
relativeNoiseScale = std(nonzeros(backprojSignals(:)))/std(nonzeros(whiteNoise(:)))*noiseLevel;
scaledWhiteNoise = whiteNoise*relativeNoiseScale;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Add the noise to the signal. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mixedSignal = backprojSignals + scaledWhiteNoise;

    % In case scaling factors needs to be obtained...
    % backProjSigDemean      = bsxfun(@minus, backprojSignals, mean(backprojSignals,2));
    % scaledWhiteNoiseDemean = bsxfun(@minus, scaledWhiteNoise, mean(scaledWhiteNoise,2));
    % mixedSignal            = backProjSigDemean + scaledWhiteNoiseDemean;
    % rescalingFactor        = std(mixedSignal,0,2);
    % rescaledMixedSignal    = bsxfun(@rdivide, mixedSignal, rescalingFactor);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Re-scale the mixedSignal to [0 1] while truncating the zscore [-6 6]. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rescaledMixedSignal = mixedSignal-min(mixedSignal(:));
rescaledMixedSignal = rescaledMixedSignal/max(rescaledMixedSignal(:));



%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot time series. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%
offsetDC = repmat([0:6]', [1 size(rescaledMixedSignal,2)]);
plot(handles.mixedLinePlot, [rescaledMixedSignal + offsetDC]');
axis(handles.mixedLinePlot, 'ij')
xlim(handles.mixedLinePlot, [0 size(rescaledMixedSignal,2)])
ylim(handles.mixedLinePlot, [0 7])
set( handles.mixedLinePlot, 'xtick', [])
set( handles.mixedLinePlot, 'ytick', [0.5 1.5 2.5 3.5 4.5 5.5 6.5], 'yticklabel', [1 2 3 4 5 6 7])

% Plot the results of the first frame.
vlineHandle = line(handles.mixedLinePlot, [1 1], [0 7], 'color', [0 0 0], 'linestyle', '--');
draw7SegIndependently(handles.mixed7segDisplay, rescaledMixedSignal(:,1))
text(handles.mixed7segDisplay, 2.25, -0.5,  '1', 'color', [1 1 1])
text(handles.mixed7segDisplay, 4.35, -3.0,  '2', 'color', [1 1 1])
text(handles.mixed7segDisplay, 4.35, -9.0,  '3', 'color', [1 1 1])
text(handles.mixed7segDisplay, 2.25, -11.5, '4', 'color', [1 1 1])
text(handles.mixed7segDisplay, 0.25, -9.0,  '5', 'color', [1 1 1])
text(handles.mixed7segDisplay, 0.25, -3.0,  '6', 'color', [1 1 1])
text(handles.mixed7segDisplay, 2.25, -6.0,  '7', 'color', [1 1 1])



%%%%%%%%%%%%%%%%%%%%%%%
%%% Store the data. %%%
%%%%%%%%%%%%%%%%%%%%%%%
sevenSegmentica.rescaledMixedSignal = rescaledMixedSignal;
sevenSegmentica.mixingMatrix        = mixingMatrix;
sevenSegmentica.sourceActivations   = sourceActivations;
sevenSegmentica.mixedNoScaling      = mixedSignal;

% Update the variable in 'base'.
assignin('base', 'sevenSegmenticaData', sevenSegmentica);



% --- Executes on button press in playTheMoviePushbutton.
function playTheMoviePushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playTheMoviePushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Obtain precalculated data.
try
    sevenSegmenticaData = evalin('base', 'sevenSegmenticaData');
catch
    error('Please press ''Mix them'' button first.')
end
rescaledMixedSignal = sevenSegmenticaData.rescaledMixedSignal;

% Plot time series.
offsetDC = repmat([0 1 2 3 4 5 6]', [1 length(rescaledMixedSignal)]);
plot(handles.mixedLinePlot, [rescaledMixedSignal+offsetDC]');
axis(handles.mixedLinePlot, 'ij')
xlim(handles.mixedLinePlot, [0 length(rescaledMixedSignal)])
ylim(handles.mixedLinePlot, [0 7])
set( handles.mixedLinePlot, 'xtick', [])
set( handles.mixedLinePlot, 'ytick', [0 1 2 3 4 5 6]+0.5, 'yticklabel', [1 2 3 4 5 6 7])

% Plot the results of the first frame.
vlineHandle = line(handles.mixedLinePlot, [1 1], [0 7], 'color', [0 0 0], 'linestyle', '--');
draw7SegIndependently(handles.mixed7segDisplay, rescaledMixedSignal(:,1))
text(handles.mixed7segDisplay, 2.25, -0.5,  '1', 'color', [1 1 1])
text(handles.mixed7segDisplay, 4.35, -3.0,  '2', 'color', [1 1 1])
text(handles.mixed7segDisplay, 4.35, -9.0,  '3', 'color', [1 1 1])
text(handles.mixed7segDisplay, 2.25, -11.5, '4', 'color', [1 1 1])
text(handles.mixed7segDisplay, 0.25, -9.0,  '5', 'color', [1 1 1])
text(handles.mixed7segDisplay, 0.25, -3.0,  '6', 'color', [1 1 1])
text(handles.mixed7segDisplay, 2.25, -6.0,  '7', 'color', [1 1 1])

% Move the bar over time series.
for frameIdx = 1:floor(length(rescaledMixedSignal)/50):length(rescaledMixedSignal)
    
    % Update the vertical line position.
    set(vlineHandle, 'XData', [frameIdx frameIdx], 'YData', [0 7]);
    
    % Draw 7-seg display.
    draw7SegIndependently(handles.mixed7segDisplay, rescaledMixedSignal(:,frameIdx))
    text(handles.mixed7segDisplay, 2.25, -0.5,  '1', 'color', [1 1 1])
    text(handles.mixed7segDisplay, 4.35, -3.0,  '2', 'color', [1 1 1])
    text(handles.mixed7segDisplay, 4.35, -9.0,  '3', 'color', [1 1 1])
    text(handles.mixed7segDisplay, 2.25, -11.5, '4', 'color', [1 1 1])
    text(handles.mixed7segDisplay, 0.25, -9.0,  '5', 'color', [1 1 1])
    text(handles.mixed7segDisplay, 0.25, -3.0,  '6', 'color', [1 1 1])
    text(handles.mixed7segDisplay, 2.25, -6.0,  '7', 'color', [1 1 1])
    
    % Draw now.
    drawnow
end



% --- Executes on button press in decomposeThemPushbutton.
function decomposeThemPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to decomposeThemPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Obtain precalculated data.
try
    sevenSegmenticaData = evalin('base', 'sevenSegmenticaData');
catch
    error('Please press ''Mix them'' button first.')
end
rescaledMixedSignal = sevenSegmenticaData.rescaledMixedSignal;
mixingMatrix        = sevenSegmenticaData.mixingMatrix;
sourceActivations   = sevenSegmenticaData.sourceActivations;
mixedNoScaling      = sevenSegmenticaData.mixedNoScaling;


        % Perform high-pass filter.
        % EEG = eeg_emptyset;
        % EEG.data  = icaEducationalDemoData;
        % EEG.nbchan = size(EEG.data,1);
        % EEG.trials = 1;
        % EEG.srate = 100;
        % EEG.pnts  = length(EEG.data);
        % EEG = pop_eegfiltnew(EEG, [],1,330,1,[],0);
        % icaEducationalDemoData = EEG.data;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Close the other figure. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close(findobj('tag', 'sevenSegmenticaFigure2'))

%%%%%%%%%%%%%%%%
%%% Run ICA. %%%
%%%%%%%%%%%%%%%%
% eigVelList = sort(eig(cov(rescaledMixedSignal')), 'descend');
% effectiveRank = sum(eigVelList>1E-6);
% disp(sprintf('Effective rank %.0f applied', effectiveRank))
[icaweights,icasphere] = runicaSevenSegmentica(rescaledMixedSignal, 'extended', 0, ...
                                               'updateIntervalIdx', get(handles.icaUpdatePopupmenu, 'value'), ...
                                               'mixingMatrix', mixingMatrix);

% Obtain icawinv.
icawinv = pinv(icaweights*icasphere);

% Make icawinv positive and normalized to 0<=x<=1.
icawinvPlot = zeros(size(icawinv));
for icIdx = 1:length(icawinv)
    if min(icawinv(:,icIdx))<0
        icawinvPlot(:,icIdx) = icawinv(:,icIdx)-min(icawinv(:,icIdx));
    else
        icawinvPlot(:,icIdx) = icawinv(:,icIdx);
    end
end
icawinvPlot = bsxfun(@rdivide, icawinvPlot, max(icawinvPlot,[],1));

% Store the updated data.
sevenSegmenticaData.icaweights  = icaweights;
sevenSegmenticaData.icasphere   = icasphere;
sevenSegmenticaData.icawinv     = icawinv;
sevenSegmenticaData.icawinvPlot = icawinvPlot;
constantMultiplyer = 8;
sevenSegmenticaData.constantMultiplyer = constantMultiplyer;
assignin('base', 'sevenSegmenticaData', sevenSegmenticaData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot the final results. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
draw7SegIndependently(handles.ic1, icawinvPlot(:,1));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,1)).^2)/sum(icawinvPlot(:,1).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv1Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv1Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end

draw7SegIndependently(handles.ic2, icawinvPlot(:,2));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,2)).^2)/sum(icawinvPlot(:,2).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv2Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv2Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end

draw7SegIndependently(handles.ic3, icawinvPlot(:,3));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,3)).^2)/sum(icawinvPlot(:,3).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv3Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv3Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end

draw7SegIndependently(handles.ic4, icawinvPlot(:,4));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,4)).^2)/sum(icawinvPlot(:,4).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv4Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv4Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end

draw7SegIndependently(handles.ic5, icawinvPlot(:,5));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,5)).^2)/sum(icawinvPlot(:,5).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv5Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv5Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end

draw7SegIndependently(handles.ic6, icawinvPlot(:,6));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,6)).^2)/sum(icawinvPlot(:,6).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv6Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv6Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end

draw7SegIndependently(handles.ic7, icawinvPlot(:,7));
minRV = min(sum(bsxfun(@minus, mixingMatrix, icawinvPlot(:,7)).^2)/sum(icawinvPlot(:,7).^2));
if minRV > 1, minRV = 1; end
if minRV < 0.1
    set(handles.rv7Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [1 0 0]);
else
    set(handles.rv7Text, 'String', sprintf('min r.v. %.1f%%', minRV*100), 'ForegroundColor', [0 0 0.4]);
end



%%%%%%%%%%%%%%%%%
%%% Plot PDF. %%% 
%%%%%%%%%%%%%%%%%

% Load the figure template.
plot_sevenSegmentica;

% Compute PDF.
numChan = 7;
edges = -4:0.1:4;
chPdf = zeros(numChan, length(edges));
mixedNoScalingDemeaned = bsxfun(@minus, mixedNoScaling, mean(mixedNoScaling,2));
for chIdx = 1:numChan
    chPdf(chIdx,:) = ksdensity(mixedNoScalingDemeaned(chIdx,:), edges);
end

originalSignalIdx = find(var(sourceActivations,0,2)>0);
numIc = length(originalSignalIdx);
icPdf = zeros(numIc, length(edges));
for icIdx = 1:numIc
    icPdf(icIdx,:) = ksdensity(sourceActivations(originalSignalIdx(icIdx),:), edges);
end

% Obtain 
yMax = max([chPdf(:); icPdf(:)])*1.05;

% Plot PDF.
chPdfPlotHandle = findobj('tag', 'channelPdfAxes');
cla(chPdfPlotHandle)
hold(chPdfPlotHandle, 'on');
chHandleList   = [];
chHandleLegend = {};
for chIdx = 1:numChan
    currentHandle = plot(chPdfPlotHandle, edges, chPdf(chIdx,:));
    chHandleList   = [chHandleList currentHandle];
    chHandleLegend{1,chIdx} = ['Seg' num2str(chIdx)];
end
hold(chPdfPlotHandle, 'off');
xlim(chPdfPlotHandle, [-4 4])
ylim(chPdfPlotHandle, [0 yMax])
legend(chPdfPlotHandle, chHandleList, chHandleLegend)

icPdfPlotHandle = findobj('tag', 'icPdfAxes');
cla(icPdfPlotHandle)
hold(icPdfPlotHandle, 'on');
icHandleList   = [];
icHandleLegend = {};
for icIdx = 1:numIc
    currentHandle = plot(icPdfPlotHandle, edges, icPdf(icIdx,:));
    icHandleList   = [icHandleList currentHandle];
    icHandleLegend{1,icIdx} = ['IC' num2str(icIdx)];
end
hold(icPdfPlotHandle, 'off');
xlim(icPdfPlotHandle, [-4 4])
ylim(icPdfPlotHandle, [0 yMax])
legend(icPdfPlotHandle, icHandleList, icHandleLegend)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot source activation. %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timeSeriesAxesHandle = findobj('tag', 'timeSeriesAxes');
    %constantMultiplyer = 8;

% Show 7-seg ICA results also in the other figure.
draw7SegIndependently(findobj('tag', 'resultSeg1Axes'), icawinvPlot(:,1));
draw7SegIndependently(findobj('tag', 'resultSeg2Axes'), icawinvPlot(:,2));
draw7SegIndependently(findobj('tag', 'resultSeg3Axes'), icawinvPlot(:,3));
draw7SegIndependently(findobj('tag', 'resultSeg4Axes'), icawinvPlot(:,4));
draw7SegIndependently(findobj('tag', 'resultSeg5Axes'), icawinvPlot(:,5));
draw7SegIndependently(findobj('tag', 'resultSeg6Axes'), icawinvPlot(:,6));
draw7SegIndependently(findobj('tag', 'resultSeg7Axes'), icawinvPlot(:,7));

% Plot backprojected.
estimatedSources = icaweights*icasphere*mixedNoScalingDemeaned;
estimatedSources = bsxfun(@rdivide, estimatedSources, std(estimatedSources,[],2));

meanSd = mean(std(estimatedSources,0,2));
%sourceActivations(originalSignalIdx,:)

offsetDC = repmat([(1:7)*meanSd*constantMultiplyer]', [1 length(estimatedSources)]);
% offsetDC = repmat([0.5 1.5 2.5 3.5 4.5 5.5 6.5]', [1 length(rescaledMixedSignal)]);
cla(timeSeriesAxesHandle)
% plotHandle = plot(timeSeriesAxesHandle, [icaact/diminishingConstant+offsetDC]');
plotHandle = plot(timeSeriesAxesHandle, [estimatedSources + offsetDC]');

axis(timeSeriesAxesHandle, 'ij')
xlim(timeSeriesAxesHandle, [0 1000])
ylim(timeSeriesAxesHandle, [0 meanSd*constantMultiplyer*8])
set( timeSeriesAxesHandle, 'xtick', [])
set( timeSeriesAxesHandle, 'ytick', [(1:7)*meanSd*constantMultiplyer], 'yticklabel', [1 2 3 4 5 6 7])

hold(timeSeriesAxesHandle, 'on')

% Overlay the first Signal.
currentlySelectedGroundTruth  = sourceActivations(originalSignalIdx(1),:);
sample7SegHandle = findobj('tag', 'sample7SegAxes');
draw7SegNumbers(sample7SegHandle ,originalSignalIdx(1), 1);
currentlySelectedSignalRepmat = repmat(currentlySelectedGroundTruth, [7 1]);
% firstSignalHandles = plot(timeSeriesAxesHandle, [currentlySelectedSignalRepmat/diminishingConstant+offsetDC]', 'k');
firstSignalHandles = plot(timeSeriesAxesHandle, [currentlySelectedSignalRepmat+offsetDC]', 'k');
for lineObjIdx = 1:length(firstSignalHandles)
    set(firstSignalHandles(lineObjIdx), 'tag', ['overlaySignal' num2str(lineObjIdx)]);
end


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
