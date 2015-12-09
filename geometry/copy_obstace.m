function [obstacles] = copy_obstacle(type, n, from, to)
%COPY_OBSTACLE  copy obstacle between obstacle structure arrays
%
% usage
%   [OBSTACLES] = COPY_OBSTACLE(TYPE, N, FROM, TO)
%
% input
%   type = 'quadrics' | 'inward_quadrics' | 'tori' | 'spheres' |
%          'superellipsoids' | 'supertoroids' | 'halfspaces'
%   n = index of obstacle to copy
%   from = obstacles structure array from where to copy
%   to = obstacles structure array to where to copy
%
% output
%   obstacles = new obstacle structure array including copied obstacle
%
% See also BETA_HETEROGENOUS.
%
% File:      copy_obstacle.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot world
% Copyright: Ioannis Filippidis, 2010-

idxfrom = find_type_idx(from, type);
idxto = find_type_idx(to, type);

fromdata = from(1, idxfrom).data;
todata = to(1, idxto).data;

N = size(todata, 1);

todata(N+1, 1) = fromdata(n, 1);

obstacles = to;
obstacles(1, idxto).data = todata;

function [idx] = find_type_idx(obstacles, type)
ntypes = size(obstacles, 2);
for i=1:ntypes
    curtype = obstacles(1, i).type;
    
    if strcmp(curtype, type)
        idx = i;
        break
    end
end
