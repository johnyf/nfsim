function [q] = parametric_ellipse(t, qi, a, b, c)
x = a .*cos(t) .*cos(c) -b .*sin(t) .*sin(c);
y = a .*cos(t) .*sin(c) -b .*sin(t) .*cos(c);

q = bsxfun(@plus, qi, [x; y]);
