function [si] = analytic_switch(b, bi, gd, lambda)
% Reference:
%   Rimon-Koditschek Star Deforming Factor, p.78, TAMS
%
% See also STAR_WORLD_TRANSFORMATION.

%a = lambda .*bi.^2 ./b ./gd;
barbi = b ./bi;
barbi(bi <= 0) = nan;
si = barbi .*gd ./(barbi .*gd +lambda .*bi);

%si(and(b == 0, bi ~= 0) ) = 0; %% fix divisions by 0
