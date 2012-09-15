function [] = plot_cylinders(ax, cylinders, npnt)
%PLOT_CYLINDERS     Plot multiple cylinders.
%
% See also PLOT_CYLINDER, BETA_CYLINDERS, CREATE_CYLINDERS.
%
% File:      plot_cylinders.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.01
% Language:  MATLAB R2012a
% Purpose:   plot cylinders
% Copyright: Ioannis Filippidis, 2012-

if nargin < 3
    npnt = 6;
end

ncylinders = size(cylinders, 1);

held = takehold(ax, 'local');
for i=1:ncylinders
    qc = cylinders(i, 1).qc;
    r = cylinders(i, 1).r;
    h = cylinders(i, 1).h;
    rot = cylinders(i, 1).rot;
    
    plot_cylinder(ax, qc, r, h, rot, npnt)
end
restorehold(ax, held)
