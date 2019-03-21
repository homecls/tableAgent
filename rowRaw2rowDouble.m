% OBJECTIVE: Calculate #####
function [rowsDouble]= rowRaw2rowDouble(T,rowRaw)
% obj = fn(obj,idstr)
%
%% INPUT
% obj =
% rowRaw=
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
    rowsDouble = true(height(T),1);
return;
else
    switch class(rowRaw)
    case {'string','char'}
        % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
        % if :
        if strcmp(":",rowRaw)
           rowsDouble = 1:height(T);
           return;
        else
           idstrfull = strrow2strtablerow(T, rowRaw); 
        end

        try
            rowsDouble = eval(idstrfull);
        catch
            error('%s\n not availiable, in row(.) function!',idstrfull);
        end
    case {'double'}
        rowsDouble = rowRaw;
    case {'logical'}
        rowsDouble = rowRaw;
    otherwise
        error('the data type of rowRawin wrong');
    end
    
   
end

%% Part 5, Appendix



end

function idstrfull = strrow2strtablerow(T, rowRaw)
% for example 'cola >3&colb >4' to 'T.cola > 3 & T.colb > 4'
varsname =  string(T.Properties.VariableNames)';
[~, orderstr] = sort(strlength(varsname),'descend');
varsname = varsname(orderstr);
%         Tname = Tname;
%     varsnameinT = Tname +"."+ varsname;
varsnameinT = "T."+ varsname;
rowRaw= strrepbatch_operator(rowRaw);
yx = cellstr([varsnameinT, varsname+" "]);
idstrfull = strrepbatch(rowRaw, yx);
idstrfull = strcat(idstrfull,';');
end

