function [coldouble, colcellstr]= colstr2coldouble(obj, strcol)

    % for example ["cola", "colb"]
    % for example {'cola', 'colb'}
    % for example 'cola, colb' 
    if isa(obj, 'tableAgent')
       varnames = obj.table.Properties.VariableNames; 
    else
        varnames = obj.Properties.VariableNames;
    end
    opt = class(strcol);
    switch opt
    case 'char'
        colcellstr = strtrim(strsplit(strcol, ','));
        [~,coldouble] = ismember(colcellstr,varnames);
        
    case 'string'
        colcellstr = strtrim(cellstr(strcol));
        [~,coldouble] = ismember(colcellstr,varnames);

    case 'cell'
        if iscellstr(strcol)
            [~,coldouble] = ismember(strcol,varnames);
            colcellstr = strcol;
        else
            error('arg of strcol should be cellstr, if its a cell')
        end
        error('col name:%s you type in are not match in tableAgent.',...
            strcol{coldouble==0});
        
    case 'double'
        coldouble = strcol;
        if min(coldouble)<1 || ...
                max(coldouble)>numel(varnames) || ...
                numel(coldouble)>numel(varnames)
            error('col no is out of range')
        else
            
        end
        
    otherwise 
        error('arg of strcol should be cellstr, string array, double, or logical')
    end
    % col name not find
    idmissed = coldouble==0;
    if any(idmissed)
        cprintf('error','col name:%s you type in are not match in tableAgent.\n',...
            colcellstr{coldouble==0});
        return;
    else
        colcellstr = varnames(coldouble);
    end
    

end