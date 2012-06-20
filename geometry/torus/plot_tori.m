function [q, X, Y, Z] = plot_tori(ax, tori, npnt, varargin)
% Note: returns the last torus X, Y, Z matrices (if only one, then its
% matrices).
%
% See also PLOT_TORUS.

nellipsoids = size(tori, 1);

held = takehold(ax, 'local');
for i=1:nellipsoids
    torus = tori(i, 1);
    
    qc = torus.qc;
    r = torus.r;
    R = torus.R;
    rot = torus.rot;
    [q, X, Y, Z] = plot_torus(ax, qc, r, R, rot, npnt, varargin{:} );
end
restorehold(ax, held)

if nargout == 0
    clear('q')
end
