function [agent, world, known_world, sensed_world] =...
    navigate(agent, world, known_world, nfgui, type, usegraphics)
% File:      navigate.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.05.02 - 
% Language:  MATLAB R2010b
% Purpose:   navigation main loop
% Copyright: Ioannis Filippidis, 2010-

% usegraphics = 'on' for graphics output

% structure fields needed
%   agent.x
%   agent.xcur
%   agent.sensing
%   agent.Rs
%
%   known_world.id
%   known_world.newid

% dependencies
%   sensing_setS (only when agent.sensing = 1)
%   world_update (only when agent.sensing = 1)
%
%   update_graphics (only when graphics = 'on')
%
%   analytic_gradient
%   normvec
%
%   reached_goal

max_step = 0.01 *agent.Rs;
stop_criteria.convergence_error = max_step;

maxsteps = 1e6;
sensed_world = [];
graphics_update_period = 100;
n = graphics_update_period;

for i=1:maxsteps
    % save current position in path history
    agent.x = [agent.x, agent.xcur];
    
    %% sensing
    if agent.sensing == 1
        sensed_world = sensing_setS(agent, world);
        known_world = world_update(known_world, sensed_world);
        
        %disp( ['ID = ' num2str(known_world.id) ] )
        if ~isempty(known_world.newid)
            disp( ['New ID = ' num2str(known_world.newid) ] )
        end
    end

    %% graphics update
    if (n == graphics_update_period) && strcmp(usegraphics, 'on')
        n = 1;
        if update_graphics(world, known_world, agent, nfgui, type)
            return;
        end
    else
        n = n +1;
    end

    %% tune
    % memo: add capability to use auto_k method for known worlds
    %   via a single initial update, which would add all the obstacles.
    %   Programmatically this could be easily done by setting the sensing
    %   radius equal to twice the world radius. But this is not correct in
    %   principle.
    qcur = agent.xcur;
    qd = agent.xd;

    % get sphere world info (replace by data structure interface for this
    % special case for which no diffeomorphism is needed)
    [qc, r] = convex2sphere_world(world, known_world);

    id = known_world.id;
    newid = known_world.newid;
    k_mode = known_world.k_mode;
    
    known_world = tune_krnfs(qcur, qd, qc, r, id, newid, k_mode, known_world);
    %known_world = iterate_motion_planner(type, );
    
    %% gradient (velocity)
    [qc, r] = convex2sphere_world(world, known_world); % obstacles added
    r0 = -r(r < 0);
    if isempty(r0)
        r0 = -1;
    end
    qc = qc(:, r > 0);
    r = r(r > 0);
    k = known_world.k;
    
    grad = analytic_grad(type, qcur, qd, qc, r0, r, k);

    %% new position = integrate velocity
    normgrad = normvec(grad);
    step = min([max_step, norm(grad,2) ] );
    agent.xcur = agent.xcur -normgrad .*step;

    %% stop iterating
    if reached_goal(agent, stop_criteria), break; end
end

% save (last) current position in path history
agent.x = [agent.x, agent.xcur];

% alternative gradient function choices
%   [grad_nf] = num_grad_phi(agent, world, known_world, 'nf_polynomial');
%   [grad_nf, known_world] = polynomial_rimon(agent, world, known_world);
