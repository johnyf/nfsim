function [] = auto_k_call(src, varargin)
    %% get data
    S = guidata(src);
    h = S.panels.h_auto_k;
    
    %% main
    if (get(h, 'Value') == get(h, 'Max') )
        k_mode = 'auto';
        disp('Simulation will run with k automatically calculated.')
    elseif (get(h, 'Value') == get(h, 'Min') )
        k_mode = 'manual';
        disp(['Simulation will run with k selected ',...
              'using Control Panel slider.' ])
    end
    
    %% data out
    S.known_world.k_mode = k_mode;
    update_guidata(S)
end