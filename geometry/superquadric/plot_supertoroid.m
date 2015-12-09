function [] = plot_supertoroid(ax, qc, a, e, r, rot, npnt, varargin)
% ax = axes handle
% qc = aligned frame origin
% a = radii
%   = [3 x 1]
% e = epsilon
%   = [2 x 1]
% r = torus radius (major radius)
% R = rotation matrix
%   = [3 x 3]

xc = qc;
epsilon = e;
R = rot;

%% check args
if isempty(ax)
    fig = figure;
    ax = axes('Parent', fig);
end

% epsilon
if size(epsilon, 2) ~= 2
    error('EPSILON needs to be [2 x #superquadrics.')
end

nsupertoroids = size(epsilon, 1);

% a
if size(a, 2) ~= 3
    error('A needs to be [3 x #superquadrics.')
end

if ~isequal(nsupertoroids, size(a, 1) )
    error(['Different number of superquadrics (columns) ',...
          'provided in EPSILON and A.'] )
end

% r
if ~isequal(size(r), [nsupertoroids, 1] )
    error('Number of tori radii does not match that of obstacles.')
end

% xc
% if nargin < 4
%     if nsupertoroids == 1
%         xc = zeros(3, 1);
%     else
%         xc = repmat({zeros(3, 1) }, nsupertoroids, 1);
%     end
% end

if iscell(qc)
    if size(qc, 1) ~= nsupertoroids
        error('Number of origins XC different than obstacles.')
    end
else
    if nsupertoroids ~= 1
        error('Single origin XC provided for multiple obstacles.')
    end
    
    if ~isequal(size(qc), [3, 1] )
        error('Single origin XC is not of dimension [3 x 1].')
    end
end

% R
% if nargin < 5
%     if nsupertoroids == 1
%         rot = eye(3);
%     else
%         rot = repmat({eye(3) }, nsupertoroids, 1);
%     end
% end

if iscell(rot)
    if size(rot, 1) ~= nsupertoroids
        error('Number of rotation matrices does not match obstacles.')
    end
else
    if nsupertoroids ~= 1
        error('Single rotation matrix R provided for multiple obstacles.')
    end
    
    if ~isequal(size(rot), [3, 3] )
        error('Rotation matrix R should be [3 x 3].')
    end
end

if nargin < 7
    npnt = 50;
end

%% parameters
etamax = pi;
etamin = -pi;
wmax = pi;
wmin = -pi;

deta = (etamax -etamin) /npnt;
dw = (wmax -wmin) /npnt;

[i, j] = meshgrid(1:npnt+1, 1:npnt+1);
eta = etamin +(i -1) *deta;
w = wmin +(j -1) *dw;

ce = cos(eta);
se = sin(eta);
cw = cos(w);
sw = sin(w);

for i=1:nsupertoroids
    cure = epsilon(i, :);
    cura = a(i, :);
    curr = r(i, :);
    
    if iscell(R)
        curxc = xc{i, 1};
        curR = R{i, 1};
    else
        curxc = xc;
        curR = R;
    end
    
    calculate_plot_single_superquadric(ax, cure, cura, curr, curxc, curR,...
                                       ce, se, cw, sw, varargin{:} )
end

function [] = calculate_plot_single_superquadric(ax, e, a, r,...
                                            xc, R, ce, se, cw, sw, varargin)
a(4) = r /sqrt(a(1)^2 +a(2)^2);



x = a(1) .*(a(4) +sign(ce) .*abs(ce).^e(1) )...
         .*sign(cw) .*abs(cw).^e(1);
y = a(2) .*(a(4) +sign(ce) .*abs(ce).^e(1) )...
         .*sign(sw) .*abs(sw).^e(2);
z = a(3) .*sign(se) .*abs(se).^e(1);

[n, m] = size(x);

% rotate
q = [x(:), y(:), z(:) ].';
q = R *q;

% translate origin
q = bsxfun(@plus, q, xc);

%% plot
x = q(1, :);
y = q(2, :);
z = q(3, :);

x = reshape(x, m, n);
y = reshape(y, m, n);
z = reshape(z, m, n);

surf(ax, x, y, z, varargin{:} );
