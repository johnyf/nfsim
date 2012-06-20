function [varargout] = clean_inside_obstacle(bi, varargin)
% input
%   bi = [1 x #points]
%   varargin{i} = q = [#dim x #points]

for i=1:(nargin -1)
    q = varargin{i};
    
    q(:, bi <= 0) = nan;
    
    varargout{i} = q;
end
