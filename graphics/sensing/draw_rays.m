% File:      draw_rays.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   draw sensing rays at endpoints of sensed obstacle boundary
%            segment
% Copyright: Ioannis Filippidis, 2010-

function [] = draw_rays(varargin)

% [] = draw_rays(xb, agent)
% [] = draw_rays(ax, xb, agent)

if (nargin < 2) || (3 < nargin)
    error('This function takes 2 or 3 arguments.')
end

xb = varargin{nargin -1};
agent = varargin{nargin};

if nargin == 3
    ax = varargin{1};
else
    ax = gca;
end

% vectors from xcur to endpoints
ray1(:,1) = xb(:,1) - agent.xcur;
ray2(:,1) = xb(:,end) - agent.xcur;

% corresponding rays' directions
ray1 = ray1 ./ norm(ray1,2);
ray2 = ray2 ./ norm(ray2,2);

% draw corresponding rays
plot(ax, [agent.xcur(1,1), agent.Rs * ray1(1,1) + agent.xcur(1,1)], [agent.xcur(2,1), agent.Rs * ray1(2,1) + agent.xcur(2,1)], 'Color', 'r')
plot(ax, [agent.xcur(1,1), agent.Rs * ray2(1,1) + agent.xcur(1,1)], [agent.xcur(2,1), agent.Rs * ray2(2,1) + agent.xcur(2,1)], 'Color', 'r')
