function [planes] = create_rectangle(x, Lx, Ly, pred)
xp = [0, 0; 0, 0; Lx, Ly; Lx, Ly].';
xp = bsxfun(@plus, xp, x);

n = [0, 1; 1, 0; -1, 0; 0, -1].';

domain = {[-Lx, 0], [0, Ly], [0, Ly], [-Lx, 0] };

planes = create_halfspaces(xp, n, domain, pred);
