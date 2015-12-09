function [] = check_krf_args(gd, b, k)
% Koditschek-Rimon test general world arguments
%
% 2011.07.29 (c) Ioannis Filippidis, jfilippidis@gmail.com

N = size(gd, 2); % number of calculation points

%% any calculation points?
if N == 0
    error('No configurations q at which to calculate the gradient are given.')
end

%% test destination
if size(gd, 1) ~= 1
    error('Multiple destinations given instead of a single one.')
end

%% test beta values
if size(b, 2) ~= N
    error(['Obstacle implicit function size not corresponding to all '...
        'calculation points.'] )
end

if size(b, 1) == 0
    error(['Empty matrix of obstacle implicit function'...
        'values at calculation points.'] )
end

%% test k
if ~isscalar(k)
    error('Tuning parameter k is not scalar.')
end

if k < 2
    %warning( ['Koditschek-Rimon Navigation Function Method'...
    %   ' only defined for k >=2.'] )
end

if k > 10
    %warning(['For values of k > 10 accuracy of KRNF gradient is low '...
    %         'due to the large exponentation errors.'] )
end
