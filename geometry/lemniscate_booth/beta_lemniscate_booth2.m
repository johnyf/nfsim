function [bi, Dbi, D2bi] = beta_lemniscate_booth2(q, qc, a, b, e, rot)
%BETA_LEMNISCATE_BOOTH2  Booth leminiscate obstacle function.
%
% usage
%   [bi, Dbi, D2bi] = BETA_LEMNISCATE_BOOTH2(q)
%   [bi, Dbi, D2bi] = BETA_LEMNISCATE_BOOTH2(q, qc, a, b, e, rot)
%
% input
%   q = calculation points
%     = [2 x #points]
%
% optional input
%   qc = leminiscate center (default: qc = [0, 0].')
%      = [2 x 1] = [xc, yc].'
%   a = leminiscate axis ratio (default: a = 0.8)
%     > 0
%   r0 = leminiscate scale (default: r0 = 1)
%      > 0
%   rot = rotation matrix of leminiscate axes (default: rot = eye(2) )
%       = [2 x 2] \in SO(2)
%
% output
%   bi = Booth Leminiscate obstacle function values at q
%      = [1 x #points]
%
% See also PLOT_LEMNISCATE_BOOTH, TEST_LEMNISCATE_BOOTH,
%          PARAMETRIC_LEMNISCATE_BOOTH.
%
% File:      beta_lemniscate_booth.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.21
% Language:  MATLAB R2012a
% Purpose:   Booth leminiscate obstacle function
% Copyright: Ioannis Filippidis, 2012-

if nargin < 2
    qc = zeros(2, 1);
end

if nargin < 3
    a = 0.8;
end

if nargin < 4
    b = 1;
end

if nargin < 5
    e = 0.5;
end

if nargin < 6
    rot = eye(2);
end

qi = global2local_cart(q, qc, rot);

npnt = size(qi, 2);
bi = nan(1, npnt);

x = qi(1, :);
y = qi(2, :);

nqi = vnorm(qi, 1, 2);

c = e *b^2;
bi(1, :) = nqi.^4 -a^2 *x.^2 -c *y.^2;

Dbi = 4 *bsxfun(@times, nqi.^2, qi) -diag([2*a^2, 2*c] ) *qi;

D2bi = 'not yet implemented';

%{
Dbi(:, 1:npnt) = 4 .*[x .*(nqi2 -R^2 -r^2);
                      y .*(nqi2 -R^2 -r^2) ];
                  
Dbi = rot *Dbi;

a1 = 4 .*(3 .*x.^2 +y.^2 +z.^2 -R^2 -r^2);
a2 = 8 .*x .*y;
a3 = 8 .*x .*z;
a4 = 8 .*x .*y;
a5 = 4 .*(x.^2 +3 .*y.^2 +z.^2 -R^2 -r^2);
a6 = 8 .*y .*z;
a7 = 8 .*x .*z;
a8 = 8 .*y .*z;
a9 = 4 .*(x.^2 +y.^2 +3 .*z.^2 +R^2 -r^2);

D2bi = cell(1, npnt);
for i=1:npnt    
    curD2bi = [a1(1, i), a2(1, i), a3(1, i);
               a4(1, i), a5(1, i), a6(1, i);
               a7(1, i), a8(1, i), a9(1, i) ];
    
    curD2bi = rot *curD2bi *rot.';
    D2bi{1, i} = curD2bi;
end
%}
