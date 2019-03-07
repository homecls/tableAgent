function colsoldnewCellstr = strCommaSemicolon2cellstr(cololdnew)
% 'col1,col2;cola,colb' to cellstr;
% author: linrnewen@gmail.com
% 2019-3-2 22:02:57

dclass = class(cololdnew);
switch dclass
    case 'char'
        if contains(cololdnew,",")
            colsoldnewCellstr = strCommaSemicolonSplit(cololdnew);
        else
            colsoldnewCellstr = cololdnew;
            warning('the char "%s" columnname-input should be with ",;"', cololdnew);
        end
    case 'string'
        colsoldnewCellstr = cellstr(cololdnew);
        
    case 'cell'
        if iscellstr(cololdnew)
            colsoldnewCellstr = cololdnew;
        else
             error('the cell input should be cellstr ');
        end
        
    otherwise
        error('the datatype should be char with ",;" , cellstr, string array ')
end
end

function strnew = strCommaSemicolonSplit(cololdnew)
cololdnew = makeitstring(cololdnew);

str = strsplit(cololdnew,";");
str = str(:);
strnew = cellstr(strsplitCell(str,","));


end