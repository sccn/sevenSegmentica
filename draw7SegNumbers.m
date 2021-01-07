% draw7SegNumbers() - Developed for an EEGLAB plugin pop_sevenSegmentica().
%                     See pop_sevenSegmentica help.
% Reference:
%    digital_clock_v2.m is written by Jeremy Chen. https://www.mathworks.com/matlabcentral/fileexchange/26488-simple-digital-clock?s_tid=FX_rc2_behav

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

function draw7SegNumbers(ax, intInput, intensity)

% Higher the intensity, closer to black.
intensity = 1-intensity;

% Set up patch geometry.
disp.topcenter = [0 5 4 1 0;0 0 -1 -1 0];
disp.topright  = [5 5 4 4 5;-0.5 -5.5 -4.5 -1.5 -0.5];
disp.botright  = [5 5 4 4 5;-6.5 -11.5 -10.5 -7.5 -6.5];
disp.botcenter = [0 1 4 5 0;-12 -11 -11 -12 -12];
disp.botleft   = [0 1 1 0 0;-6.5 -7.5 -10.5 -11.5 -6.5];
disp.topleft   = [0 1 1 0 0;-0.5 -1.5 -4.5 -5.5 -0.5];
disp.midcenter = [0 0.5 4.5 5 4.5 0.5 0;-6 -5.5 -5.5 -6 -6.5 -6.5 -6];

switch intInput
    case 0
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [1 1 1], 'LineStyle', 'none');
        
    case 1
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [1 1 1], 'LineStyle', 'none');
        
    case 2
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        
    case 3
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        
    case 4
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        
    case 5
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        
    case 6
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        
    case 7
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [1 1 1], 'LineStyle', 'none');
        
    case 8
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        
    case 9
        patch(ax, disp.topcenter(1,:), disp.topcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.topright( 1,:), disp.topright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botright( 1,:), disp.botright( 2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botcenter(1,:), disp.botcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.botleft(  1,:), disp.botleft(  2,:), [1 1 1], 'LineStyle', 'none');
        patch(ax, disp.topleft(  1,:), disp.topleft(  2,:), [intensity intensity intensity], 'LineStyle', 'none');
        patch(ax, disp.midcenter(1,:), disp.midcenter(2,:), [intensity intensity intensity], 'LineStyle', 'none');
end

% Crop the number.
xlim(ax, [0 5])
ylim(ax, [-12 0])

% Clear axis
set(get(ax, 'XAxis'), 'visible', 'off')
set(get(ax, 'YAxis'), 'visible', 'off')