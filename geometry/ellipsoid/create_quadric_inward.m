function [quadric] = create_quadric_inward(qc, R, r)
quadric.qc = qc;
quadric.A = radii2ellipsoid(r);
quadric.rot = R;
