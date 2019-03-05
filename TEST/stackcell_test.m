% OBJECTIVE: demo of stackcell
% function A Tableagent = main(file of xls ,args for stackcells)
%
%% INPUT
% file of xls  = 
% args for stackcells = 
%% OUTPUT
% A Tableagent = 
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

clc; clear; close all; % fclose all;
P.prj = addpathprj('tableAgent');
pfData = 'C:\Dropbox\YY_LL\PROJECTS\Tools_Matlab_Dropbox\DATAtool\TableTool\tableAgent\tableAgent\@tableAgent\test\DATA\DataRaw\TEST_中国地级市_商品房销售额-销售面积-平均售价_知网.xls';
%% Part 1, Data
% T = readtable(pfData,'ReadVariableNames',false);
% save './DATA/DataTemp/Datatemp_stackcell.mat' T
load 'C:\Dropbox\YY_LL\PROJECTS\Tools_Matlab_Dropbox\DATAtool\TableTool\tableAgent\tableAgent\@tableAgent\test\DATA\DataTemp\Datatemp_stackcell.mat' T
TRaw = T;
T2 = TRaw([1:20],[1:3,(4+7*3):3:(4+5*3+20)]);
T = tableAgent(T2(:,1:end));
% T.table;
% disp(T)
%%
rows = [2:T.height];
cols = [1,4:1:T.width];
rowsA = 1;
colsA = 4:8;
TB = T.blockExchange(rowsA,colsA,rowsA+1,colsA)...
    .stackCell('Year,Value',(2:10),(1:3),([4,8]));
TB.Year = str2doubleq(extractBefore(TB.Year,'年'));
TB.Value = str2doubleq(TB.Value);
TB.No = 1:TB.height;
TC = TB.row([2:16]).gen_slice('HH',["Value>7000","2"; "Value<2000","11"]);
%% test gen_slice
% TB = T.row().gen_slice('HH',["Value>7000","2"; "Value<7000","11"])


%% test gen_slice
% TB = T.row().gen_slice('HH',["ismember(Var25,{'6657','2629'})","11"; "ismember(Var25,{'5903','963'})","22"])
% TB = T.row().gen_slice('HH','ismember(Var25,{''6657'',''2629''}),0')
%% test of plotcols
hf = figure;
setfontdefault(13)
% setfontfigNoTightfig(hf)
TB.plotcols('No,Value,Year');
return;
%% test runcmd
TB = T.row('ismember(Var25,{''6657'',''2629''})').runCmdGen('G = Var25+"__2"')...
    .row('ismember(Var25,{''7107'',''963''})').gen('G2 = Var25+"__xx"').dispclass;


%% test runcmd
TB = T.row('ismember(Var25,{''6657'',''2629''})').gen('G = Var25+"__2"')...
    .row('ismember(Var25,{''7107'',''963''})').gen('G2 = Var25+"__xx"').dispclass;

%% test for block Exchange
vs = 'Year,Value';
rows = [2:T.height];
cols = [1,4:1:T.width];
rowsA = 1;
colsA = 4:8;
TB = T.blockExchange(rowsA,colsA,rowsA+1,colsA)...
    .stackCell(vs,(2:10),(1:3),([4,8]));

% TB = T.blockExchange(rowsA,colsA,rowsA+1,colsA)...
%     .stackCell('Year,Data',(2:10),(1:3),([4,8]));
TB = T.runCmdGen('yy = ');

% row([2:T.height]).col([1,4:T.width])
%% 
% vs = {'City','Year','Value'};
% nrows = height(T.table);
% ncols = width(T.table);
% rows = [2:nrows];
% cols = [1,4:1:ncols];
% TB = T.stackCell(vs,rows,cols).disp;

return
%% test for block Exchange
rowsA = 1;
colsA = 4:8;
TB = T.blockExchange(rowsA,colsA,rowsA+1,colsA)...
    .row([2:height(T.table)]).col([1,4:width(T.table)]).stackCell(vs,rows,cols)

T.row([2:height(T.table)])
T.col([1,4:width(T.table)])
return;
%% Part 2, Calculation
% % test of gen
% para.x = {'xx'};
% TB = T.gen('VarNEW=strcat(Var28,para.x)',para);

%% Part 3, Output of result


%% Part 4, Demo of result


