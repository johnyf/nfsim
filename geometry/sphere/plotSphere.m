function [ch] = plotSphere(ax, xc, r, varargin)
% plots a 2-sphere

% unit sphere
np = 15;
[x,y,z] = sphere(np);

x = r .*x +xc(1,1);
y = r .*y +xc(2,1);
z = r .*z +xc(3,1);

held = takehold(ax, 'local');

n = size(varargin, 2);
if n == 0
        opacity = 1;
else
    
    if isodd(n)
        error('Property - Value pairs')
    end

    for i=1:2:n
        property = varargin{i};

        if ~ischar(property)
            error('not property')
        end

        if strcmp(property, 'Color')
            col = varargin{i+1};
        end

        if strcmp(property, 'Opacity')
            opacity = varargin{i+1};
        end
    end
end

if opacity == 1
    ch = surf(ax, x,y,z);
end

if opacity == 0
%     ch = mesh(ax, x,y,z);
%     set(ch, 'FaceColor', 'none');
%     set(ch, 'EdgeColor', col);

    for i=1:np
        plot3(ax, x(:,i), y(:,i), z(:, i), 'Color', col, 'HandleVisibility','off');
    end
    
    for i=1:np
        plot3(ax, x(i,:), y(i,:), z(i, :), 'Color', col, 'HandleVisibility','off');
    end
end

if (0 < opacity) && (opacity < 1)
    ch = surf(ax, x,y,z,'FaceAlpha', 'flat',...
                        'AlphaDataMapping', 'scaled',...
                        'AlphaData', opacity *ones(np),...
                        'FaceColor', col,...
                        'EdgeColor', col);
end

restorehold(ax, held)
