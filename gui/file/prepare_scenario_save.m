% File:      prepare_scenario_save.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.14
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   package variables to be saved
% Copyright: Ioannis Filippidis, 2010-

function [vars] = prepare_scenario_save(fields, S)
% save what is available

for i=1:size(fields, 2)
    field = fields{1,i};
    
    if isfield(S, field)
        vars.(field) = S.(field);
    else
        vars.(field) = [];
    end
end
