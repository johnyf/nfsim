function [b] = bi2b(bi)
%BI2B   multiply multiple obstacle functions
%
% usage
%   [b] = BI2B(bi)
%
% input
%   bi = [#obstacles x #points]
%
% output
%   b = [1 x #points]
%
% See also DBI2DB, D2BI2D2B, BIDBID2BI2BDBD2B.
%
% File:      bi2b.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.07.31
% Language:  MATLAB R2011a
% Purpose:   calculate b from individual obstacles' bi
% Copyright: Ioannis Filippidis, 2011-

% multiply individual obstacle functions
% (if multiple b values are given per calculation point)
b = prod(bi, 1);
