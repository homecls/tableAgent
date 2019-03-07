% OBJECTIVE: Calculate #####
function obj = blockCopy(obj,rowsA,colsA,rowsTarge,colsTarget)
%  = fn(,)
%
%% INPUT
%  = 
%  = 
%% OUTPUT
%  = 
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
%% VERSION: v1.0 2019/03/02


%% Part 1, Data
rowsA = rowstr2rowdouble(obj,rowsA);
rowsTarge = rowstr2rowdouble(obj,rowsTarge);
colsA = colstr2coldouble(obj,colsA);
colsTarget = colstr2coldouble(obj,colsTarget);

temp = obj.table(rowsTarge,colsTarget);
obj.table(rowsTarge,colsTarget) = obj.table(rowsA,colsA);
% obj.table(rowsA,colsA) = temp;

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end
