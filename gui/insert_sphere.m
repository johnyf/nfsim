function [ch, xc, r] = insert_sphere(ndim, rad, cntr, ltp, trnsp, h_button)

if ndim == 2
    [ch, xc, r] = draw_circle(rad, cntr, ltp, trnsp, h_button);
end

if ndim == 3
    xc = cntr;
    
    if isempty(xc)
        disp('Give sphere center')
        xc = input_matrix( [3, 1] );
    end
    
    if isempty(xc)
        ch = [];
        xc = [];
        r = [];
        return;
    end
    
    r = input('Give sphere radius');
    
    ax = gca;
    ch = plotSphere(ax, xc, r, 'Color', 'b', 'Opacity', 0);
end
