% OBJECTIVE: Calculate #####
function obj = genbygroup(obj,cmdstr,FNHANDLE_TEMP_,fname,varargin)
% obj = fn(obj,cmdstr)
%
%% INPUT
% obj = 
% cmdstr = command or expression of gen
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
% FIXME: Use splitapply for speeding up
% 
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/21


%% Part 1, Data
% 
% eval(strcat(fnname,'=log;'));
% eval(strcat(fname,'=@fn;'));
% fname = eval('@fn');

switch class(cmdstr)
case {'string','char'}
    % for example 'cola>3&colb>4' to 'T.cola > 3 & T.colb > 4'
    [obj,cmdstrfull] = strgenTransit(obj, cmdstr);
    if nargin>=3
      ISFUN = isa(FNHANDLE_TEMP_,'function_handle');  
    end
    
    if nargin==4 && ISFUN
        cmdstrfull = strrep(cmdstrfull,fname,'FNHANDLE_TEMP_');
    elseif nargin>=3 && isstruct(FNHANDLE_TEMP_);
        para = FNHANDLE_TEMP_;  
    elseif nargin==2
    else
        error('somthing is wrong for inputs');
    end

%% execute the command to generate new col or update exsitting col
%     eval(cmdstrfull);


otherwise
    error('the data type of cmdstr in wrong');
end
% cmdstr;

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


%% Part 5, Appendix

function [obj,cmdstrfull] = strgenTransit(obj, cmdstr)
    % get rows selected for all groups
    vG = obj.groupvar;
    T = obj.table;
    [T,idx] = sortrows(T,vG);
    obj.table = T;
    obj.rowselected = makeitIndexTF(T,obj.rowselected);
    obj.rowselected = obj.rowselected(idx);
    GT = T(:,vG);
    
    [GNo,TID]= findgroups(GT);
    nG = max(GNo);

    rowGroup = cell(nG,1);
    nrowGroup = NaN(nG,1);
    
    rowselected = obj.rowselected;
    for iG = 1:nG
        rowGroup{iG} = (GNo==iG & makeitIndexTF(T,rowselected)); % row selected in each group
        nrowGroup(iG) = sum(rowGroup{iG});
    end
    % obj.groupvar = vGcellstr;
    % obj.groupno = GNo;
    % obj.groupid = TID;
    % obj.ISGROUPED = true;


    % for example 'cola >3&colb >4' to 'T.cola > 3 & T.colb > 4'
    varsname =  string(obj.table.Properties.VariableNames)';
    [~, orderstr] = sort(strlength(varsname),'descend');
    varsname = varsname(orderstr);
    % Tname = obj.tablename;

    % split str =
    cmdstr = strsplit(cmdstr,'=');
    cmdstrleft0 = strtrim(cmdstr(1));
    % case for generate new col
    if ~ismember(cmdstrleft0,varsname)
        strcmdnewvar = strcat('obj.table.',cmdstrleft0,' = NaN(height(T),1);');
        eval(strcmdnewvar{1}) ;
    end
    cmdstrright = cmdstr(2);

    % left side of =
    cmdstrleft = "obj.table." + cmdstrleft0 + "(rowGroup{iG})";

    % dealwith operators
    cmdstrright = strrepbatch_operator(cmdstrright);
    
    % right side of =
    varsnameinT = "obj.table."+ varsname + "(rowGroup{iG})";
    yxcols = cellstr([varsnameinT, varsname+" "]);
    cmdstrright = strrepbatch(cmdstrright, yxcols);

    % combine left side and right side
    cmdstrfull = char(cmdstrleft + " = " + cmdstrright +";");

    
    % case for generate new col
    iG = 1; 
    resrightG1 = eval(makeitchar(cmdstrright));
    nT = height(obj.table);
    cmdstrleft0char = makeitchar(cmdstrleft0);
    if ~ismember(cmdstrleft0,varsname)
            obj.table.(cmdstrleft0char) = ...
                missingData(resrightG1,nT,1);
    else
        classexist = class(obj.table.(cmdstrleft0char));
        classgen = class(resrightG1);
        % res of gen and existing col has the diff datatype
        % the old data of col will be replaced by missingdata
        if  ~strcmp(classexist,classgen)
            warning('data type of col %s has been changed from %s to %s!!\n'...
                ,cmdstrleft0char,classexist,classgen);
            cmdstrleft0 = makeitchar(cmdstrleft0);
            obj.table.(cmdstrleft0) = ...
                missingData(resrightG1,nT,1);
        % res of gen and existing col has the same datatype
        else
            
        end
    end
    
    % case for generate replace all
    if sum(nrowGroup) == nT
        cmdstrleft0 = makeitchar(cmdstrleft0);
        obj.table.(cmdstrleft0) = ...
                missingData(resrightG1,nT,1);
    else
        
    end
    
    
    % execute the gen for each group
    for iG = 1:nG
        eval(cmdstrfull);
    end
    
    
    
end

end

