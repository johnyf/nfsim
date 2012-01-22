% File:         plotS_nf_and_contour.m
% Author:       Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.29 - 
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      plot navigation function field in sphere world
% Copyright:    Ioannis Filippidis, 2010-

function [] = plotS_nf_and_contour(varargin)

% plotS_nf_and_contour(agent, world, known_world, type)
% plotS_nf_and_contour(axh1, agent, world, known_world, type)
% plotS_nf_and_contour(axh1, axh2, agent, world, known_world, type)

% axh1 = handle to gradient plot (3D) or to isocurve + gradient plot (2D)
% axh2 = handle to artificial potential field plot (2D domain, 3D plot)

switch nargin
    case 4
        ax2 = gca;
        figure;
        ax1 = axes;
    case 5
        ax1 = varargin{1};
        ax2 = gca;
    case 6
        ax1 = varargin{1};
        ax2 = varargin{2};
    otherwise
        error('This function can take 4, 5 or 6 arguments.')
end
agent = varargin{nargin -3};
world = varargin{nargin -2};
known_world = varargin{nargin -1};
type = varargin{nargin};

% testing for large k
%limits = [2.5, 5.0, 0.2, 2.7];
%limits = [-6, 6, -6, 6];
%limits = [2.109, 2.11, -0.4555, -0.455];

% sample sphere worlds
limits = [-5, 5, -5, 5];
n = [150, 150];
mask = 0; % caution this
[X, Y, nf_field, px, py, ~] = plotS_nf(ax2, mask, limits, n,...
                                 agent, world, known_world, type);
% iso + grad
    contour(ax1, X,Y, nf_field);
    hold(ax1, 'on')
    
    % no analytic gradient available for this field
    if isempty(px)
        [px,py] = gradient(nf_field);
    end
    [px, py] = normvec(px, py);

    quiver(ax1, X,Y, -px,-py, 0.75);

    hold(ax1, 'off')
    axis(ax1, 'equal')
