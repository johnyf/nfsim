function [fig] = plot_nf_surf(ax, X, Y, NF, contourV)
% File:      plot_nf_surf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20 - 2011.08.02
% Language:  MATLAB R2011a
% Purpose:   plot 3D potential field surface with 2D level sets
% Copyright: Ioannis Filippidis, 2010-
%
% plot_nf_surf(X, Y, Z)
% plot_nf_surf(ax, X, Y, Z)
% plot_nf_surf(ax, X, Y, Z, contourV)
%
% ax = (optional) axis handle
% X = vector OR matrix XData
% Y = vector OR matrix YData
% Z = function surface matrix ZData

%% args
if nargin > 5
    error('PLOT_NF_SURF(AX, X, Y, Z, CONTOURV) takes at most 5 arguments.')
end

if nargin < 5
    contourV = [];
end

%% x,y vectors?
if isvector(X) && isvector(Y)
    [X, Y] = meshgrid(X, Y);
%     X_diff = diff(X);
%     Y_diff = diff(Y);
% 
%     X_diff_min = min(X_diff);
%     X_diff_max = max(X_diff);
% 
%     Y_diff_min = min(Y_diff);
%     Y_diff_max = max(Y_diff);
else
    % x,y matrices same size?
    if ~isequal(size(X), size(Y) )
        error('Non-array matrices X, Y are of unequal size.')
    end
end

%% meshgrid?
%num_tol = 0.1; % numerical tolerance of subtractions
% this requires that any scaterred mesh will deviate more than num_tol
% from meshgrid results.
%if ((X_diff_min -X_diff_max) < num_tol) && ((Y_diff_min - Y_diff_max) < num_tol)
    % yes
    fig = meshgrid_data(ax, X, Y, NF, contourV);
%else
    % no
%    disp('Patched surface not implemented yet')
%end

%% annotate
tex_plot_annot(ax, [], '$x$', '$y$', '$\varphi$', [] );

% for regularly spaced data (meshgrid)
function [fig] = meshgrid_data(ax, X, Y, NF, contourV)
if isempty(contourV)
    v = [0, 0.1, 0.2, 0.5, 0.6, 0.7, 0.8];
else
    v = contourV;
end

%% surf
fig = get(ax, 'Parent');
    surf(ax, X, Y, NF);
    shading(ax, 'faceted');
    hold(ax, 'on');

%% level sets
z_min = min(min(NF, [], 2), [], 1);
z_max = max(max(NF, [], 2), [], 1);
%set(ax, 'DataAspectRatio', [1, 1, 1.2*(z_max-z_min) ] );
zoff = 0.2 *(z_max-z_min); % contour plot plane z offset

v = (z_max -z_min) *v +z_min;
[~, h] = contour3(ax, X, Y, NF, v);

%% offset level sets
% (using contour Zdata are the source data, not the
% level set lines' z coordinates, also using surfc does not provide a way
% of controlling the number of level sets)
for i = 1:length(h);
    Zdata = get(h(i), 'Zdata');
    newz = z_min *ones(size(Zdata) ) -zoff;
    set(h(i), 'Zdata', newz);
end

hold(ax, 'off')
