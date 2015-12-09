% illustration of a torus, obtained as an isosurface (from wikipedia)
% big and small radii of the torus
R = 5; r = 1; 

Kb = R+r;

h = 0.1; % h is the grid size. Smaller h means prettier picture.

X = (-Kb-h):h:(Kb+h);   m = length(X);
Y = (-Kb-h):h:(Kb+h);   n = length(Y);
Z = (-r-h):h:(r+h);     k = length(Z);

W = zeros(m, n, k); % the zero level set of this function will be the desired shape

for i=1:m
  for j=1:n
     x = X(i);
     y = Y(j); 
     W(i, j, :) = (sqrt(x^2+y^2)-R)^2 + Z.^2-r^2; % torus eqn, vectorize in Z
  end
end

figure(4); clf; hold on; axis equal; axis off;

H = patch(isosurface(W, 0));
isonormals(W, H);

light_green=[184, 224, 98]/256;

% set some propeties
set(H, 'FaceColor', light_green, 'EdgeColor','none', 'FaceAlpha', 1);
set(H, 'SpecularColorReflectance', 0.1, 'DiffuseStrength', 0.8);
set(H, 'FaceLighting', 'phong', 'AmbientStrength', 0.3);
set(H, 'SpecularExponent', 108);

daspect([1 1 1]);
axis tight;
colormap(prism(28))

% viewing angle
view(-146, 32);

% add in a source of light
camlight (-10, 54); lighting phong;

%save as png
%print('-dpng', '-r400', sprintf('Torus_illustration.png'));
