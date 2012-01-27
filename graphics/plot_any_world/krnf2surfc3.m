function [h] = krnf2surfc3(ax, X, Y, krnfZ, contourV)
%KRNF2SURFC3    KRNF surface and contours over 2D domain
%   KRNF2SURFC3(ax, X, Y, krnfZ, contourV)
%
% ax = (optional) axis handle
% X = vector OR matrix XData
% Y = vector OR matrix YData
% Z = function surface matrix ZData
%
% See also DOMAIN2KRNF, SURFC3_KRNF.
%
% File:      krnf2surfc3.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot Koditschek-Rimon Navigation Function potential field
%            surface and level sets over 2D domain
% Copyright: Ioannis Filippidis, 2010-

%% input
if nargin < 5
    contourV = [];
end

%% plot
h = surfc3(ax, X, Y, krnfZ, contourV, [] );

grid(ax, 'on')
plot_scalings(ax, 0)
tex_plot_annot(ax, [], '$x$', '$y$', '$\varphi$', [] );
