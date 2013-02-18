function [qtraj] = qtraj_mat2cell(qtraj)
% Convert 3d matrix of trajectories to row cell array of 2d matrices
%
% usage
%   qtraj = qtraj_mat2cell(qtraj)
%
% input
%   qtraj = 3d matrix of trajectories
%         = [#dim x #time_iterations x #trajectories]
%
% output
%   qtraj = cell row array of 2d matrices of column vectors of points in
%           each trajectory
%         = {1 x #trajectories} = {[#dim x #time_iterations], ... }
%
% note
%   input qtraj is a matrix, usually produced by a parallel integration of
%   the flow, so all trajectories stop at the same number of iterations.
%   Otherwise nan values could be used to signify the (different) end of
%   each trajectory.
%
% 2012.09.21 (c) Ioannis Filippidis, jfilippidis@gmail.com

% todo
%   dev faster alternative for plotting/post-processing directly with 3d
%   matrices of trajectories

[ndim, niter, ntraj] = size(qtraj);

qtraj = mat2cell(qtraj, ndim, niter, ones(1, ntraj) );
qtraj = squeeze(qtraj);
qtraj = qtraj.';
