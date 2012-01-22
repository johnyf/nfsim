function [field] = navigation_function(type, varargin)
% File:      navigation_function.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15 - 2011.07.29
% Language:  MATLAB R2011a
% Purpose:   choose navigation function type, return value @ x
% Copyright: Ioannis Filippidis, 2010-
%
% [field] = navigation_function(type, varargin)
%
% field = the potential field value calculated at the points specified
% type = name of method to be used. Available (for description see below):
%       'khatib', 'krnfs', 'krnf', 'nf_polynomial'
% varargin = whatever arguments the potential field function called needs
%       FOR DETAILS about them see each function's M-file.
%
% Note:
% It is not mandatory to use this selector, it is provided only to
% facilitate the user. The functions referenced here can be called
% directly.

switch type
    case 'khatib'
        field = khatib(varargin{:} );
    case 'krnfs'
        field = krnfs(varargin{:} );
    case 'krnf'
        field = krnf(varargin{:} );
    case 'polynomial'
        field = pnfs(varargin{:} );
    otherwise
        error(['Unknown potential field methodology type: ', type,...
            'Available ones: khatib, krnfs, krnf, polynomial, rvachev.'] )
end
