function [S] = init_application_data(S)
    S.world.ndim = 2;
    S.world.obstacles = {};

    S.known_world = init_known_world(0, 0);
    S.agent = [];
    S.sensed_world = [];
    S.selected_field = 'none';
    S.stop_circle_draw = 1;
    S.field_resolution = 50;

    update_guidata(S)

    check_navigate_ability(S);
end