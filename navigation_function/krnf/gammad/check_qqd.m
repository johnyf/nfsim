function check_qqd(q, qd)
ndim = size(q, 1);

% check destination dimension
if size(qd, 1) ~= ndim
    error('Dimension = size(q, 1) ~= size(qd, 1)')
end

% check a single destination has been provided
if size(qd, 2) ~= 1
    error('Number of destinations size(qd, 2) ~= 1')
end
