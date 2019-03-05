% OBJECTIVE: Calculate #####
function obj = dropcol(obj,colstr)
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
    obj = obj.col(colstr);
    coldouble = obj.colselected;
end
obj.table(:,coldouble) = [];
obj.colselected = [];


%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end

