function [] = nav_select_nf_call(src, eventdata)
%% data in
S = guidata(src);
selected_field = S.selected_field;

%% init
h_dlg = dialog(...
    'units'     , 'pixels',...
    'position'  , [300 300 600 200],...
    'menubar'   , 'none',...
    'name'      , 'Select Navigation Function/Potential Field',...
    'numbertitle','off',...
    'resize'    , 'off');

h_ok = uicontrol(...
    'Parent'    , h_dlg,...
    'units'     , 'normalized',...
    'position'  , [0.4, 0.1, 0.2, 0.2],...
    'string'    , 'OK',...
    'callback'  , @ok_call);

field_choices = {...
'None',...
'Khatib (FIRAS)',...
'KRNF: Koditschek-Rimon for Sphere World',...
'KRNF: Koditschek-Rimon for General Worlds (toroidal, splines)',...
'Polynomial (Lionis-Papageorgiou-Kyriakopoulos)'};

choices = {'none', 'khatib', 'krnfs', 'krnf', 'polynomial'};

pp = uicontrol(...
    'style'     , 'pop',...
    'units'     , 'normalized',...
    'position'  , [0.2, 0.7, 0.6, 0.2],...
    'string'    , field_choices);

val = find(strcmp(selected_field, choices) == 1); % previous

set(pp, 'value', val);
set(pp, 'callback', {@pp_call, pp} );

%% callbacks
    function [] = pp_call(varargin)
        % Callback for the popup.
        pp = varargin{3};  % Get the structure.
        P = get(pp, {'string', 'val'});  % Get the user's choice.
        %set(S.ed, 'string', P{1}{P{2}});  % Assign the user's choice to the edit.

        selection = P{1}{P{2}};

        switch selection
            case 'None'
                selected_field = 'none';
            case 'Khatib (FIRAS)'
                selected_field = 'khatib';
            case 'KRNF: Koditschek-Rimon for Sphere World'
                selected_field = 'krnfs';
            case 'KRNF: Koditschek-Rimon for General Worlds (toroidal, splines)'
                selected_field = 'krnf';
            case 'Polynomial (Lionis-Papageorgiou-Kyriakopoulos)'
                selected_field = 'polynomial';
            otherwise
                error('Selected field unknown.')
        end
    end

    function [] = ok_call(src, eventdata)
        % data out
        S.selected_field = selected_field;
        update_guidata(S)

        % consider Apply, Cancel buttons

        check_navigate_ability(S);
        closereq;
    end
end
