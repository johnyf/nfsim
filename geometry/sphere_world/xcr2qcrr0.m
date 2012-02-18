function [qc, r, r0] = xcr2qcrr0(xc, r)

r0 = -r(r < 0);
if isempty(r0)
    r0 = -1;
end
xc = xc(:, r > 0);
r = r(r > 0);

qc = xc;
