function [coldouble, colcellstr]= colstrLabel2coldouble(obj, strcol, rowno)
% case 1, T.col('Var.?$').keepcol
% case 2, T.col('Var1,Var2').keepcol
% case 3, T.col(["cola", "colb"]).keepcol
% case 4, T.col({'Var1','Var2' }).keepcol
% case 5, T.col([1,2,3]).keepcol
% 
% arg3: rowno = find colvariable in rowno-th row
% TODO: find coldouble at row i;


    if isa(obj, 'tableAgent')
       varnames = obj.table.Properties.VariableNames; 
    else
       varnames = obj.Properties.VariableNames;
    end
    labelnames = obj.label;
    
    opt = class(strcol);
    switch opt
    case 'char'
        % case 1, T.col('Var.?$').keepcol
        % case 1, T.col('Var1,Var2').keepcol
        strcolString = string(strcol);
        if contains(strcolString,[".*",".+",".?","^","$"])
            labelnamesString = string(labelnames);
            tfsRaw = regexpcell(labelnamesString,strcol);
%             tfs = logical(makeitdouble(tfsRaw));
            colcellstr = varnames(tfsRaw);
            coldouble = find(tfsRaw);
        else
            labelcellstr = strtrim(strsplit(strcol, ','));
            [~,coldouble] = ismember(labelcellstr,labelnames);
            colcellstr = varnames(coldouble);
            
        end
        return
    case 'string'
        labelcellstr = strtrim(cellstr(strcol));
        [~,coldouble] = ismember(labelcellstr,labelnames);
        colcellstr = varnames(coldouble);
        return

    case 'cell'
        if iscellstr(strcol)
            [~,coldouble] = ismember(strcol,labelnames);
            colcellstr = varnames(coldouble);
        else
            error('arg of strcol should be cellstr, if its a cell')
            error('col name:%s you type in are not match in tableAgent.',...
            strcol{coldouble==0});
        end
        return
        
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
        colcellstr = varnames(coldouble); % FIXME: duplicate code 
    end
    

end