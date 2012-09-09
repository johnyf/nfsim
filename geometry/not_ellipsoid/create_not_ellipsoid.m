function [quadric] = create_not_ellipsoid(qc, R, r)
%CREATE_NOT_ELLIPSOID   Define an inward ellipsoid.
%
% See also create_not_ellipsoid, beta_not_ellipsoid.

quadric.qc = qc;
quadric.A = radii2ellipsoid(r);
quadric.rot = R;
