function [f, Df, D2f] = scale_fDfD2f(f, Df, D2f, scaling_factor)
f = scaling_factor *f;
Df = scaling_factor *Df;

n = size(D2f, 2);
lambda = repmat({scaling_factor}, 1, n);

D2f = cellfun(@(x, y) x*y, D2f, lambda, 'UniformOutput', false);
