function [bi, Dbi, D2bi] = beta_supercyclides(q, supercyclides)
% Obstacle function for supercyclides.
%
% usage
%   [bi, Dbi, D2bi] = beta_supercyclides(q, supercyclides)
%
% input
%   q = calculation points
%     = [#dim x #pnts]
%   supercyclides = structure array
%            = [#supercyclides x 1]
%       struct fields of supercyclides(i, 1):
%           qc = center
%              = [#dim x 1]
%           R, rm, dr, rot, q0
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
% 2013.06.16 (c) Ioannis Filippidis, jfilippidis@gmail.com

% todo
%   fix the help text

[~, npnt] = size(q);
no = size(supercyclides, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single supercyclide
if no == 1
    %Dbi = nan(ndim, npnt);
    
    curcyclide = supercyclides(1, 1);
    
    qc = curcyclide.qc;
    R = curcyclide.R;
    rm = curcyclide.rm;
    dr = curcyclide.dr;
    rot = curcyclide.rot;
    q0 = curcyclide.q0;
    
    [b1, Db1, D2b1] = beta_supercyclide(q, qc, R, rm, dr, rot, q0);
    
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple supercyclides
Dbi = cell(no, 1);

for i=1:no
    curcyclide = supercyclides(i, 1);
    
    qc = curcyclide.qc;
    R = curcyclide.R;
    rm = curcyclide.rm;
    dr = curcyclide.dr;
    rot = curcyclide.rot;
    q0 = curcyclide.q0;
    
    [b1, Db1, D2b1] = beta_supercyclide(q, qc, R, rm, dr, rot, q0);
    
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
