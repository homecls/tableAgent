% OBJECTIVE: Calculate #####
function obj = gen(obj,idstr,FNHANDLE_TEMP_,fname)
% obj = fn(obj,idstr)
%
%% INPUT
% obj = 
% idstr = 
% TODO: DO NOT USE `FNHANDLE_TEMP_` AS COLNAME IN TABLE
%% OUTPUT
% obj = 
%
%% REQUIRMENT
% 
% 
%% EXMAPLE
% example 1:
% Tagent.row('grade==67|grade<38').gen('grade = grade+1').gen('G = grade*2')...
%     .row('grade<=99').gen('G = log(grade)*10')...
%     .row([1,3]).gen('G=3')...
%     .row().gen('G=pi');
% 
% example2:
% fnew = @(x)(x+3);
% Tagent.row().gen('G=fnew(pi)',fnew,'fnew');
% 
%% SEE ALSO
%
% 
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/21


%% Part 1, Data
% 
% eval(strcat(fnname,'=log;'));
% eval(strcat(fname,'=@fn;'));
% fname = eval('@fn');



switch class(idstr)
case {'string','char'}
    % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
    idstrfull = strgenTransit(obj, idstr);
    if nargin == 4
        idstrfull = strrep(idstrfull,fname,'FNHANDLE_TEMP_');
    end
    eval(idstrfull);
case {'double'}
    error('data type of arg is wrong')
case {'logical'}
    error('data type of arg is wrong')
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

