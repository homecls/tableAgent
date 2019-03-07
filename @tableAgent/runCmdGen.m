% OBJECTIVE: Calculate #####
function [obj,cmdstrFull] = runCmdGen(obj,cmdstr)
% [obj,cmdstrFull] = fn(obj,cmdstrRaw)
%
%% INPUT
% obj = 
% cmdstrRaw = 
%% OUTPUT
% [obj,cmdstrFull] = 
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
%% VERSION: v1.0 2019/03/05

    % for example 'cola >3&colb >4' to ' T.cola > 3 & T.colb > 4 '

    % get variableNames of obj.table
    varsname =  string(obj.table.Properties.VariableNames)';
    [~, orderstr] = sort(strlength(varsname),'descend');
    varsname = varsname(orderstr);
    % Tname = obj.tablename;

    % split str =
    cmdstr = strsplit(cmdstr,'=');
    cmdstrleftRaw = makeitchar(strtrim(cmdstr(1)));
    cmdstrright = cmdstr(2);

    % left side of =
    cmdstrleft = "obj.table." + cmdstrleftRaw;

    % dealwith operators
    cmdstrright = strcat({' '},strrepbatch_operator(cmdstrright),{' '});
    
    % right side of =
    varsnameinT = "obj.table."+ varsname + "(obj.rowselected)";
    yxcols = cellstr([varsnameinT, varsname+" "]);
    cmdstrright = strrepbatch(cmdstrright, yxcols);
    cmdstrright = makeitchar(cmdstrright);
    resright = eval(cmdstrright);
    if ischar(resright) 
        resright = makeitcellstr(strtrim(resright));
    end
    
    % case for generate new col
    nT = height(obj.table);
    nrowselect = height(obj.table(obj.rowselected,1));
    if ~ismember(cmdstrleftRaw,cellstr(varsname))
        % missing data generation for new col
        cmdstrleftRaw = makeitchar(cmdstrleftRaw);
        obj.table.(cmdstrleftRaw) = missingData(resright,nT,1); 
    end
    
    
    % case for repmat of 1 element 
    nResRight = numel(resright) ;
    if nResRight== 1
        resright = repmat(resright,nrowselect,1);
        
        
        cmdstrleft = makeitchar(cmdstrleft);
        cmdstrFull = char(cmdstrleft + "(obj.rowselected)" + " = " + cmdstrright +";");
        % case for datatype transformation of whole col
        if nrowselect == nT
            obj.table.(cmdstrleftRaw) = resright; % run the cmd
            return;
        else
            obj.table.(cmdstrleftRaw)(obj.rowselected) = resright; % run the cmd
            return;
        end
        
    % case for repmat of nT elements
    elseif nResRight == nrowselect
        if nrowselect == nT
        cmdstrleft = makeitchar(cmdstrleft);
        obj.table.(cmdstrleftRaw) = resright; % run the cmd
        cmdstrFull = char(cmdstrleft + "" + " = " + cmdstrright +";");
        
        else
        cmdstrleft = makeitchar(cmdstrleft);
        obj.table.(cmdstrleftRaw)(obj.rowselected) = resright; % run the cmd
        cmdstrFull = char(cmdstrleft + "(obj.rowselected)" + " = " + cmdstrright +";");
        end
        return;
    else
        error('the numel of gen should eithor be n Row selected or 1')
    end

end
