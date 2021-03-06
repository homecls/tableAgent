% OBJECTIVE: test of table Agent
% function A table agent = main(A table,)
%
%% INPUT
% A table = 
%  = 
%% OUTPUT
% A table agent = 
%
%% REQUIRMENT
% 
% 
%% EXMAPLE
% example 
%  
% 
%% SEE ALSO
%
% 
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/21


%% ## Prepare Data for test
% general preparation
clc; clear; close all; % fclose all;
P.prj = addpathprj('tableAgent');
cd(P.prj);

%% Prepare Data for futher test
load patients.mat
TRaw = table(LastName,Gender,Age,Height,Weight,Location,Smoker,Diastolic,Systolic,...
    SelfAssessedHealthStatus);
T = tableAgent(TRaw);
Ttable = T.table;
clear Age Diastolic Gender Height LastName Location SelfAssessedHealthStatus Smoker Systolic Weight
fCsv = 'data_patients.csv';
writetable(TRaw, fCsv,'Delimiter' ,'\t','QuoteStrings',true,'Encoding','UTF-8')

%% tableAgent Construction 
% Construction method 1
TB = tableAgent;
TB.name = ["Joan","Merry","Tom","Kate"]';
TB.sex = ["male","female","male","female"]';
TB.grade = [99,67,66,35]';
TB.G = [99,67,88,55]'+ 4;


% Construction method 2
TB = table;
TB.name = ["Joan","Merry","Tom"]';
TB.grade = [99,67,35]';
TB.G = [99,67,35]'+ 4;
TB = tableAgent(TB);
TB.table.Properties.VariableNames({'G'}) = {'G2'};
TB.table.Properties.VariableNames = {'A','B','C'};


% Construction method 3
fxls = 'DataTemp.xlsb';
TB = readtableAgent(fxls);

%%

%% test of label setting
TB.TcolLabel2colName
% return
%% assign 
TB = T;
TB{1,8:9} = [1,125];
disp(TB{1,5});
TB{1,1} = {'SMITH'};
TB.No2 = (1:TB.height); % gen nature number col
TB.No2 = 1;
TB.No2 = 'good';

%% Access data of tableAgent
% access by head and tail
data4 = T.head(2)
data4 = T.head
data4 = T.tail(3)

% Access Block of tableAgent
% access subindex
data1 = T([1,3,6],'s.*') % select cols by regexp matching
data2 = T([1,3,6],'^S.*') % select cols by regexp matching
data3 = T([1,3,6],'c$') % select cols by regexp matching
data4 = T('Age>48','1:Age')
data4 = T('Age>48',3:4).keepcol(1)
data4 = T(:,3:4) 
% FIXME: T(1:end,3:4) are not supported, because of end

data5 = TB{1,3:6}
data4 = T{[1,3,6],'Age,Smoker'} 
data4 = T{[1,3,6],'Age:end'} 
data4 = T{[1,3,6],'Age:4'} 
data4 = T{[1,3,6],'1:Age'} 
data4 = T{'Age>48','1:Age'}
data4 = T{'Age>48','3:4'}


%% generate or update columns
% generate new col or variable, by passing inline-function para
% Test of passing inline-function para
fnew = @(x)(x+3);
TB = T.row().gen('Age=fnew(pi)',fnew,'fnew');
% alternative method: define your function in mfile
TB = T.row().gen('Age=mysin(pi)');

% test of dropcols keepcols, and droprows keeprows
TB = T.keepcol('LastName,Age');
TB = T.keepcol({'LastName','Age'});
TB = T.keepcol(["LastName","Age"]);
TB = T.keepcol([1, 3]);
TB = T.col([1,3]).keepcol();

TB = T.dropcol(3);
TB = T.dropcol('Age');

TB = T.droprow(3);
TB = T.row(3).droprow();
TB = T.row([1,10]).droprow('Age>50'); % drop 
TB = T.keeprow([1,3:13]);
TB = T.keepcol(5).keeprow([1,3:13]);



%% test by gen
% generate new col for constant
TB = T.gen('G1="good"');
TB = T.gen('G2=1');
TB = T.gen('G3=NaT');
TB = T.gen('G4=NaN');
TB = T.gen('G6=6').gen('G7=7');
TB = T.gen('G4=NaN');

% % Syntax for Table class: 
% T.table.G4 = NaN(100,1);
% T.table(:,{'G4'}) = [];
% T.table.G4 = [];

TB = T.gen('No2=1:obj.height'); % nature number col
TB = T.gen("G2=([1:100])'");
TC = TB.keepcol([1:5,11,6:10]);
TC = TB.keepcol(["G2", "Age"]);
TC = TB.keepcol("G2,Age");
TB.table = movevars( TB.table , 'G2' ,'Before', 'Age' );
% TODO: TB = TB.movevars('G2' ,'Before', 'Age' );

data = {'Miller5555','Female',33,64,142,'VA Hospital',1,88,130,'Good'};
vName = T.table.Properties.VariableNames; %%##
temp1 = cell2table(data,'VariableNames',vName);

aa = [T.table;temp1];

TB = T.row([1:10]).gen('Age3=pi');
TB = TB.row([11:20]).gen('Age3=pi*2');
TB = T.row([1:10]).gen('Age3=pi')...
    .row([11:20]).gen('Age3=pi*2');

TB = T(1:3,2:3).row(1).gen('Age4=Age+100');

% generate new col from other cols
TB = T.row('ismember(LastName,{''Jones''})').gen('Age2=Age+100')...
    .row([1,2]).gen('Age2=Age+100');
TB = T.runCmdGen('Age2 = Age + 100');

% generate new col or variable, by passing inline-function para
% Test of passing anonymous-function-para
fnew = @(x)(x+3);
TB = T.row().gen('Age=fnew(pi)',fnew,'fnew');

% Test of passing variable-para
para.x = [1,1]';
para.y = [10,10]';
TB = T.row([1,2]).gen('AgeB=Age + para.x',para);


%% group operation
% generate new col by group operation
% method 1
TB = T(1:30,1:10).groupby({'Gender','Smoker'}).genbygroup('AgeCount = numel(Age)');
% Syntax for Table class: findgroups and splitapply

TB = T.row('Systolic>=120').groupby('Gender')...
    .genbygroup('Systolic_TF = Systolic - mean(Systolic)')...
    .genbygroup('Diastolic_TF = mean(Diastolic)');

% method 2
TB = T.groupby('Gender','AgeMean',@(x)mean(x),'Age');% coly = f(colx)

% generate new col for each cols
TB = T.row([1:20]).gen_forEachCol('Age,Height','$x+4','$x_adj');
 
% generate new col by discrete assign
TB = T.row().gen_slice('ColNew', ...
    ["ismember(LastName,{'Smith','Jones'})","'NAME'"; ...
    "ismember(Gender,{'Female'})","'FEMALE'"
    "else","'ELSE'"]);

% generate new col for dummy variable
TB = T.gen_dummy('Age');
TC = TB.dropcol('^Age_.*');

% pivot
TB = T.pivot({'Gender','Smoker'},{'Diastolic','Systolic'},@std);

%% test for block Exchange and Copy
rowsA = 1;
colsA = 2:2:8;
rowsTarget = rowsA + 1;
colsTarget = colsA;
TB = T.blockExchange(rowsA,colsA,rowsTarget,colsTarget);
TB = T.blockCopy(rowsA,colsA,rowsTarget,colsTarget);

%% merge and query
% merge
TB = T([1,2],:).gen('Age3 = Age+100').keepcol([1,11]);
TM = T.merge(TB,'LastName');

% query
keyA = 'LastName';
keyB = keyA;
colsA = 'Age3';
colsB = 'Age3';
TM = T.queryTabAinTabB(TB,keyA,keyB,colsA,colsB);
% TM = T.queryTabAinTabB(TB,keyA,keyB,valsA,valsB);

%% stack of Table
TB = tableAgent;
TB.Month = {'October';'November';'December';...
    'January';'February';'March'};
TB.Year = [2005*ones(3,1); 2006*ones(3,1)];
TB.NE = [1.1902; 1.3610; 1.5003; 1.7772; 2.1350; 2.2345];
TB.MidAtl = [1.1865; 1.4120; 1.6043; 1.8830; 2.1227; 1.9920];
TB.SAtl = [1.2730; 1.5820; 1.8625; 1.9540; 2.4803; 2.0203];

TC = TB.stack('NE,MidAtl,SAtl');

TD = TC.unstack('NE_MidAtl_SAtl','NE_MidAtl_SAtl_Indicator');

% pivot then unstack， or crosstable
[TB,TC] = T.pivot({'Gender','Smoker'},'Diastolic',@mean);


% stackCell
TM = TD.gen_forEachCol('Year,NE,MidAtl,SAtl','num2str($x)');
TM{1,1:5} = TM.table.Properties.VariableNames;

TN = TM.stackCell('loc,Value',(1:6),[1:2],[3,4,5]);
% syntax: BCell = stackCell(Acell, {'colname' 'varname'},rows,colsID,colsVal)

%% disp of tableAgent
% test of disp
T.disp
disp(T);
disp(T.table);

T.dispclass;
dispclass(T);
T.gen('G=2').dispclass;

T.dispBasicProperties;

%% plot of table cols
% test of plotcols
hf = figure;
setfontdefault(11)
T.gen('No=1:obj.height').plotcols('No,Age,Weight');

%% tableAgent with UTF8 label 
fxls = 'DataTemp.xlsb';
TB = readtableAgent(fxls);
TB.table.Properties.VariableNames(1) = {'City'};
TB.keepcol('1:所属市')
TB.keepcol('City:所属市')  % use TB.headwithLabel to find the label
TB.keepcol(["1", "所属省份"])
TB.keepcol({'1','所属省份'})
TB.dropcol('地区:所属省份')
% TC= TB.col('区域')
TB(1:2,'地区:所属市')
TB{1:2,'地区:5'}

TB.headwithLabel %
TB.label
TB.TcolLabel2colName
TC = TB(1:3,1:4).gen('ColHappy=1');
TM  = TB.mergeWithLabel(TC,'City');


%% a long example of chain method operation
TB = T.row('Age==40|Age<35').gen('Age = Age+1').gen('G = Age*2')...
    .row('Age<=99').gen('G = log(Age)*10')...
    .row([1,3]).gen('G=3')...
    .row().gen('G=pi');



return;

%% Appendix of functions