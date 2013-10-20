function [values] = nf_contour_values(Nlevels, mine, maxe)
% pick level set values for NF contours,
% because NFs tend to have a lot of info squized in [0.98, 1]
%
% 2013.03.14 (c) Ioannis Filippidis
%
% See also plot_paper_figure, concave_krf_failure.

if nargin < 2
    mine = 0;
end

if nargin < 3
    maxe = 13;
end

values = [1-exp(-linspace(mine, maxe, Nlevels) ), 0];
