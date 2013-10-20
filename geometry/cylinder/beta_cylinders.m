function [bi, Dbi, D2bi] = beta_cylinders(q, cylinders)
%BETA_CYLINDERS     Obstacle and derivatives for multiple cylinders.
%
%usage
%-----
%   [bi, Dbi, D2bi] = beta_cylinders(q, cylinders)
%
%inputs
%------
%   q = calculation points
%     = [#dimensions x #points]
%   cylinders = structure array of cylinder objects
%             = [#cylinders x 1], for struct fields see beta_cylinder.
%
%about
%-----
% 2012.09.01 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also beta_cylinder, plot_cylinders, create_cylinders,
%          beta_heterogenous, biDbiD2bi2bDbD2b.

[ndim, npnt] = size(q);
no = size(cylinders, 1);

bi = nan(no, npnt);
D2bi = cell(no, npnt);

%% single half-space
if no == 1
    Dbi = nan(ndim, npnt);
    
    curcylinder = cylinders(1, 1);
    
    qc = curcylinder.qc;
    r = curcylinder.r;
    rot = curcylinder.rot;
    
    [b1, Db1, D2b1] = beta_cylinder(q, qc, r, rot);
    bi(1, :) = b1;
    Dbi = Db1;
    D2bi = D2b1;
    
    return
end

%% multiple half-spaces
Dbi = cell(no, 1);

for i=1:no
    curcylinder = cylinders(i, 1);
    
    qc = curcylinder.qc;
    r = curcylinder.r;
    rot = curcylinder.rot;
    
    [b1, Db1, D2b1] = beta_cylinder(q, qc, r, rot);
    bi(i, :) = b1;
    Dbi{i, 1} = Db1;
    D2bi(i, :) = D2b1;
end
