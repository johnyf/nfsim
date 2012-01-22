function [exists] = type_exists(selected_field, varargin)
    if nargin == 1
        output = varargin{1};
    else
        output = 1;
    end

    exists = ~isempty(selected_field);

    if exists && strcmp(selected_field, 'none')
        exists = 0;
    end

    if ~exists && (output ~= 0)
        disp('Artificial Potential Field type not selected.')
        disp( ['   Go to menu: '...
            'Navigation-> Select Navigation Function/Potential Field'] )
    end
end