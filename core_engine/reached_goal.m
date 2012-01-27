function [flag] = reached_goal(agent, criteria)
% File:      reached_goal.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.12.14 - 
% Language:  MATLAB R2011b
% Purpose:   navigation loop termination criteria checking
% Copyright: Ioannis Filippidis, 2010-

if norm(agent.xcur -agent.xd, 2) < criteria.convergence_error
    disp('Reached destination xd.')
    flag = 1;
else
    flag = 0;
end
