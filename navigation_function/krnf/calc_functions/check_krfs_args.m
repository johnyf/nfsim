function [] = check_krfs_args(q, qd, qc, r0, r, k)
% Koditschek-Rimon test sphere world arguments
%
% 2011.06.04 - 2011.07.29 (c) Ioannis Filippidis, jfilippidis@gmail.com

dim = size(q, 1);

%% any calculation points?
if size(q, 2) == 0
    error('No configurations q at which to calculate the gradient are given.')
end

%% test destination
if size(qd, 1) ~= dim
    error('dimension qd ~= q.')
end

if size(qd, 2) ~= 1
    error('Multiple destinations given.')
end

%% test sphere centers
if size(qc, 1) ~= dim
    error('Dimension of sphere centers qc ~= q given configurations.')
end

M = size(qc, 2);

%% test sphere radii
if size(r, 2) ~= M
    error('Number of sphere centers qc ~= number of radii r.')
end

if isempty(r)
    warning('No internal obstacle known yet because r = [].')
end

if size(r, 1) > 1
    error('Multidimensional radii r given.')
end

if ~isscalar(r0)
    error('Obstacle 0 does not have scalar radius r0.')
end

%% test k
if ~isscalar(k)
    error('Tuning parameter k is not scalar.')
end

if k < 2
    error( ['Koditschek-Rimon Navigation Function Method'...
       ' only defined for k >=2.'] )
end

if k > 10
%    warning(['For values of k > 10 accuracy of KRNF gradient is low '...
%             'due to the large exponentation errors.'] )
end
