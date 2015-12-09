function [v] = unary_operator(v)
%UNARY_OPERATOR    Unary propositional operator used in CSG.
%
% usage
%   v = unary_operator(v)
%
% input
%   v = struct with fields 'bi', 'Dbi', 'D2bi'
%
% output
%   v = result of binary operation, struct similar to v1
%
% See also csg, binary_operator, biDbiD2bi2bDbD2b_rvachev.
%
% File:      unary_operator.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.09
% Language:  MATLAB R2012a
% Purpose:   unary Rvachev operator interface to csg
% Copyright: Ioannis Filippidis, 2012-

% depends
%   scale_fDfD2f

bi = v.bi;
Dbi = v.Dbi;
D2bi = v.D2bi;

[bi, Dbi, D2bi] = scale_fDfD2f(bi, Dbi, D2bi, -1);

v.bi = bi;
v.Dbi = Dbi;
v.D2bi = D2bi;
