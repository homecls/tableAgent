% OBJECTIVE: Calculate #####
function obj = blockExchange(obj,rowsA,colsA,rowsB,colsB)
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
rowsB = rowstr2rowdouble(obj,rowsB);
colsA = colstr2coldouble(obj,colsA);
colsB = colstr2coldouble(obj,colsB);

temp = obj.table(rowsB,colsB);
obj.table(rowsB,colsB) = obj.table(rowsA,colsA);
obj.table(rowsA,colsA) = temp;

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end
