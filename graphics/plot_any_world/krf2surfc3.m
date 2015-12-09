function [h] = krf2surfc3(ax, X, Y, krfZ, contourV)
%KRF2SURFC3    KRF surface and level sets over 2D domain
%
% usage
%   KRF2SURFC3(ax, X, Y, krnfZ, contourV)
%
% input
%   ax = (optional) axis handle
%   X = vector OR matrix XData
%   Y = vector OR matrix YData
%   Z = function surface matrix ZData
%
% 2010.09.20 - 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also DOMAIN2KRF, SURFC3_KRF.

%% input
if nargin < 5
    contourV = [];
end

%% plot
h = surfc3(ax, X, Y, krfZ, contourV, [] );

grid(ax, 'on')
plot_scalings(ax, 0)
tex_plot_annot(ax, [], '$x$', '$y$', '$\varphi$', [] );
