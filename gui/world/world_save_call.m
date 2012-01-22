function [] = world_save_call(scr, eventdata)
    S = guidata(scr);

    default_filename = 'nfsim_world_1';
    fields = {'world', 'known_world'};
    vars = prepare_scenario_save(fields, S);
    uisave('vars', default_filename);
end