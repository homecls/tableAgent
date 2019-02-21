% OBJECTIVE: Calculate #####
function obj = gen(obj,idstr)
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
% idstr = 'gradeTotal = grade*2';
% 
%% SEE ALSO
%
% 
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/21


%% Part 1, Data
switch class(idstr)
case {'string','char'}
    % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
    idstrfull = strgenTransit(obj, idstr);
    eval(idstrfull);
    
%     evalin('caller',strcat('obj.rowselected = ', idstrfull));
%     disp(obj.table);
%     ''
case {'double'}
    ind2sub
case {'logical'}
    
otherwise
    error('the data type of idstr in wrong');
end
% idstr;

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


%% Part 5, Appendix

function idstrfull = strgenTransit(obj, idstr)
    % for example 'cola >3&colb >4' to 'T.cola > 3 & T.colb > 4'
    varsname =  string(obj.tableProperties.VariableNames)';
    [~, orderstr] = sort(strlength(varsname),'descend');
    varsname = varsname(orderstr);
    Tname = obj.tablename;
    % split str =
    idstr = strsplit(idstr,'=');
    idstrleft = strtrim(idstr(1));
    idstrright = idstr(2);

    % left side of =
    idstrleft = "obj.table." + idstrleft;

    % dealwith operators
    idstrright = strrepbatch_operator(idstrright);
    
    % right side of =
    varsnameinT = "obj.table."+ varsname + "(obj.rowselected)";
    yxcols = cellstr([varsnameinT, varsname+" "]);
    idstrright = strrepbatch(idstrright, yxcols);

    idstrfull = char(idstrleft + "(obj.rowselected)" + " = " + idstrright +";");
    
end

end

