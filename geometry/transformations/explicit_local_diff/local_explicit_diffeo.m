function [q, rnew] = local_explicit_diffeo(theta, r, r_in, r_out, qc, rho)
%
% usage
%   [q, r_new, r, theta] = LOCAL_EXPLICIT_DIFFEO(x, xi, rho, r_in, r_out)
%
% input
%   theta = polar angle coordinate
%         = [1 x #points]
%   r = polar radius coordinate
%     = [1 x #points]
%   r_in = obstacle radius at 
%   r_out = local diffeomorphism radius of effect
%   rho = model sphere radius
%       > 0
%
% reference:
%   Lionis; Papageorgiou; Kyriakopoulos, ICRA 2007
%
% See also TEST_LOCAL_EXPLICIT_DIFFEO, TI, JTI.
%
% File:      local_explicit_diffeo.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15 - 2012.05.21
% Language:  MATLAB R2010b
% Purpose:   Apply diffeomorphism
% Copyright: Ioannis Filippidis, 2010-

% depends
%   Ti

% Note
%   At first, it appears that it is preferrable to input and output
%   cartesian coordinates.
%   But, since r_in, r_out are inherently polar and depend on the obstacle,
%   input in polar coordinates is mandatory.

%% real local polar coordinates -> sphere world local polar
T = Ti(theta, r, r_in, r_out, rho);

%% sphere world local polar -> sphere world global cartesian
rnew = T(1, :);
q = vpol2cart(theta, rnew);
q = bsxfun(@plus, q, qc);
