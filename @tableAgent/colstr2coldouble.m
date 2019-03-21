function [coldouble, colcellstr]= colstr2coldouble(obj, strcol, rowno)
% case 1, T.col('Var.?$').keepcol
% case 2, T.col('Var1,Var2').keepcol
% case 3, T.col(["cola", "colb"]).keepcol
% case 4, T.col({'Var1','Var2' }).keepcol
% case 5, T.col([1,2,3]).keepcol
% case 6, T.col(:).keepcol
% 
% arg3: rowno = find colvariable in rowno-th row
% TODO: find coldouble at row i;

if isempty(strcol)
   error('col syntax are not supported, for example end'); 
end

    if isa(obj, 'tableAgent')
       varnames = obj.table.Properties.VariableNames; 
    else
       varnames = obj.Properties.VariableNames;
    end
    
    
    opt = class(strcol);
    switch opt
    case 'char'
        % case 1, T.col('Var.?$').keepcol
        % case 1, T.col('Var1,Var2').keepcol
        strcolString = string(strcol);
        if contains(strcolString,[".*",".+",".?","^","$"])
            varnamesString = string(varnames);
            tfsRaw = regexpcell(varnamesString,strcol);
            % tfs = logical(makeitdouble(tfsRaw));
            colcellstr = varnames(tfsRaw);
            coldouble = find(tfsRaw);
            
        elseif contains(strcolString,[":"])
            
            % case col(:)  col('col1:col2') T(1:2,'Age:10')
            % col(1:end) are not supported
            if strcmp(":",strcolString)
               coldouble = 1:obj.width;
%             elseif endsWith(strcolString,":end")
%                 error("col index can not inculdes 'end' ")
            else % case '1:end' 1:3 or col1:col2
                strcolsplited = strsplit(strcolString,":");
                nameMap = getColnameColdouble(obj.table);
                colLeft = nameMap.No(cellstr(strtrim(strcolsplited(:,1))));
                colRight = nameMap.No(cellstr(strtrim(strcolsplited(:,2))));
                coldouble = colLeft:colRight;
            end
        else
            colcellstr = strtrim(strsplit(strcol, ','));
            [~,coldouble] = ismember(colcellstr,varnames);
        end
        
        if isnumeric(coldouble) && any(coldouble==0)
            warning('cols "%s" are not found!',strjoin(colcellstr(coldouble==0),'; '));
        end
        return
    case 'string'
        if contains(strcol,",")
            strcol = makeitchar(strcol);
            [coldouble, colcellstr]= colstr2coldouble(obj, strcol);
            return;
        end
        colcellstr = strtrim(cellstr(strcol));
        [~,coldouble] = ismember(colcellstr,varnames);
        if any(coldouble==0)
            error('cols "%s" are not found!',strjoin(colcellstr(coldouble==0),'; '));
        end
        return

    case 'cell'
        if iscellstr(strcol)
            [~,coldouble] = ismember(strcol,varnames);
            colcellstr = strcol;
        else
            error('arg of strcol should be cellstr, if its a cell')
            error('col name:%s you type in are not match in tableAgent.',...
            strcol{coldouble==0});
        end
        if any(coldouble==0)
            error('cols "%s" are not found!',strjoin(colcellstr(coldouble==0),'; '));
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