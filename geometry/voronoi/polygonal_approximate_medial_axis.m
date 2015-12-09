% Construct a constrained Delaunay triangulation of a sample of points
% on the domain boundary.
load trimesh2d
dt = DelaunayTri(x,y,Constraints);
inside = dt.inOutStatus();

% Construct a TriRep to represent the domain triangles.
tr = TriRep(dt(inside, :), dt.X);

% Construct a set of edges that join the circumcenters of neighboring
% triangles; the additional logic constructs a unique set of such edges.
numt = size(tr,1);
T = (1:numt)';
neigh = tr.neighbors();
cc = tr.circumcenters();
xcc = cc(:,1);
ycc = cc(:,2);
idx1 = T < neigh(:,1);
idx2 = T < neigh(:,2);
idx3 = T < neigh(:,3);
neigh = [T(idx1) neigh(idx1,1); T(idx2) neigh(idx2,2); T(idx3) neigh(idx3,3)]';

% Plot the domain triangles in green, the domain boundary in blue and the
% medial axis in red.
clf;
triplot(tr, 'g');
hold on;
plot(xcc(neigh), ycc(neigh), '-r', 'LineWidth', 1.5);
axis([-10 310 -10 310]);
axis equal;
plot(x(Constraints'),y(Constraints'), '-b', 'LineWidth', 1.5);
xlabel('Medial Axis of a Polygonal Domain', 'fontweight','b');
hold off;

