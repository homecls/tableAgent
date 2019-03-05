function var = makeitstring(var)
% var = makeitcellstr(var)
switch lower(class(var))
    case {'string'}
        % donothing
    case {'char'}
        var = string(var);
    case {'cell'}
        if iscellnum(var)
            var = string(var);
        elseif iscellstr(var)
            var = string(var);
        else
            error('input should be string or char array, cellnum,cellstr')
        end
    otherwise
        error('input should be string or char array, cellnum,cellstr')
end
end