function [exists] = agent_exists(agent, varargin)
    if nargin == 2
        output = varargin{1};
    else
        output = 1;
    end

    exists = ~isempty(agent);
    if ~exists && (output ~= 0)
        disp('Agent not yet defined.')
        disp('   Go to menu: World-> Configure Agents')
    end
end