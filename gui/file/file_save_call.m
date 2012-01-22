function [] = file_save_call(scr, eventdata)
    %% get data
    S = guidata(scr);
    
    %% main
    default_filename = 'nfsim_scenario_1';
    fields = {'world', 'known_world', 'agent', 'selected_field'};
    vars = prepare_scenario_save(fields, S);
    uisave('vars', default_filename);
end
