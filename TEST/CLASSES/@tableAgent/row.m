% OBJECTIVE: Calculate #####
function [obj, rowselected]= row(obj,idstr)
% obj = fn(obj,idstr)
%
%% INPUT
% obj =
% idstr =
%% OUTPUT
% obj =
%
%% REQUIRMENT
%
%
%% EXMAPLE
%
%
%% SEE ALSO
%
%
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/21


%% Part 1, Data
narginchk(1,2)
if nargin == 1
    obj.rowselected = true(height(obj.table),1);
    rowselected = obj.rowselected;
return;
else
    switch class(idstr)
    case {'string','char'}
        % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
        idstrfull = strrow2strtablerow(obj, idstr);
        try
            obj.rowselected = eval(idstrfull);
        catch
            error('%s\n not find in row()function ',idstrfull);
        end
    case {'double'}
        obj.rowselected = idstr;
    case {'logical'}
        obj.rowselected = idstr;
    otherwise
        error('the data type of idstr in wrong');
    end
    
    rowselected = obj.rowselected;
    
end


% idstr;

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


%% Part 5, Appendix

    function idstrfull = strrow2strtablerow(obj, idstr)
        % for example 'cola >3&colb >4' to 'T.cola > 3 & T.colb > 4'
        varsname =  string(obj.table.Properties.VariableNames)';
        [~, orderstr] = sort(strlength(varsname),'descend');
        varsname = varsname(orderstr);
%         Tname = obj.tablename;
        %     varsnameinT = Tname +"."+ varsname;
        varsnameinT = "obj.table."+ varsname;
        idstr = strrepbatch_operator(idstr);
        yx = cellstr([varsnameinT, varsname+" "]);
        idstrfull = strrepbatch(idstr, yx);
        idstrfull = strcat(idstrfull,';');
    end

end

