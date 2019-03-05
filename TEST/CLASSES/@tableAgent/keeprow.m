% OBJECTIVE: Calculate #####
function obj = keeprow(obj,rowstr)
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

%% get cols to drop
nrow = height(obj.table);
rowtodrop = true(nrow,1);
rowtodrop(rowdouble) = false;

%%
obj.table(rowtodrop,:) = [];
obj.rowselected = [];


end

