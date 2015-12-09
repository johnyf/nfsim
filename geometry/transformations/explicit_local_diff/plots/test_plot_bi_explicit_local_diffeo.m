function [] = test_plot_bi_explicit_local_diffeo
%
% See also PLOT_BI.
%
% File:         test_plot_bi_explicit_local_diffeo.m
% Programmer:   Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2012.05.21
% Language:     MATLAB R2012a
% Purpose:      compare Lionis-Papageorgiou with proposed,
%               to illustrate that their conditions are not correct
% Copyright:    Ioannis Filippidis, 2012-

% depends
%   plot_bi

close all

% 10, 11, 12 % LPK no inverse (not a homeomorphism)
% 7.57, 11, 12 % LPK invertible, but inverse not differentiable
%                                (homeomorphism but not diffeomorphism)
% 1, 2, 3 % LPK ok (but this is a special case only!)

ri = 7.57;
r_in = 11;
r_out = 12;

plot_bi(ri, r_in, r_out)
