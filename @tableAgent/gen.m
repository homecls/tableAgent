% OBJECTIVE: Calculate #####
function obj = gen(obj,idstr,FNHANDLE_TEMP_,fname,varargin)
% obj = fn(obj,idstr)
%
%% INPUT
% obj = 
% idstr = 
% TODO: DO NOT USE `FNHANDLE_TEMP_` AS COLNAME IN TABLE
% F
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
% example 3:
% para.x = [1,1]';
% para.y = [10,10]';
% Tagent.row([1,2]).gen('Gx=grade + para.x - para.y',para);
% disp(Tagent.table)
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
    ISFUN = isa(FNHANDLE_TEMP_,'function_handle');
    if nargin==4 && ISFUN
        idstrfull = strrep(idstrfull,fname,'FNHANDLE_TEMP_');
    elseif nargin>=3 && isstruct(FNHANDLE_TEMP_);
        para = FNHANDLE_TEMP_;   
    else
        error('somthing is wrong for inputs');
    end
    switch nargin
    case {1,2}
    case {4}
        
    otherwise

        
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

