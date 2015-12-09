function [] = test_local_explicit_diffeo_gluing

cls

fun1 = @calc_f1;
fun2 = @calc_f2;

n = 51;
Dx = 1;
x = linspace(-Dx, Dx, n);
m = 80;
fmax = [feval(fun1, -Dx), feval(fun2, +Dx) ];
ymax = max(fmax);
y = linspace(0, ymax, m);

%plot(newax, x, calc_g(x) )

axb = newax;
%ax = newax;
%hold(ax, 'on')
for i=1:n
    curx = x(1, i);
    
    lambda = -1;
    [u, v1] = local_explicit_diffeo_glue(curx, y, fun1, axb, lambda);
    lambda = 1;
    [u, v2] = local_explicit_diffeo_glue(curx, y, fun2, axb, lambda);
    
    if u < 0
        v = v1;
    else
        v = v2;
    end
    %plot(ax, u, v, 'o')
    
    X(1:m, i) = curx;
    
    cury = y;
    f1 = feval(fun1, curx);
    f2 = feval(fun2, curx);
    
    if curx < 0
        cury(1, f1 < cury) = nan;
    else
        cury(1, f2 < cury) = nan;
    end
    Y(:, i) = cury.';
    
    U(1:m, i) = u;
    V(:, i) = v;
end

fig = figure;
ax1 = subplot(1, 2, 1, 'Parent', fig);
ax2 = subplot(1, 2, 2, 'Parent', fig);
mesh(ax1, X, Y, zeros(size(U) ), 'EdgeColor', 'b')
mesh(ax2, U, V, zeros(size(U) ), 'EdgeColor', 'b')
view(ax1, 2)
axis(ax1, 'normal')
view(ax2, 2)
axis(ax2, 'equal')

function [u, v] = local_explicit_diffeo_glue(x, y, fun, axb, lambda)
u = x;

delta = 0;

g  = calc_g(x);
s = sigma_switch_at_delta(x, delta, lambda);

%%
f1 = feval(fun, x);
f10 = feval(fun, 0);

bm = calc_b(x, f1, delta, lambda, fun);
b0m = calc_b0(0, f10, fun);

y(1, f1 < y) = nan;
y0 = f10 *y/f1;

%{
m = 11;
y = linspace(0, f1, m);
y0 = linspace(0, f10, m);
%}
b = calc_b(x, y, delta, lambda, fun);
b0 = calc_b0(0, y0, fun);


hold(axb, 'on')
plot(axb, y, b, 'b-')
plot(axb, y0, b0, 'r-')
plot(axb, [f1, f1], [0, 1], 'b--')
plot(axb, [f10, f10], [0, 1], 'r--')

v = g *(s .*b +(1-s) .*b0) ./(s .*bm +(1-s) .*b0m);

function [b0] = calc_b0(x, y, fun)
g0 = calc_g(0);
gmax = 10;

B = gmax /g0;

f1 = feval(fun, x);

A = -B /f1 /2+1;

b0 = A *y.^2 +B *y;

function [b] = calc_b(x, y, delta, lambda, fun)

if x == 0
    b = calc_b0(x, y, fun);
    return
end

s = sigma_switch_at_delta(x, delta, lambda);
g = calc_g(x);
g0 = calc_g(delta);
gmax = 10; %calc_g(-1);

bmax = gmax /g0;

B = 1 ./s .*(bmax ./g -(1 -s) /g0);

f1 = feval(fun, x);

A = 1 /f1^2 *(bmax -B *f1/2) +1;

b = A *y.^2 +B *y;

function [s] = sigma_switch_at_delta(x, delta, lambda)
if nargin < 2
    delta = 0;
end

if nargin < 3
    lambda = 1;
end

x = lambda *(x -delta);
s = 1 -sigma_switch(x);

function [g] = calc_g(x)
g = -x.^2 +1;

function [f1] = calc_f1(x)
f1 = -2 *x +1;

function [f2] = calc_f2(x)
f2 = +2 *x +1;
