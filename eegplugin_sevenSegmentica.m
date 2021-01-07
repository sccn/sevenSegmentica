% eegplugin_sevenSegmentica() - An EEGLAB plugin to perform ICA demo. see
%                               pop_sevenSegmentica() help for detail.
% 
% Links to related websites:
%      Swartz Center Wiki page    https://sccn.ucsd.edu/wiki/SevenSegmenticaDemo
%      Youtube video for the demo https://youtu.be/CGOw04Ukqws
%
% References:
% Jeremy Chen (2020). Simple Digital Clock (https://www.mathworks.com/matlabcentral/fileexchange/26488-simple-digital-clock), MATLAB Central File Exchange. Retrieved October 8, 2020.
% Hristo Zhivomirov (2020). Pink, Red, Blue and Violet Noise Generation with Matlab (https://www.mathworks.com/matlabcentral/fileexchange/42919-pink-red-blue-and-violet-noise-generation-with-matlab), MATLAB Central File Exchange. Retrieved October 8, 2020.
% E. Cheynet (2020). Non-Gaussian process generation (https://www.mathworks.com/matlabcentral/fileexchange/52193-non-gaussian-process-generation), MATLAB Central File Exchange. Retrieved October 8, 2020.

% History:
% 10/08/2020 Makoto. Updated. 'startup:on;study:on' added. External folders created.
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

function vers = eegplugin_sevenSegmentica(fig, try_strings, catch_strings)

vers = '0.20';

if nargin < 3
    error('eegplugin_sevenSegmentica requires 3 arguments');
end;

% Create a highLevelMenu.
highLevelMenu = findobj(fig, 'tag', 'tools');
set(highLevelMenu, 'UserData', 'startup:on;study:on'); % This unlocks 'Tools' menu without loading .set data haha.
fullpathToHere = mfilename('fullpath');
[PATHSTR,NAME] = fileparts(fullpathToHere);
addpath([PATHSTR filesep 'external' filesep 'MBHTM']);
addpath([PATHSTR filesep 'external' filesep 'noise_generation']);
uimenu(highLevelMenu, 'label', 'Seven Segmentica (DEMO)','separator','on', 'callback', 'pop_sevenSegmentica');