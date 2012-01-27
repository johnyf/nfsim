function [] = plot_spheres(ax, qc, r, varargin)
nspheres = size(qc, 2);
for i=1:nspheres
    curqc = qc(:, i);
    curr = r(1, i);
    
    plot_sphere(ax, curqc, curr, varargin{:} )
end
