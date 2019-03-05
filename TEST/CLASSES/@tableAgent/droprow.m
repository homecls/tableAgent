% OBJECTIVE: Calculate #####
function obj = droprow(obj,rowstr)
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
    rowdouble = obj.rowselected;
else
    obj = obj.row(rowstr);
    rowdouble = obj.rowselected;
    
end
obj.table(rowdouble,:) = [];
obj.rowselected = [];


%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end

