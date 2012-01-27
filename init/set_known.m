function [known_world] = set_known(known, known_world, n)
% File:      set_known.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.04.12
% Language:  MATLAB R2011b
% Purpose:   set specified obstacle to known status
% Copyright: Ioannis Filippidis, 2011-

if (known == 0)
    known_world.id = [];
    known_world.details = {}; % no details
else
    % all M spheres and obstacle 0 known
    known_world.id = 1:n;
    
    details = cell(1, n);
    for i=1:n
        details{1, i} = 1; % all known
    end
    known_world.details = details;
end
