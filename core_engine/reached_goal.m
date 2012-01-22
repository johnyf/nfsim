% File:      reached_goal.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.14 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   navigation loop termination criteria checking
% Copyright: Ioannis Filippidis, 2010-

function [flag] = reached_goal(agent, criteria)
if norm(agent.xcur -agent.xd, 2) < criteria.convergence_error
    disp('Reached destination xd.')
    flag = 1;
else
    flag = 0;
end
