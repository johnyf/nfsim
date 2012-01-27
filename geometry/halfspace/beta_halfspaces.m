function [bi, Dbi, D2bi] = beta_halfspaces(q, halfspaces)
%BETA_HALFSPACES
%
% inputs
%   q = calculation points
%     = [#dimensions x #points]
%   halfspaces = [#obstacles x 1]
%       halfspaces(i, 1).qp = {#obstacles, 1}
%                            = half-space dividing plane points
%       halfspaces(i, 1).n = {#obstacles, 1}
%                           = half-space normal vectors to dividing planes
%
% See also BETA_HALFSPACE, BETA_HETEROGENOUS, BIDBID2BI2BDBD2B.
%
% File:      beta_halfspaces.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.25
% Language:  MATLAB R2011b
% Purpose:   beta for multiple half-spaces
% Copyright: Ioannis Filippidis, 2011-

% todo: add second derivative (Hessian matrix)

[ndim, npnt] = size(q);
no = size(halfspaces, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single half-space
if no == 1
    Dbi = nan(ndim, npnt);
    
    curhalfspace = halfspaces(1, 1);
    
    qp = curhalfspace.qp;
    n = curhalfspace.n;
    
    [b1, Db1, D2b1] = beta_halfspace(q, qp, n);
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple half-spaces
Dbi = cell(no, 1);

for i=1:no
    curhalfspace = halfspaces(i, 1);
    
    qp = curhalfspace.qp;
    n = curhalfspace.n;
    
    [b1, Db1, D2b1] = beta_halfspace(q, qp, n);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
