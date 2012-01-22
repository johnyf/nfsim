function [varargout] = plot_circle(varargin)
% qc = [qc1(:,1), qc2(:,1), ..., qc(:,n)]; % circle centers
% r = [r1, r2, ..., rn]; % circle radii
% style_circle = 'b-'; % plot style of perimeter
% style_center = 'g+'; % plot style of center
%              = []; % no center shown
%
% [] = plot_circle(qc, r)
% [] = plot_circle(qc, r, ...property-value string pairs)
% [] = plot_circle(ax, qc, r)
% [] = plot_circle(ax, qc, r, ...property-value string pairs)
%
% style additional to line properties 'CenterStyle' which is the line
% style of the curcle's center. If you do not want a center pass 'none'.
%
% File:      plot_circle.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.29
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot many circles & optionally their centers
% Copyright: Ioannis Filippidis, 2010-

%% varargin
if (nargin < 2)
    error('This function takes at least 2 arguments.')
end

styles = {};
for i = 1:length(varargin)
    if (ischar(varargin{i} ) )
        styles = varargin(i:end);
        varargin(i:end) = [];
        break;
    end
end

CenterStyle = 'r+';
for i=1:length(styles)
    if strcmp(styles{i}, 'CenterStyle')
        CenterStyle = styles{i +1};
        styles(i +1) = [];
        styles(i) = [];
        break
    end
end

% filled?
fillcolor = 'none';
for i=1:length(styles)
    if strcmp(styles{i}, 'Filled')
        fillcolor = styles{i +1};
        styles(i +1) = [];
        styles(i) = [];
        break
    end
end

if ishandle(varargin{1} )
    ax = varargin{1};
    n = 2;
else
    ax = gca;
    n = 1;
end

qc = varargin{n};
r = varargin{n +1};
N = size(r, 2);

%% plot
hold(ax, 'on')

% unit circle
npnt = 30;
unit_circle = unitcircle(npnt);

% show perimeters and return them
h1 = nan(1, N);
for i=1:N
    % scale +translate
    circle = bsxfun(@plus, r(1,i) .* unit_circle, qc(:,i));
    if strcmp(fillcolor, 'none')
        h1(1, i) = plot(ax, circle(1,:), circle(2,:), styles{:} );
    else
        h1(1, i) = fill(circle(1, :), circle(2, :), fillcolor, 'Parent', ax);
    end
end

% show centers
h2 = nan(size(qc) );
if ~strcmp(CenterStyle, 'none')
    h2 = plot(ax, qc(1,:), qc(2,:), CenterStyle);
end

% output?
if nargout > 0
    varargout{1} = h1;
    varargout{2} = h2;
end

axis(ax, 'equal')
hold(ax, 'off')
    