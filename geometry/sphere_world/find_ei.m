function [idx, e] = find_ei(q, qi, ri)
% File:      find_ei.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.20 - 2011.07.31
% Language:  MATLAB R2011a
% Purpose:   find closest obstacle in sphere world
% Copyright: Ioannis Filippidis, 2010-

idx = -ones(1, size(q,2));
e = zeros(1, size(qi,2));

% for all known obstacles
for i=1:size(qi,2)
    % ei found
    e(1,i) = +inf; % init min search
    q1 = qi(:,i);
    
    for j=1:size(qi,2)
        % the same?
        if (i == j)
            continue;
        end

        % other obstacle
        q2 = qi(:,j);
        d12 = norm(q1-q2, 2); % distance of centers

        e12_sup = d12 - ri(1,i) - ri(1,j); % reduce by 2-sphere radii
        e12 = 0.3 *e12_sup; % ensure space for both and disconnectness

        % smallest until now?
        if (e12 < e(1,i))
            e(1,i) = e12; % keep it
        end
    end

    % if a single obstacle, then select bounded radius
    if e(1,i) == +inf
        e(1,i) = 2 *ri(1,i); % effect zone > sphere obstacle!
    end

    % check if points are within effect zone of obstacle
    q_q1 = bsxfun(@minus, q, q1);
    n1 = vnorm(q_q1, 1, 2);

    idx_q = find( n1 <= (ri(1,i) +e(1,i)) );
    idx(idx_q) = ones( size(idx_q) ) .*i;
end
