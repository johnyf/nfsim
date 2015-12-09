function [z] = limit_cycle_potential(x, y)
% Palis; Melo, Geometric Theory of Dynamical Systems, pp. 13-15 (Example 3)
%
% File:      limit_cycle_potential.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.12.26
% Language:  MATLAB R2011b
% Purpose:   calculate degenerate potnetial field function
% Copyright: Ioannis Filippidis, 2011-

[th, r] = cart2pol(x, y);

z = nan(size(th) );

a = exp(1 ./(r.^2 -1) );

z(r < 1) = a(r < 1);
z(r == 1) = 0;
b = exp(-1 ./(r.^2 -1) ) .*sin(1 ./(r -1) -th);
z(1 < r) = b(1 < r);