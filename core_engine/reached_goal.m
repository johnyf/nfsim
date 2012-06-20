function [flag, I] = reached_goal(x, xd, convergence_error)
% File:      reached_goal.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.14 - 2012.05.13
% Language:  MATLAB R2012a
% Purpose:   navigation loop termination criteria checking
% Copyright: Ioannis Filippidis, 2010-

x_xd = bsxfun(@minus, x, xd);
error = vnorm(x_xd, 1, 2);
acceptable = (error < convergence_error);

if any(acceptable)
    disp('Reached destination xd.')
    
    I = find(acceptable);
    
    flag = 1;
else
    I = [];
    flag = 0;
end
