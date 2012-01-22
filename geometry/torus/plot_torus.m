function [varargout] = plot_torus(ax, qc, r, R, rot, npnt)
% [x, y, z] = plot_torus(ax, qca, Ra, ra, nc, npnt)
%
% TORUS Generate a torus.
% torus (r, npnt, a) generates a plot of a torus with central radius R and
% lateral radius r. npnt controls the number of facets on the surface.
%
% [x, y, z] = torus(r, npnt, a) generates three (npnt + 1)-by-(npnt + 1) matrices so
% that surf (x, y, z) will produce the torus.
%
% See also PLOT_TORI, BETA_TORUS.
%
% File:      plot_torus.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.05 - 2011.09.11
% Language:  MATLAB R2011a
% Purpose:   plot a torus
% Copyright: Ioannis Filippidis, 2010-

if nargin < 6
    npnt = 100;
end

allqc = qc;
allr = r;
allR = R;
allrot = rot;

ntori = size(qc, 2);

if nargout > 0
    xx = cell(1, N);
    yy = cell(1, N);
    zz = cell(1, N);
end

for i=1:ntori
    r = allr(i, 1);
    R = allR(i, 1);
    
    if iscell(qc)
        qc = allqc{i, 1};
        rot = allrot{i, 1};
    else
        qc = allqc;
        rot = allrot;
    end
    
    % discretization
    theta = pi *(0: 2: 2*npnt) /npnt ;
    phi = 2 *pi *(0: 2: npnt)' /npnt ;
    
    % vertices
    x = (R + r *cos(phi)) *cos(theta);
    y = (R + r *cos(phi)) *sin(theta);
    z = r *sin(phi) *ones(size(theta) );
    
    [m, n] = size(x);
    
    % z-axis rotation in the direction of a vector
    %n3 = cross([0, 0, 1], nc./norm(nc,2));
    %theta1 = acos(dot([0, 0, 1], nc) ./norm(nc, 2));
    %rotM = angvec2r(theta1, n3);

    qi = [x(:), y(:), z(:) ].';
    qg = rot *qi;
    qg = bsxfun(@plus, qg, qc);

    x = qg(1, :);
    y = qg(2, :);
    z = qg(3, :);
    
    x = reshape(x, m, n);
    y = reshape(y, m, n);
    z = reshape(z, m, n);
    
    surf(ax, x, y, z)
    
    if nargout > 0
        xx{i, 1} = x;
        yy{i, 2} = y;
        zz{i, 3} = z;
    end
end

if nargout > 0
    varargout{1} = xx;
    varargout{2} = yy;
    varargout{3} = zz;
end
