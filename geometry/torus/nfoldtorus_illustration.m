function nfoldtorus()
% illustration of a triple torus

% torus radii
r = 1;
R = 3;

Kb = R+r;
Ks = R-r;

% Km controls the smoothness of the transition from one ring to the others
Km = 0.5125*Kb;

L = 2.5*(r+R);

h = 0.2; % grid size

X = (-L):h:L; m = length(X);
Y = (-L):h:L; n = length(Y);
Z = (-1.1*r):h:(1.1*r); k = length(Z);

W = zeros(m, n, k);

for i=1:length(X)
    for j=1:length(Y)
        x = X(i);
        y = Y(j);
        
        [x, y] = triple_torus_function (x, y, r, R, Kb, Km);
        val = (sqrt(x^2+y^2)-R)^2-r^2;
        W(i, j, :) = val + Z.^2;
        
    end
end

figure(1); clf; hold on;
axis equal; axis off;

light_green=[184, 224, 98]/256; % light green

H = patch(isosurface(X, Y, Z, W, 0));
isonormals(X, Y, Z, W, H);
mycolor = light_green;

set(H, 'FaceColor', mycolor, 'EdgeColor','none', 'FaceAlpha', 1);
set(H, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
set(H, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
set(H, 'SpecularExponent', 108);

daspect([1 1 1]);
axis tight;
colormap(prism(28))
view(-12, 40);

% add in a source of light
camlight (-50, 54); lighting phong;

%print('-dpng', '-r400',  ...
%      sprintf('Triple_torus_illustration.png'));


function [x, y] = triple_torus_function (x, y, r, R, Kb, Km)
% a deformation in the plane, which, when comosed with a torus will give
% a triple torus

%% center of one of the torii
O = [-Kb, -Kb/sqrt(3)];

angle = 2*pi/3;
Mat = [ cos(angle)  -sin(angle); sin(angle)   cos(angle)  ];

p =[x, y]';
phi = atan2(y, x);

if phi >= pi/6 & phi <= 5*pi/6
    p = Mat*p; % rotate 120 degree counterclockwise
elseif phi >= -pi/2 & phi < pi/6
    p = Mat*p; p = Mat*p; % rotate 240 degrees counterclockwise
end

x=p(1); y = p(2);

%% reflect against a line, to merge two cases in one
if y > x/sqrt(3)
    
    p = [x, y];
    v = [cos(2*pi/3), sin(2*pi/3)];
    
    p = p - 2*v*dot(p, v)/dot(v, v);
    x = p(1); y = p(2);
    
end

if x > O(1)
    
    %% project to the y axis, to a point B
    if y < O(2)
        A = [O(1), y];
        B = [0, y];
    else
        A = O;
        
        p = [x, y];
        rho = norm(p-O);
        
        B = O+(Kb/rho)*(p-O);
        %t = -O(1)/(x-O(1));
        %B = [0, O(2)+t*(y-O(2))];
    end
    
    p = [x, y];
    
    d=norm(p-A);
    q = norm(B-A);
    
    d = my_map(d, q, Km);
    p = (d/q)*B+(1-d/q)*A;
    x=p(1); y=p(2);
    
end

% shift towards the origin
x = x-O(1);
y = y-O(2);

function y = my_map(x, Kb, Km)
if x > Kb
    y = Km + 1;
elseif x < Km
    y = x;
else
    y = Km+sin((pi/2)*(x-Km)/(Kb-Km));
end
