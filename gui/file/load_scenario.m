% File:      load_scenario.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.19
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   load saved file and get packaged variables
% Copyright: Ioannis Filippidis, 2010-

function [loaded] = load_scenario(filename, fields)

a = load(filename, '-mat', 'vars');

vars = a.vars;

for i=1:size(fields, 2)
    field = fields{1,i};
    
    if isfield(vars, field)
        loaded.(field) = vars.(field);
    end
end
