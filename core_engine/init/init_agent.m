function [varargout] = init_agent(varargin)
% [agent] = init_agent() % default agent
% [agent] = init_agent(agent) % reset given agent xcur=x0 and empty x
% [agent] = init_agent(Parameter1, Value1,...) % default agent, given param
% [agent] = init_agent(agent, Parameter1, Value1,...) % change given param
%
% File:      init_agent.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2011b
% Purpose:   initialize structure of agent
% Copyright: Ioannis Filippidis, 2010-

% CAUTION: multiple agents not yet supported, although directly extensible

%% default agent
if nargin == 0
    agent = default_agent;
end

%% reset given agent
if nargin == 1
    agent = varargin{1};
    agent = reset(agent);
end

%% default agent with specific given parameters defined
if (1 < nargin) && iseven(nargin)
    agent = default_agent;
    agent = set_param(agent, varargin{1:end});
end

%% change specific given agent parameters
if (1 < nargin) && isodd(nargin)
    agent = varargin{1};
    agent = set_param(agent, varargin{2:end});
end

varargout = {agent};

function [agent] = default_agent
% configurations
agent.x0 = [0.5, 0.5]'; % initial
agent.xd = [1, 1]'; % goal (final/destination)

agent.xcur = agent.x0; % current
agent.x = []; % path followed

% other characteristics
agent.sensing = 0; % 1=on | 0=off, sensing ability
agent.Rs = 1; % agent's sensing radius (for open sensing set = 2-ball)

function [agent] = reset(agent)
agent.xcur = agent.x0;
agent.x = [];

function [agent] = set_param(varargin)
agent = varargin{1};
properties = varargin(2:2:end);
values = varargin(3:2:end);

% property, value pairs
for i=1:length(properties);
    property = properties{i};
    value = values{i};
    
    agent.(property) = value;
end
