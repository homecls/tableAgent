function rowdoble = rowstr2rowdouble(obj, idstr)
% for example 'cola >3&colb >4' to 'T.cola > 3 & T.colb > 4'

switch class(idstr)
    case {'string','char'}
        % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
        rowdoble = strrow2strtablerow(obj, idstr);
    case {'double'}
        rowdoble = idstr;
    case {'logical'}
        rowdoble = idstr;
    otherwise
        error('the data type of idstr in wrong');
end

% infunction function
    function rowdoble =strrow2strtablerow(obj, idstr)
        varsname =  string(obj.table.Properties.VariableNames)';
        [~, orderstr] = sort(strlength(varsname),'descend');
        varsname = varsname(orderstr);
        varsnameinT = "obj.table."+ varsname;
        idstr = strrepbatch_operator(idstr);
        yx = cellstr([varsnameinT, varsname+" "]);
        idstrfull = strrepbatch(idstr, yx);
        idstrfull = strcat(idstrfull,';');
        rowdoble = eval(idstrfull);
    end
end