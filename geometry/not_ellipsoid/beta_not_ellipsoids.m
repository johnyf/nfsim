function [bi, Dbi, D2bi] = beta_not_ellipsoids(q, not_ellispoids)
%
% usage
%   [bi, Dbi, D2bi] = beta_not_ellipsoids(q, quadrics_inward)
%
% input
%   q = calculation points
%     = [#dimensions x #points]
%   quadrics_inward = [#obstacles x 1]
%   quadrics_inward(i, 1).qc = {#obstacles, 1}
%                            = ellipsoid centers
%   quadrics_inward(i, 1).A = {#obstacles, 1}
%                           = ellipsoid definition matrices
%   quadrics_inward(i, 1).R = {#obstacles, 1}
%                           = ellipsoid axes rotation matrices
%
% See also beta_not_ellipsoid, plot_not_ellipsoids, create_not_ellipsoids.
%
% File:      beta_not_ellipsoids.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2011.11.29
% Language:  MATLAB R2011b
% Purpose:   beta for multiple inwad quadrics
% Copyright: Ioannis Filippidis, 2011-

[ndim, npnt] = size(q);
no = size(not_ellispoids, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single quadric
if no == 1
    Dbi = nan(ndim, npnt);
    
    curquadric = not_ellispoids(1, 1);
    
    qc = curquadric.qc;
    A = curquadric.A;
    rot = curquadric.rot;
    
    [b1, Db1, D2b1] = beta_not_ellipsoid(q, qc, rot, A);
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple inward quadrics
Dbi = cell(no, 1);

for i=1:no
    curquadric = not_ellispoids(i, 1);
    
    qc = curquadric.qc;
    A = curquadric.A;
    rot = curquadric.rot;

    [b1, Db1, D2b1] = beta_not_ellipsoid(q, qc, rot, A);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
