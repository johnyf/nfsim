function [new_known_world] = old_world_update(old_known_world, sensed_world)
% File:      old_world_update.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.09.15
% Language:  MATLAB R2010b
% Purpose:   take sensed world & current world knowledge
%               return updated knowledge (used for old sphere world and
%            Bezier world implementation)
% Copyright: Ioannis Filippidis, 2010-

% disp('old_known_world.parts')
% disp(old_known_world.parts)

if isempty(sensed_world)
    new_known_world = old_known_world;
    new_known_world.new_obs = [];
    new_known_world.update = 'unneeded';
    return
end

% first sensing
if isempty(old_known_world.parts)
    %sortrows(sensed_world,1);
    new_known_world = old_known_world;
    new_known_world.parts = sensed_world;
    if ~isempty(sensed_world)
        new_known_world.new_obs = sensed_world(:,1);
    end
    new_known_world.update = 'needed';
    return;
end

already_known_id = old_known_world.parts(:, 1);

if ~isempty(sensed_world)
    new_id = sensed_world(:, 1);
end

% disp('sensed_world')
% disp(sensed_world)

temp_world = [old_known_world.parts;
              sensed_world];
          
% disp('temp_world')
% disp(temp_world)
          
new_parts = [];
while ~isempty(temp_world)
    id_cur = temp_world(1,1);

    k = 0;
    temp = [];
    left1 = [];
    right1 = [];

    %temp_world
    for j=1:size(temp_world,1)
        id_other = temp_world(j,1);
        
        % other concerns different obstacle?
        if (id_cur ~= id_other)
            temp(size(temp, 1) +1, :) = temp_world(j,:);
            continue;
        end
        
        % concerns same obstacle
        t1 = temp_world(j,2);
        t2 = temp_world(j,3);
        inter = temp_world(j,4);

        if (inter == 0)
            k = k + 1;
            left1(1,k) = t1;
            right1(1,k) = t2;
        else
            k = k + 1;
            left1(1,k) = 0;
            right1(1,k) = t2;

            k = k + 1;
            left1(1,k) = t1;
            right1(1,k) = 1;
        end
    end
    temp_world = temp;

    left = [];
    right = [];
    [left, right] = MergeBrackets(left1, right1);

    left = left';
    right = right';

    inter = zeros(size(left,1), 1);

    if (left(1,1) == 0) && (right(end,1) == 1) && (size(left,1) ~= 1)
        n = size(left,1);

        left(1,1) = left(n, 1);
        inter(1,1) = 1;

        left = left(1:(n-1), 1);
        right = right(1:(n-1), 1);
        inter = inter(1:(n-1), 1);
    end

    new_part = [id_cur * ones( size(left,1), 1), left, right, inter];
    %new_known_world
    new_parts = [new_parts; new_part];
end

%% Nothing discovered?
new_known_world = old_known_world; % to transfer any parameters
new_known_world.parts = new_parts;

% disp('new')
% disp(new_known_world.parts)
% 
% disp('previous')
% disp(old_known_world.parts)
if isequal(new_known_world.parts, old_known_world.parts)
    new_known_world.update = 'unneeded';
    new_known_world.new_obs = [];
else
    new_known_world.update = 'needed';
    
    new_known_world.new_obs = [];
    for i=1:size(new_id, 1)
        if ~ismember(new_id(i, 1), already_known_id)
            new_known_world.new_obs = [new_known_world.new_obs, new_id(i, 1)];
        end
    end
end
