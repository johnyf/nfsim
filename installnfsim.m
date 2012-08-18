% File:      installnfsim.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.29
% Language:  MATLAB R2010b
% Purpose:   install Navigation Function Simulation Toolbox & Launch GUI
% Copyright: Ioannis Filippidis, 2010-

function [] = installnfsim(varargin)

% uninstall
if (nargin == 1) && (varargin{1} == -1)
    uninstall_toolbox('Navigation Function Simulation Toolbox');
    return
end

% install
install_toolbox

% run GUI
evalin('base', 'nfgui = CreateGraphics;');

function [] = install_toolbox
thisfile = mfilename;
thisfullfile = mfilename('fullpath');
i = strfind(thisfullfile, thisfile);
thispath = thisfullfile(1:i-1);
if thispath(end) == pathsep
    thispath = thispath(1:end-1);
end
w = which('navigation_main');
pathmatch = strcmp(thispath, w);
if ~isempty(w) && (isempty(pathmatch) || pathmatch ~= 1)
    warning( [...
        'You appear to have another version of the toolbox in your path.\n'...
        'Please use the pathtool to remove the unwanted version from your path.' ] )
    w = [];
end
if isempty(w)
    subdirs = listdir;
    addToPath(subdirs);
end

function addToPath(subdirs)
disp('Adding toolbox directories to the path...');
toolboxLocation = fileparts(mfilename('fullpath'));

%% missing directories?
% (check full path, dir does not have to be in path)
for i=numel(subdirs):-1:1
    subdirs{i} = fullfile(toolboxLocation, subdirs{i}{:});
    
    if ~isdir(subdirs{i})
        subdirs(i) = [];
        disp( ['Directory ' subdirs{i} 'is missing.'] );
    end
end

%% all missing?
if isempty(subdirs)
    error('Unable to locate any toolbox directories.');
end

%% already added?
% (check just dir name, dir must be in path)
matlab_path = regexp(path, ';', 'split');
for i=numel(subdirs):-1:1
    if ~isempty(find(ismember(matlab_path, subdirs{i}) == 1, 1))
        disp( ['Directory ' subdirs{i} ' is already added to path.'] );
        subdirs(i) = [];
    end
end

%% all already added?
if isempty(subdirs)
    disp('All toolbox directories already added to path.');
    return
else
    %% add path
    addpath(subdirs{:});
    disp( [ 'All paths succesfully loaded to path (this session). ',...
        'Path not saved.' ] );
end

%% save path
if ispc
    Save = input(...
        ['Would you like to save this toolbox to the default path'...
        ' read on MATLAB startup? (y/n) ' ], 's');
    if strcmp(Save, 'y')
        result = savepath;
        if result == 0
            disp('The default path was successfully saved.');
        else
            disp('Unable to save as the default path.');
        end
    elseif ~strcmp(Save, 'n')
        warning('Selection was neither ''y'' nor ''n''. No action taken.')
        return
    end
else
    joinedPath = [toolboxLocation sprintf( [pathsep '%s'], subdirs{:} )];
    
    disp( { 'To permananently add these directories to your Matlab path, add the',...
            'following line to your login shell''s initialization file:' } );
    disp('      bash, zsh, etc.:');
    disp(['        export MATLABPATH=' joinedPath ]);
    disp('      tcsh, csh, etc.:');
    disp(['        setenv MATLABPATH ' joinedPath ]);
end

function [subdirs] = listdir
% List of dirs to add
subdirs = {...
    {''},...
    {'auxiliary'},...
    {'fex'},...
    {'core_engine'},...
    {'geometry', 'bezier'},...
    {'geometry', 'convex_world'},...
    {'geometry', 'sphere_world'},...
    {'geometry', 'transformations'},...
    {'graphics'},...
    {'gui'}, ...
    {'init'}, ...
    {'navigation_function'},...
    {'navigation_function', 'plot_any_world'},...
    {'navigation_function', 'plot_sphere_world'},...
    {'navigation_function', 'polynomial'},...
    {'navigation_function', 'rimon'},...
    {'voronoi'} };

function [] = uninstall_toolbox(toolbox_name)
Uninstall = input( [ 'Are you sure you want to uninstall the ',...
    toolbox_name, ' from your MATLAB path? ',...
    '(y/n) ' ], 's');

if strcmp(Uninstall, 'y')
    subdirs = listdir;
    
    disp('Removing Toolbox directories from the path...');
    toolboxLocation = fileparts(mfilename('fullpath'));
    
    %% missing directories?
    % (check full path, dir does not have to be in path)
    for i=numel(subdirs):-1:1
        subdirs{i} = fullfile(toolboxLocation, subdirs{i}{:});
        
        if ~isdir(subdirs{i})
            subdirs(i) = [];
            disp( ['Directory ' subdirs{i} 'is missing.'] );
        end
    end
    
    %% all missing?
    if isempty(subdirs)
        error('Unable to locate any toolbox directories.');
    else
        %% remove path
        rmpath(subdirs{:});
        disp( [ 'All paths succesfully removed from path (this session). ',...
            'Path not saved yet.' ] );
    end
    
    %% save path
    result = savepath;
    if result == 0
        disp('The default path was successfully saved.');
    else
        disp('Unable to save as the default path.');
    end
elseif ~strcmp(Uninstall, 'n')
    warning('Selection was neither ''y'' nor ''n''. No action taken.')
    return
end
