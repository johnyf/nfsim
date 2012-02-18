function [] = plot_sphere(ax, qc, r, varargin)
ndim = size(qc, 1);
if ndim == 2
    plot_circle(ax, qc, r, varargin{:} )
elseif ndim == 3
    plotSphere(ax, qc, r, varargin{:} )
else
    error('N-Sphere with N>=3 cannot be plotted.')
end
