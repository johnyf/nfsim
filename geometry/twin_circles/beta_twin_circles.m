function [bi, Dbi, D2bi] = beta_twin_circles(q, qc, r)
% See also PLOT_TWIN_CIRCLES, PARAMETRIC_TWIN_CIRCLES, TEST_TWIN_CIRCLES.
%
% File:      beta_twin_circles.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.22
% Language:  MATLAB R2012a
% Purpose:   obstacle function of two circles, using Rvachev conjunction
% Copyright: Ioannis Filippidis, 2012-

qc1 = qc;
qc2 = [-qc(1, 1), qc(2, 1) ].';

b1 = beta_sphere(q, qc1, r);
b2 = beta_sphere(q, qc2, r);

bi = rvachev('and', b1, b2, 'p', 2);

Dbi = 'not yet implemented';

D2bi = 'not yet implemented';
