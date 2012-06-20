function [] = plot_hyperboloid(ax, xc, A, zlimits, varargin)
%PLOT_HYPERBOLOID   Plot one-sheet hyperboloid.
%
% See also BETA_HYPERBOLOID, BETA_HYPERBOLOIDS, PLOT_HYPERBOLOIDS.

%% transform to aligned coordinates


%% work there
theta = linspace(0, 2*pi, 100);
u = linspace(2, -2, 100);
[Theta, U] = meshgrid(theta, u);

%m = 0.6; % hyperquadric

a = 1./A(1,1).^0.5;
b = 1./A(2,2).^0.5;
c = 1./(-A(3,3) ).^0.5;

R = (1 +U .^2) .^0.5;
X = a .*R .*cos(Theta) +xc(1,1);
Y = b .*R .*sin(Theta) +xc(2,1);
Z = c .*U +xc(3,1);

if exist('zlimits')
    Z(Z < zlimits(1) ) = nan;
    Z(zlimits(2) < Z) = nan;
end

surf(ax, X, Y, Z, varargin{:} )
