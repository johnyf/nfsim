function [bi, Dbi, D2bi] = beta_quadrics(q, quadrics)
% q = calculation points
%   = [#dimensions x #points]
% quadrics_inward = [#obstacles x 1]
%   quadrics_inward(i, 1).qc = {#obstacles, 1}
%                            = ellipsoid centers
%   quadrics_inward(i, 1).A = {#obstacles, 1}
%                           = ellipsoid definition matrices
%   quadrics_inward(i, 1).rot = {#obstacles, 1}
%                           = ellipsoid axes rotation matrices
%
% See also BETA_QUADRIC, BI2B, DBI2DB, D2BI2D2B.
%
% File:      beta_quadrics.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2011.11.29
% Language:  MATLAB R2011b
% Purpose:   beta for multiple quadrics
% Copyright: Ioannis Filippidis, 2011-

% todo: add second derivative (Hessian matrix)

[ndim, npnt] = size(q);
no = size(quadrics, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single quadric
if no == 1
    Dbi = nan(ndim, npnt);
    
    curquadric = quadrics(1, 1);
    
    qc = curquadric.qc;
    A = curquadric.A;
    rot = curquadric.rot;
    
    [b1, Db1, D2b1] = beta_quadric(q, qc, rot, A);
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple quadrics
Dbi = cell(no, 1);

for i=1:no
    curquadric = quadrics(i, 1);
    
    qc = curquadric.qc;
    A = curquadric.A;
    rot = curquadric.rot;
    
    [b1, Db1, D2b1] = beta_quadric(q, qc, rot, A);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
