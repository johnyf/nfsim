function [] = close_nfsimgui(src, eventdata)
delete(gcf)
%{
% User-defined close request function
% to display a question dialog box
selection = questdlg('Are you sure you want to exit nfsim?',...
    'nfsim',...
    'Yes','No','Yes');
switch selection
    case 'Yes'
        delete(gcf)
    case 'No'
        return
end
%}