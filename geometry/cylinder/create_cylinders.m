function [cylinders] = create_cylinders(qc, r, h, axisv)
%CREATE_CYLINDERS  Initialize multiple cylinder structures.
%   Note that cylinder obstacles are infinite, but only a finite region is
%   plotted.
%
% usage
%   cylinders = CREATE_CYLINDERS(qc, r, h, rot)
%
% input
%   qc = centers of one circle at one end of cylinder
%      = [#dim x #cylinders]
%   r = cylinder radii
%     = [1 
%   h = cylinder heights (plotting only)
%     = [1 x #cylinders]
%   axisv = vectors for axis of symmetry of each cylinder
%         = [#dim x #cylinders]
%
% output
%   cylinders = struct array of cylinders
%             = [#cylinders x 1], for fields see create_cylinder
%
% See also CREATE_CYLINDER, ADD_CYLINDER, BETA_CYLINDERS, PLOT_CYLINDERS.
%
% File:      create_cylinders.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.01
% Language:  MATLAB R2012a
% Purpose:   initialize struct array of cylinder objects, given parameters
% Copyright: Ioannis Filippidis, 2012-

% todo
%   change rot to vector
%   extend to multi-dim cylinder

%% check input
[ndim, nobs] = size(qc);
[ndim_axisv, n_axisv] = size(axisv);

if ndim ~= ndim_axisv
    error(['dim(qc) = ', num2str(ndim), ', whereas dim(axisv) = ', num2str(ndim_axisv) ] )
end

if nobs ~= n_axisv
    error('Centers qc and axis vectors axisv do not match in numbers.')
end

%% init
cylinders = struct('qc', zeros(0, nobs), 'r', [], 'h', [], 'rot', [] );
for i=1:nobs
    curqc = qc(:, i);
    curr = r(1, i);
    curh = h(1, i);
    curaxis = axisv(:, i);
    
    cylinders(i, 1) = create_cylinder(curqc, curr, curh, curaxis);
end
