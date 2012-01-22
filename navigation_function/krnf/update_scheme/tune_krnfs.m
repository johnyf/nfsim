function [known] = tune_krnfs(q, qd, qc, r, id, newid, k_mode, known)
% File:      tune_krnfs.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.11.12 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   Koditschek-Rimon tuning in sphere world
% Copyright: Ioannis Filippidis, 2010-

if strcmp(k_mode, 'auto')
    %% MIN 1 obstacle known
    N = size(id, 2);
    Nnew = size(newid, 2);
    Nold = N -Nnew;

    oldid = id(1, 1:Nold);

    % disp( ['id = ' num2str(id) ] )
    % disp( ['already known id = ' num2str(oldid) ] )
    % disp( ['discovered id = ' num2str(newid) ] )

    % each new obstacle is considered in turn
    for i=1:Nnew
        nextnew = newid(1, 1);

        qcold = qc(:, 1:Nold);
        rold = r(1, 1:Nold);

        newqc = qc(:, id == nextnew);
        newr = r(1, id == nextnew);

        [known] = add_obstacle(newqc, newr, qcold, rold, q, qd, known);

        % one more has been considered
        Nold = Nold +1;
        oldid = id(1, 1:Nold);

        % remove it from new
        newid = newid(1, 2:end);
    end
end

known.newid = [];
