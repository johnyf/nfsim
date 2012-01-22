function [] = pause_call(src, varargin)
%% get data
S = guidata(src);

h_button_pause = S.panels.h_button_pause;

%% main
curString = get(h_button_pause, 'String');

switch curString
    case 'Pause'
        pause_actions(S)
    case 'Resume'
        resume_actions(S)
    otherwise
        warning('Pause button name is unexpected.')
end

set(gcbo, 'userdata', 1);
