function [bi, Dbi, D2bi] = beta_ellipsoids(q, quadrics)
% input
%   q = calculation points
%     = [#dimensions x #points]
%   quadrics = structure array
%            = [#obstacles x 1]
%       quadrics(i, 1).qc = ellipsoid center
%                         = [#dim x 1]
%       quadrics(i, 1).A = ellipsoid definition matrix
%                        = [#dim x #dim]
%       quadrics(i, 1).rot = ellipsoid reference frame rotation matrix
%                          = [#dim x #dim]
%
% output
%   bi = obstacle function values
%      = [#obstacles x #points]
%   Dbi = obstacle function gradients
%       = [#dim x #points] (if single obstacle), or
%       = {#obstacles x 1} = {[#dim x #points]; ... }
%   D2bi = obstacle Hessian matrices
%        = {#obstacles x #points} = {[#dim x #dim], ...; ... }
%
% See also BETA_QUADRIC, BETA_HETEROGENOUS, BIDBID2BI2BDBD2B.
%
% File:      beta_ellipsoids.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.10 - 2012.01.22
% Language:  MATLAB R2011b
% Purpose:   beta for multiple quadrics
% Copyright: Ioannis Filippidis, 2011-

% todo: add second derivative (Hessian matrix)

[~, npnt] = size(q);
no = size(quadrics, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single quadric
if no == 1
    %Dbi = nan(ndim, npnt);
    
    curquadric = quadrics(1, 1);
    
    qc = curquadric.qc;
    A = curquadric.A;
    rot = curquadric.rot;
    
    [b1, Db1, D2b1] = beta_quadric(q, qc, rot, A);
    %[b1, Db1, D2b1] = beta_quadric_normalized(q, qc, rot, A);
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
    %[b1, Db1, D2b1] = beta_quadric_normalized(q, qc, rot, A);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
