function [h] = krnf2surfc(ax, X, Y, nfZ, contourV)
%KRNF2SURFC(AX, X, Y, NFZ, CONTOURV)
%
% ax = (optional) axis handle
% X = vector OR matrix XData
% Y = vector OR matrix YData
% Z = function surface matrix ZData
%
% File:      plot_nf_surf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot 3D potential field surface with 2D level sets
% Copyright: Ioannis Filippidis, 2010-

%% input
if nargin < 5
    contourV = [];
end

%% plot
h = surfc3(ax, X, Y, nfZ, contourV, [] );

grid(ax, 'on')
plot_scalings(ax, 0)
tex_plot_annot(ax, [], '$x$', '$y$', '$\varphi$', [] );
