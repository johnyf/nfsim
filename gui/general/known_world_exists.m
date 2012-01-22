function [exists] = known_world_exists(S, varargin)
    if nargin == 2
        output = varargin{1};
    else
        output = 1;
    end

    exists = isfield(S, 'known_world');

    if ~exists && (output ~= 0)
        disp('Known world not yet a field (not even empty field).')
    end
end