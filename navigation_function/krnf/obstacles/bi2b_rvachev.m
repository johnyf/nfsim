function [b] = bi2b_rvachev(bi, operation, type, a)
%
% usage
%   [b] = BI2B_RVACHEV(bi)
%
% input
%   bi = [#obstacles x #points]
%
% output
%   b = [1 x #points]
%
% See also DBI2DB_RVACHEV, D2BI2D2B_RVACHEV, BIDBID2BI2BDBD2B_RVACHEV.
%
% File:      bi2b_rvachev.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.27
% Language:  MATLAB R2011b
% Purpose:   calculate b from individual obstacles' bi
% Copyright: Ioannis Filippidis, 2011-

npnt = size(bi, 2);
b = nan(1, npnt);
for i=1:npnt
    curbi = bi(:, i);
    
    b(1, i) = recursive_rvachev(operation, curbi.', type, a);
end
