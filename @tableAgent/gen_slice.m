% OBJECTIVE: Calculate #####
function obj = gen_slice(obj, coly, ifthenGen)
% obj = (obj,coly,ifthenGen)
%
%% INPUT
% obj = 
% coly,
% ifthenGen = 'colx>3,4;colx<3,5;otherwise,colz' or {'colx>3','4';'colx<3','5';'otherwise','colz'}
%% OUTPUT
% obj = 
%
%% REQUIRMENT
% 
% 
%% EXMAPLE
% TC = TB.row([2:16]).gen_slice('colnew',["Value>7000","2"; "Value<5000","11";"else","0"]);
% TB.row([2:16]).gen_slice('colnew',["Value>7000","3"; "Value<5000","2";"else","Year"])
% TC = TB.row([2:16]).gen_slice('colnew',{'Value>7000','3'; 'Value<5000','2';'otherwise','Year'})
% 
%% SEE ALSO
%
% 
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/03/05


%% Part 1, Data
variableNames = obj.table.Properties.VariableNames;
coly2 = strCommaSemicolon2cellstr(coly);

if ischar(coly2)
    coly2 = coly2;
    
elseif coly2==0
    coly2 = coly;

else
    coly2 = variableNames(coly2);
end

ifthenGen2 = strCommaSemicolon2cellstr(ifthenGen);
strrow = ifthenGen2(:,1);
strCmdGen = strcat(coly2,{' = '},ifthenGen2(:,2),{' ;'});
%% Part 2, Calculation
nCmd = numel(strCmdGen);
nRowSelection = numel(strrow);
if ~(nCmd == nRowSelection)
   error("~(nCmd == nRowSelection)") 
end
nHeight = height(obj.table);
rowselectedReserve = index2indexTF(nHeight, obj.rowselected);
% aa = obj.table;
%% dealwith otherwise or else

[~,indexOtherwise] = ismember(strrow, {'otherwise','Otherwise','else','Else','ELSE','OTHERWISE'});
HASOTHERWISE = false;
if any(indexOtherwise)
    HASOTHERWISE = true;
    idelse = (indexOtherwise>0);
    if sum(idelse)>1
        error('otherwise or else condition shouble be less than 2!')
    else
    strrowOtherwise = strrow{idelse} ;
    strCmdGenOtherwise = strCmdGen{idelse} ;
    strrow(idelse) = [];
    strCmdGen(idelse) = [];
    end
end % if else/otherwise term occurs

irows = false(nHeight,nCmd);
nCmdCut = numel(strCmdGen);
for iCmd = 1:nCmdCut
    [obj,irowsRaw] = obj.row(strrow{iCmd});
    
    irow = irowsRaw & rowselectedReserve;
    obj = obj.row(irow).runCmdGen(strCmdGen{iCmd});
    
    irows(:,iCmd) = irow(:);
end
rowCount = sum(irows,2);
IDrowCountDuplication = (rowCount >1);
if any(IDrowCountDuplication)
    warning('row #%s, are modified more one time!',strjoin(string(find(IDrowCountDuplication)),', '))
end
irowOtherwise = ~any(irows,2);
if HASOTHERWISE
    rowsElse = irowOtherwise & rowselectedReserve;
    obj = obj.row(rowsElse).runCmdGen(strCmdGenOtherwise);
end

obj.rowselected = rowselectedReserve;



%% Part 3, Output of result

end % function


