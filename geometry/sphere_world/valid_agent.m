% File:      valid_agent.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2010.12.19 - 
% Language:  MATLAB, program version: 7.11 (2010b)
% Purpose:   check agent validity
% Copyright: Ioannis Filippidis, 2010-

function [] = valid_agent(agent, world, known_world)
%% agent within world, if world is bounded
[qc, r] = convex2sphere_world(world, known_world);
r0 = -r(r < 0);
q0 = qc(r < 0);

qc = qc(r > 0);
r = r(r > 0);

%% configurations to check
if ~isfield(agent, 'x0') || isempty(agent.x0)
    error('Agent x0 not defined.')
end

if ~isfield(agent, 'xd') || isempty(agent.xd)
    error('Agent xd not defined.')
end

if ~isfield(agent, 'xcur') || isempty(agent.xcur)
    error('Agent xcur not defined.')
end

x0 = agent.x0;
xd = agent.xd;
xcur = agent.xcur;

%% not within world?
if ~isempty(r0)
    if ~inopendisk(x0, q0, r0)
        error('Agent initial configuration x0 not within Workspace W.')
    end
    
    if ~inopendisk(xd, q0, r0)
        error('Agent goal configuration xd not within Workspace W.')
    end
    
    if ~inopendisk(xcur, q0, r0)
        error('Agent current configuration xcur not within Workspace W.')
    end
end

%% within obstacle?
for i=1:size(qc, 2)
    q = qc(:, i);
    if inopendisk(x0, q, r)
        error(['Agent initial configuration x0 in obstacle ', num2str(i), '.'] )
    end
    
    if inopendisk(xd, q, r)
        error(['Agent goal configuration xd in obstacle ', num2str(i), '.'] )
    end
    
    if inopendisk(xcur, q, r)
        error(['Agent current configuration xcur in obstacle ', num2str(i), '.'] )
    end
end
