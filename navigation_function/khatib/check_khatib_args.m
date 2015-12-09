function [kp, h, b0] = check_khatib_args(bi, kp, eta, b0)
% File:      check_khatib_args.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.08.03 
% Language:  MATLAB R2011a
% Purpose:   check arguments provided to Khatib potential field
% Copyright: Ioannis Filippidis, 2011-

N = size(bi, 2); % number of calculation points

%% any calculation points?
if N == 0
    error('No configurations q at which to calculate the gradient are given.')
end

%% test beta values
if size(bi, 2) ~= N
    error(['Obstacle implicit function size not corresponding to all '...
        'calculation points.'] )
end

if size(bi, 1) == 0
    error(['Empty matrix of obstacle implicit function'...
        'values at calculation points.'] )
end

%% test parameters
if kp <= 0
    error(['Khatib attractive scalar field parameter kp '...
        'should be positive (kp > 0).'] )
end

if eta <= 0
    error(['Khatib repulsive scalar field parameter eta '...
        'should be positive (eta > 0).'] )
else
    h = eta;
end

if b0 < 0
    error(['Khatib repulsive scalar field threshold b0 '...
        'should be positive (b0 > 0).'] )
end
