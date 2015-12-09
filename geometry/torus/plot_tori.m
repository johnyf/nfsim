function [h] = plot_tori(ax, tori, npnt, varargin)
%PLOT_TORI  Plot multiple tori.
%
% usage
%   PLOT_TORI(ax, tori, npnt, varargin)
%
% input
%   ax = axes object handle
%   tori = struct array of tori
%   npnt = number of points for torus surface plot
%   varargin = additional arguments for surf function
%
% See also plot_torus, beta_tori, create_tori.
%
% File:      plot_tori.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.12
% Language:  MATLAB R2011b
% Purpose:   plot multiple tori
% Copyright: Ioannis Filippidis, 2011-

if nargin < 3
    npnt = 30;
end

ntori = size(tori, 1);

held = takehold(ax, 'local');
for i=1:ntori
    torus = tori(i, 1);
    
    qc = torus.qc;
    r = torus.r;
    R = torus.R;
    rot = torus.rot;
    h(1, i) = plot_torus(ax, qc, r, R, rot, npnt, varargin{:} );
end
restorehold(ax, held)
