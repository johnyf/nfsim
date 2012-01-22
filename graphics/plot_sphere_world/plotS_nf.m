function [X, Y, nf_field, px, py, fig] =...
    plotS_nf(ax, mask_obstacles, limits, n, type, varargin)
% File:      plotS_nf.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   plot navigation function field in sphere world
% Copyright: Ioannis Filippidis, 2010-
%
% [X, Y, nf_field, px, py, fig] = plotS_nf(ax, mask_obstacles, limits,...
%                                   n, type, varargin)
% limits = [xmin, xmax, ymin, ymax];
% n = [nx, ny]; % number of navigation function sampling points
% agent, world, known_world: see navigation function simulation

%% args
if isempty(ax)
    ax = gca;
end

if isempty(mask_obstacles)
    mask_obstacles = 1;
end

agent = varargin{1};
world = varargin{2};
known_world = varargin{3};

%% parameters
xmin = limits(1);
xmax = limits(2);

ymin = limits(3);
ymax = limits(4);

nx = n(1);
ny = n(2);

dx = (xmax - xmin) /nx;
dy = (ymax - ymin) /ny;

%% caluclate
X = zeros(nx,1);
Y = zeros(ny,1);
nf_field = zeros(ny, nx);

[xc, r] = convex2sphere_world(world, known_world);
r0 = -r(r < 0);
if isempty(r0)
    r0 = -1;
end
xc = xc(:, r > 0);
r = r(r > 0);

qc = xc;
qd = agent.xd;

%% generate valid mesh
q_calc = zeros(size(qd, 1), nx*ny);
valid_point_num = 0;
for j=1:nx
    X(j) = xmin+ (j-1)*dx;
    for i=1:ny
        Y(i) = ymin+ (i-1)*dy;
        q = [X(j); Y(i)];

        nf = 0;

        % point in obstacle?
        for w=1:size(qc,2)
            % 1,...,M
            if norm(q-qc(:,w), 2) <= r(1,w)
                nf = 1;
                break;
            end

            % 0
            if norm(q, 2) >= r0
                nf = 1;
                break;
            end
        end
        
        % cancel obstacle masking (e.g. for Rvachev functions)
        if mask_obstacles == 0
            nf = 0;
        end
        
        if nf == 0
            valid_point_num = valid_point_num + 1;
            q_calc(:, valid_point_num) = q; % calc nf also at this point
        end

        nf_field(i,j) = nf;
    end
    %disp( ['Navigation function field matrix row: ' num2str(j)] )
end
q_calc = q_calc(:, 1:valid_point_num);

px = zeros(size(nf_field));
py = px;

%% calc nf at points \in F
switch type
    case 'polynomial'
        nf_field(nf_field == 0) = phiS(q_calc, qd, qc, r)';
        px = [];
        py = [];
    case 'krnfs'
        idx = find(nf_field == 0);
        
        % CAUTION: agent used to show just the obstacles, not the function
        %          because of large k
        
        %dummy_agent = agent;
        %dummy_agent.xcur = q_calc;
        %known_world.k_mode = 'manual';
        k = known_world.k;
        
        nf_field(idx) = navigation_function(type, q_calc, qd, qc, r0, r, k);
        
        k = known_world.k;
        grad = analytic_grad(type, q_calc, qd, qc, r0, r, k);
        
        px(idx) = grad(1, :);
        py(idx) = grad(2, :);
    otherwise
        error('Unknown navigation function on sphere worlds!')
end

%% show
cla(ax); % leaves annotation intact
hold(ax, 'on'); % keep annotation

fig = plot_nf_surf(ax, X, Y, nf_field);

hold(ax, 'on'); % plot_nf_surf turns it off

if strcmp(type, 'krnfs')
    quiver3(ax, X, Y, -0.1.*ones(size(px) ),...
           -px, -py, zeros(size(px) ), 'Color', 'b')
end

[az, el] = view(ax);
plot_scalings(ax)
view(ax, az, el);

hold(ax, 'off');
