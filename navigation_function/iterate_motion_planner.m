function [varargout] = iterate_motion_planner(type, varargin)
% File:      iterate_motion_planner.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.06.03 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   updates tuning & data for specific motion planning method
% Copyright: Ioannis Filippidis, 2010-

switch type
    case 'krnfs'
        varargout{1} = krnfs_iter(varargin{:} );
    case 'krnf_simple'
        varargout{1} = k_calc_hunt(varargin{:} );
    otherwise
        error('Unknown motion planner for iteration algorithm selection.')
end
