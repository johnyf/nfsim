function [v] = binary_operator(operator, v1, v2)
%BINARY_OPERATOR    Binary propositional operators used in CSG.
%
% input
%   v = BINARY_OPERATOR(operator, v1, v2)
%
% input
%   operator = selected binary operator
%             = 'or' | 'union' | 'disjunction' | '||' | '|' |
%               'and' | 'intersection' | 'conjunction' | '&&' | '&'
%   v1 = struct with fields 'bi', 'Dbi', 'D2bi'
%   v2 = struct similar to v1
%
% output
%   v = result of binary operation, struct similar to v1
%
% See also csg, unary_operator, biDbiD2bi2bDbD2b_rvachev.
%
% File:      binary_operator.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.09
% Language:  MATLAB R2012a
% Purpose:   binary Rvachev operator interface to csg
% Copyright: Ioannis Filippidis, 2012-

% depends
%   biDbiD2bi2bDbD2b_rvachev

bi = [v1.bi; v2.bi];
Dbi = [{v1.Dbi}; {v2.Dbi}];
D2bi = [v1.D2bi; v2.D2bi];

[b, Db, D2b] = biDbiD2bi2bDbD2b_rvachev(bi, Dbi, D2bi, operator);

v.bi = b;
v.Dbi = Db;
v.D2bi = D2b;
