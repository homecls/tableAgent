% OBJECTIVE: Calculate #####
function obj = keepcol(obj,colstr)
% obj = fn(obj,colstr)
%
%% INPUT
% obj = 
% colstr = 
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
%% VERSION: v1.0 2019/02/22


%% Part 1, Data
if nargin==1
    coldouble = obj.colselected;
else
    [coldouble, colcellstr] = colRaw2colDouble(obj, colstr);
%     obj = obj.col(colstr);
%     coldouble = obj.colselected;
end
idcolnotfind = coldouble == 0;
if any(idcolnotfind)
    cprintf('error','some colname are not find\n')
    disp(find(idcolnotfind))
    error('some colname are not find\n')
end
obj.table = obj.table(:,coldouble);
obj.colselected = [];


%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end

