function [known_world] = set_known(known, known_world, n)
if (known == 0)
    known_world.id = [];
    known_world.details = {}; % no details
else
    % all M spheres and obstacle 0 known
    known_world.id = 1:n;
    
    details = {};
    for i=1:n
        details{1, i} = 1; % all known
    end
    known_world.details = details;
end
