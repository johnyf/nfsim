% File:      test_cylinders.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.01
% Language:  MATLAB R2012a
% Purpose:   test cylinder functions
% Copyright: Ioannis Filippidis, 2012-

nobs = 10;

qc = 10 *rand(3, nobs);
r = 1 *ones(1, nobs);
h = 3 *ones(1, nobs);
axisv = rand(3, nobs);

cylinders = create_cylinders(qc, r, h, axisv);

ax = gca;
hold(ax, 'on')
npnt = 30;
plot_cylinders(ax, cylinders, npnt)
plot_scalings(ax, 0)
axis(ax, 'equal')

npnt = 100;
q = rand(3, npnt);
[bi, Dbi, D2bi] = beta_cylinders(q, cylinders);
