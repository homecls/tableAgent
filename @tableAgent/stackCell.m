% OBJECTIVE: Calculate #####
function [obj,BCell] = stackCell(obj,vnameRowColVal,rows,colsID,colsVal)
% obj = fn(obj,vnameRowColVal) % rows,colsID,colsVal are given by
%       obj.colselcted and obj.rowselected
% obj = fn(obj,vnameRowColVal,rows,colsID,colsVal)
%
%% INPUT
% obj = 
% vnameRowColVal,rows,cols = 
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
%% VERSION: v1.0 2019/03/02


%% Part 1, Data

switch nargin
case {2}
    % stackCell(obj,vnameRowColVal£©
    rows = obj.rowselected;
    cols = obj.colselected;
    if islogical(cols); cols=find(cols);end
    colsID = cols(1);
    colsVal = cols(2:end);

case {5}
    % stackCell(obj,vnameRowColVal,rows,colsID,colsVal)
    if islogical(colsID); colsID=find(colsID);end
    if islogical(colsVal); colsVal=find(colsVal);end
    cols = [colsID(:);colsVal(:)];
    
otherwise
    error('# of arg should be 2, or 5! %s','');
end
Acell = table2cell(obj.table(rows,cols));
nColsID = numel(colsID);
rowsSub = 1:numel(rows);
colsIDSub = 1:nColsID;
colsValSub = (nColsID+1):numel(cols);

[vnameRowColVal] = strCommaSemicolon2cellstr(vnameRowColVal);
BCell = stackCell(Acell,vnameRowColVal,rowsSub,colsIDSub,colsValSub);
obj.table = cell2tableWithhead(BCell);
vnames = obj.table.Properties.VariableNames;
Name = vnames(:);
labelRaw = BCell(1,:);
Label = labelRaw(:);
obj.TcolLabel2colName = table(Label,Name);
% obj.label = table(label);
% obj.label.Row = vnames; % obj.label.(1){'Year'}
obj.table = setOriginalVarnameofTableVar(obj.table, Name, Label);


%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end
