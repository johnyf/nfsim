function [h] = plot_ellipsoids(ax, ellipsoids, npnt)
% Plot multiple ellipsoids.
%
% usage
%   h = plot_ellipsoids(ax, ellipsoids, npnt)
%
% input
%   ax = axes object handle
%   ellipsoids = structure matrix of ellipsoids, see create_ellipsoid
%              = [m x n] struct of ellipsoids
%   npnt = # points on the circumference of the plotted ellipsoid
%
% output
%   h = array of surface object handles to plotted ellipsoids
%     = [1 x #ellipsoids]
%
% 2012.05.21 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also create_ellipsoid, plot_ellipsoid.

%% input
if nargin < 3
    npnt = 30;
end

% vectorize
[m, n] = size(ellipsoids);

%% plot
held = takehold(ax, 'local');
h = nan(m, n);
for i=1:m
    for j=1:n
        qc = ellipsoids(i, 1).qc;
        rot = ellipsoids(i, 1).rot;
        A = ellipsoids(i, 1).A;
        
        h(i, j) = plot_ellipsoid(ax, qc, rot, A, npnt);
    end
end
restorehold(ax, held)

%% output
if nargout == 0
    clear('q')
end
