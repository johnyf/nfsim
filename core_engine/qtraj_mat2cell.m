function [qtraj] = qtraj_mat2cell(qtraj)
[ndim, niter, ntraj] = size(qtraj);

qtraj = mat2cell(qtraj, ndim, niter, ones(1, ntraj) );
qtraj = squeeze(qtraj);
qtraj = qtraj.';
