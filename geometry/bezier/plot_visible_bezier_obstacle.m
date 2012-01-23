function [] = plot_visible_bezier_obstacle(ax, part_shown)
% [~, index] = ismember(i, id);
% if index ~= 0
%     col = [0.133, 0.5451, 0.133]; % unknown world
%     part_shown = known_world.details{1, index};
% else
%     %continue
%     part_shown = [1, 0, 1, 1];
%     col = [0, 0, 1]; % known world
% end

t1 = part_shown(1, 2);
t2 = part_shown(1, 3);
inter = part_shown(1, 4);

% w/o control points, w/o rays
%bezier_draw(obs.bezier_coef, [], t1, t2, inter, col, []);

% w/o control points, with rays
bezier_draw(ax, obs.bezier_coef, [], t1, t2, inter, col, agent);

% with control points
%bezier_draw(obs.bezier_coef, obs.xcp, t1, t2, inter, col, agent);
