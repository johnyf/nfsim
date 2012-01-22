function [exists] = world_exists(world, varargin)
    if nargin == 2
        output = varargin{1};
    else
        output = 1;
    end

    %% nothing defined?
    exists = ~isempty(world);
    if ~exists && (output ~= 0)
        disp('No part of world defined.')
        disp('   Go to menu: World-> Space Dimension, Boundary')
        return
    end

    % continuing means world is not an empty structure
    % space dimension and boundary are both required, obstacles not
    % both space dimension and boundary existence are checked to
    % provide diagnostics and guide the user.

    %% space dimension correctly defined?
    space_dimension_exist = isfield(world, 'ndim');
    if ~space_dimension_exist
        if output ~= 0
            disp('Space dimension not defined.')
        end
    elseif (world.ndim < 2) || (3 < world.ndim)
        if output ~= 0
            disp( ['Space dimension: ' num2str(world.ndim)...
                ' is out of limits {2,3}.'] )
        end
        space_dimension_exist = 0;
    end

    if ~space_dimension_exist && (output ~= 0)
        disp('   Go to menu: World-> Space Dimension')
    end

    %% boundary defined?
    boundary_exist = isfield(world, 'r0');
    if ~boundary_exist
        if output ~= 0
            disp('World boundary not defined.')
        end
    elseif world.r0 <= 0
        if output ~= 0
            disp( ['World boundary radius: ' num2str(world.r0)...
                ' is nonpositive.'] )
        end
        boundary_exist = 0;
    end

    if ~boundary_exist && (output ~= 0)
        disp('   Go to menu: World-> Boundary')
    end

    %% obstacles defined? (just check, obstacles are not mandatory)
    obstacles_exist = isfield(world, 'obstacles');
    if ~obstacles_exist && (output ~= 0)
        disp('No obstacles defined. Optionally')
        disp('   go to menu: World-> Place Obstacle')
    end

    exists = space_dimension_exist;% && boundary_exist;
end