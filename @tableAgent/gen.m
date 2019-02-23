% OBJECTIVE: Calculate #####
function obj = gen(obj,idstr,FNHANDLE_TEMP_,fname,varargin)
% obj = fn(obj,idstr)
%
%% INPUT
% obj = 
% idstr = command or expression of gen
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
    if nargin>=3
        ISFUN = isa(FNHANDLE_TEMP_,'function_handle');
    end
    
    if nargin==4 && ISFUN
        idstr = strrep(idstr,fname,'FNHANDLE_TEMP_');
    elseif nargin>=3 && isstruct(FNHANDLE_TEMP_);
        para = FNHANDLE_TEMP_;
    elseif nargin==2
    else
        error('somthing is wrong for inputs');
    end
    
    
    % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
    [obj,idstrfull] = strgenTransit(obj, idstr);
    

%     eval(idstrfull);
otherwise
    error('the data type of idstr in wrong');
end
% idstr;

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


%% Part 5, Appendix

function [obj,idstrfull] = strgenTransit(obj, idstr)
    % for example 'cola >3&colb >4' to 'T.cola > 3 & T.colb > 4'
    varsname =  string(obj.table.Properties.VariableNames)';
    [~, orderstr] = sort(strlength(varsname),'descend');
    varsname = varsname(orderstr);
    Tname = obj.tablename;
    % split str =
    idstr = strsplit(idstr,'=');
    idstrleft = strtrim(idstr(1));
    idstrright = idstr(2);

    % left side of =
    cmdstrleft = "obj.table." + idstrleft;

    % dealwith operators
    idstrright = strrepbatch_operator(idstrright);
    
    % right side of =
    varsnameinT = "obj.table."+ varsname + "(obj.rowselected)";
    yxcols = cellstr([varsnameinT, varsname+" "]);
    idstrright = strrepbatch(idstrright, yxcols);
    cmdstrright = makeitchar(idstrright);
    resright = eval(cmdstrright);
    
    % case for generate new col
    nT = height(obj.table);
    nrowselect = height(obj.table(obj.rowselected,1));
    if ~ismember(idstrleft,varsname)
            idstrleft = makeitchar(idstrleft);
            obj.table.(idstrleft) = ...
                missingData(resright,nT,1);
    end
    
    
    % case for repmat of 1 element 
    if numel(resright) == 1
        resright = repmat(resright,nrowselect,1);
        
        
        idstrleft = makeitchar(idstrleft);
        % case for datatype transformation of whole col
        if nrowselect == nT
            obj.table.(idstrleft) = resright;
        else
            obj.table.(idstrleft)(obj.rowselected) = resright;
        end
        
    % case for repmat of nT elements
    else
        idstrleft = makeitchar(idstrleft);
        obj.table.(idstrleft)(obj.rowselected) = resright;
        
    end
    
    
%     
%     
%     switch class(resright)
%          case {'string'}
%             if numel(resright) == 1
%                 resright = repmat(resright,nrowselect,1);
%                 % case for generate new col
%                 if ~ismember(idstrleft,varsname)
%                     idstrleft = makeitchar(idstrleft);
%                     obj.table.(idstrleft) =  repmat(string(missing),nT,1);
%                 end
%                 idstrleft = makeitchar(idstrleft);
%                 if nrowselect == nT
%                     obj.table.(idstrleft) = resright;
%                 else
%                     obj.table.(idstrleft)(obj.rowselected) = resright;
%                 end
%             else
%                 idstrleft = makeitchar(idstrleft);
%                 obj.table.(idstrleft)(obj.rowselected) = resright;
%  
%             end
%         case {'double'}
%             if numel(resright) == 1
%                 resright = repmat(resright,nrowselect,1);
%                 % case for generate new col of NaN
%                 if ~ismember(idstrleft,varsname)
%                     idstrleft = makeitchar(idstrleft);
%                     obj.table.(idstrleft) = NaN(nT,1);
%                 end
%                 idstrleft = makeitchar(idstrleft);
%                 if nrowselect == nT % case datatype transfer
%                     obj.table.(idstrleft) = resright;
%                 else
%                     obj.table.(idstrleft)(obj.rowselected) = resright;
%                 end
%             else
%                 idstrleft = makeitchar(idstrleft);
%                 if nrowselect == nT 
%                     obj.table.(idstrleft) = resright;
%                 else
%                     obj.table.(idstrleft)(obj.rowselected) = resright;
%                 end
%             end
%             
%         otherwise
%             warning('FIXME: only double and string are supported!\n No grandtee for other data type!!\n');
%             if numel(resright) == 1
%                 resright = repmat(resright,nrowselect,1);
%                 % case for generate new col of NaN
%                 if ~ismember(idstrleft,varsname)
%                     idstrleft = makeitchar(idstrleft);
%                     obj.table.(idstrleft) = NaN(nT,1);
%                 end
%                 idstrleft = makeitchar(idstrleft);
%                 if nrowselect == nT % case datatype transfer
%                     obj.table.(idstrleft) = resright;
%                 else
%                     obj.table.(idstrleft)(obj.rowselected) = resright;
%                 end
%             else
%                 idstrleft = makeitchar(idstrleft);
%                 if nrowselect == nT 
%                     obj.table.(idstrleft) = resright;
%                 else
%                     obj.table.(idstrleft)(obj.rowselected) = resright;
%                 end
%             end
%     end

    idstrfull = char(cmdstrleft + "(obj.rowselected)" + " = " + cmdstrright +";");
end

end

