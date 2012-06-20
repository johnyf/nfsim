function [h] = plot_booth_lemniscates(ax, lemniscates, npnt, varargin)
%
% See also PLOT_LEMNISCATE_BOOTH, BETA_LEMNISCATE_BOOTH,
%          PARAMETRIC_LEMNISCATE_BOOTH, PARAMETRIC_LEMNISCATE_BOOTH2,
%          TEST_LEMNISCATE_BOOTH.
%
% File:      plot_booth_lemniscates.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.05.25
% Language:  MATLAB R2012a
% Purpose:   plot multiple Booth lemniscates
% Copyright: Ioannis Filippidis, 2012-

n = size(lemniscates, 1);

held = takehold(ax, 'local');
h = nan(n, 1);
for i=1:n
    qc = lemniscates(i, 1).qc;
    a = lemniscates(i, 1).a;
    b = lemniscates(i, 1).b;
    e = lemniscates(i, 1).e;
    h(i, 1) = plot_lemniscate_booth2(ax, qc, a, b, e, npnt, 'cartesian', varargin{:} );
end
restorehold(ax, held)

if nargout == 0
    clear('q')
end
