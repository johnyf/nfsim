function [] = plot_bi(ri, r_in, r_out)
% Show when it is a diffeomorphism and when it is not.
%
% See also PLOT_T1, SIGMA_SWITCH, TEST_PLOT_BI_EXPLICIT_LOCAL_DIFFEO.
%
% File:      plot_bi.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.19 - 2012.05.21
% Language:  MATLAB R2012a
% Purpose:   plot radius transformation function T1
% Copyright: Ioannis Filippidis, 2010-

% depends
%   sigma_switch, plot_T1
%   newax, tex_plot_annot

r1 = linspace(r_in, r_out);
%x = (r1 - r_in) ./ (r_in - r_out);
% complete range [0,1] -> [r_in, r_out]
x = linspace(0,1);
s = sigma_switch(x);

bi2 = (r1 - r_in) + 1;
% satisfies constraints by Lionis, Papageorgiou & Kyriakopoulos
% because bi < \frac{r_i}{\rho_i} does not hold for some \rho_i > 1

bi = (r1 - r_in) ./ri + 1; % correct

ax = newax;
    plot(ax, r1./r_in, bi2, 'b-')
    hold(ax, 'on')
    plot(ax, r1./r_in, bi, 'g-')
    plot(ax, [r_in, r_out] ./r_in, [r_in, r_out] ./ri, 'r--') % constraint bi< \frac{r_i(r)}{\rho_i}
    grid(ax, 'on')
    plot_scalings(ax, 0)

    tex_plot_annot(ax,...
        '$b_i(r_i)$ functions',...
        '$\frac{r_i}{r_{in}}$ (-)',...
        '$b_i(r_i)$ (-)',...
        [], {'$b_i(r_i)=r_i-r_{in}+1$', '$b_i(r_i)=\frac{r_i-r_{in}}{\rho_i}+1$',...
        '$\frac{r_i}{\rho_i}$'} )
    %export_fig('-pdf', '-painters', 'bi_funcs')

%% Compare T1, T1r

% Notes:
% (1) having an inverse is needed for the transformation to be a
%     diffeomorphism
% (2) being C^2 is required for navigation function property
%     conservation under diffeomorphism.
% (3) non-singular Dh is a requirement for proving conservation of
%     navigation function property under diffeomorphism.

ri_interp = s .*ri + (1-s) .*r_out;
% simple interpolating map (where bi=1 and r is replaced by r_{out})
% r_i(r) = S(x) *\rho_i + (1-S(x)) *r_out
% has T^1_{i,r_i}(r_{out}) = T^1_r(r_{in}) = 0
% so no differentiable inverse exists and it is not C^2

ri1 = s .*ri + (1-s) .*r1;
% bi=1
% has T^1_{i,r_i}(r_{in}) = 0
% so no differentiable inverse exists but it is C^2

ri2 = s .* (r1-r_in+1) .* ri + (1-s) .* r1;
% satisfies constraints by Lionis, Papageorgiou & Kyriakopoulos
% because bi < \frac{r_i}{\rho_i} does not hold for some \rho_i > 1
% has T^1_{i,r_i}(r_i) = 0
% so no differentiable inverse exists and it is not C^2

ax = newax;
    title_str = 'Simple interpolation, not $C^1$';
    fname = 'simple_interpolation';
    plot(r1./r_in, ri_interp./ri)
    plot_remaining_lines(ax, ri, r_in, r_out, title_str, fname)

ax = newax;
    title_str = '$b_i=1$, $C^2$, but inverse not differentiable';
    fname = 'bi_1';
    plot(r1./r_in, ri1./ri)
    plot_remaining_lines(ax, ri, r_in, r_out, title_str, fname)

ax = newax;
    %title_str = 'satisfies LPK, but no inverse';
    title_str = 'satisfies LPK, but inverse not differentiable';
    %title_str = 'satisfies LPK, but special case';
    fname = 'lionis_papageorgiou';
    plot(r1./r_in, ri2./ri)
    plot_remaining_lines(ax, ri, r_in, r_out, title_str, fname)

plot_T1(ri, r_in, r_out) % correct

function plot_remaining_lines(ax, ri, r_in, r_out, title_str, fname)
hold(ax, 'on')
plot(ax, [r_in, r_out] ./r_in, [r_out, r_out] ./ri, 'r--') % y = r_{out} /\rho_i
plot(ax, [r_out, r_out] ./r_in, [ri, r_out] ./ri, 'r--') % x = r_{out} /r_in

plot(ax, [r_in, r_out] ./r_in, [ri, r_out] ./ri, 'm--') % ri /\rho_i = r/r_in line
plot(ax, [r_out, 1.1*r_out] ./r_in, [r_out, 1.1*r_out] ./ri, 'b-') % part of identity map
grid(ax, 'on')
plot_scalings(ax, 0)

tex_plot_annot(ax,...
    {'$\frac{r_i(r)}{\rho_i}$ radius transformation function', title_str},...
    '$\frac{r}{r_{in}}$ (-)',...
    '$\frac{r_i(r)}{\rho_i}$ (-)',...
    [], {'$\frac{r_i(r)}{\rho_i} = \frac{T^1(r,\theta)}{\rho_i}$',...
    '$\frac{r_{out}}{\rho_i}$'} )
%export_fig('-pdf', '-painters', fname)
