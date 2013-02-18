function [bi, Dbi, D2bi] = beta_ellipsoids(q, ellipsoids)
% Quadratic obstacle function for multiple ellipsoids.
%
% usage
%   [bi, Dbi, D2bi] = beta_ellipsoids(q, ellipsoids)
%
% input
%   q = calculation points
%     = [#dim x #pnts]
%   ellipsoids = structure array
%            = [#ellipsoids x 1]
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
% See also beta_quadric, beta_heterogenous, bidbid2bi2bdbd2b.
%
% 2011.09.10 - 2012.01.22 (c) Ioannis Filippidis, jfilippidis@gmail.com

[~, npnt] = size(q);
no = size(ellipsoids, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single ellipsoid
if no == 1
    %Dbi = nan(ndim, npnt);
    
    curellipsoid = ellipsoids(1, 1);
    
    qc = curellipsoid.qc;
    A = curellipsoid.A;
    rot = curellipsoid.rot;
    
    [b1, Db1, D2b1] = beta_ellipsoid(q, qc, rot, A);
    %[b1, Db1, D2b1] = beta_quadric_normalized(q, qc, rot, A);
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple ellipsoids
Dbi = cell(no, 1);

for i=1:no
    curellipsoid = ellipsoids(i, 1);
    
    qc = curellipsoid.qc;
    A = curellipsoid.A;
    rot = curellipsoid.rot;
    
    [b1, Db1, D2b1] = beta_ellipsoid(q, qc, rot, A);
    %[b1, Db1, D2b1] = beta_quadric_normalized(q, qc, rot, A);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
