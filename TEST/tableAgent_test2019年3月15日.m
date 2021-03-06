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

% ### general preparation

% ``` matlab
clc; clear; close all; % fclose all;
P.prj = addpathprj('tableAgent');
cd(P.prj);
% ``` 

%% ### Prepare Data for futher test

% ``` matlab
load patients.mat
TRaw = table(LastName,Gender,Age,Height,Weight,Location,Smoker,Diastolic,Systolic,...
    SelfAssessedHealthStatus);
T = tableAgent(TRaw);
Ttable = T.table;
clear Age Diastolic Gender Height LastName Location SelfAssessedHealthStatus Smoker Systolic Weight
fCsv = 'data_patients.csv';
writetable(TRaw, fCsv,'Delimiter' ,'\t','QuoteStrings',true,'Encoding','UTF-8')
% ```


% ## tableAgent Construction 

% ### Construction method 1
% ``` matlab
TB = tableAgent;
TB.name = ["Joan","Merry","Tom","Kate"]';
TB.sex = ["male","female","male","female"]';
TB.grade = [99,67,66,35]';
TB.G = [99,67,88,55]'+ 4;
% ``` 

%% ### Construction method 2
% ``` matlab
TB = table;
TB.name = ["Joan","Merry","Tom"]';
TB.grade = [99,67,35]';
TB.G = [99,67,35]'+ 4;
TB = tableAgent(TB);
% ``` 

%% ### Construction method 3
% ``` matlab
TB = readtableAgentRaw(fCsv);
TB = readtableAgent(fCsv);
% ``` 


%% Access data of tableAgent

%% ###  Access Block of tableAgent

% ``` matlab
TB = T;
TB{1,8:9} = [1,125];
disp(TB{1,5});
TB{1,1} = {'SMITH'};
data1 = T([1,3,6],'s.*') % select cols by regexp matching
data2 = T([1,3,6],'^S.*') % select cols by regexp matching
data3 = T([1,3,6],'c$') % select cols by regexp matching
data4 = T{[1,3,6],'Age'} % TODO: data1 = T{'Age<20','Age'};
data5 = TB{1,3};
% ``` 

%% ## chain method demo

%% ## generate/update columns
% ### generate new col or variable, by passing inline-function para
% % Test of passing inline-function para

% ``` matlab
fnew = @(x)(x+3);
TB = T.row().gen('Age=fnew(pi)',fnew,'fnew');
% ``` 

% % test of dropcols keepcols, and droprows keeprows
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
%
TB = T.keepcol(5).keeprow([1,3:13]);
% ```


%% test by gen
% ### generate new col for constant
% ``` matlab
TB = T.gen('G1="good"');
TB = T.gen('G2=1');
TB = T.gen('G3=NaT');
TB = T.gen('No2=1:obj.height'); % nature number col

data = {'Miller5555','Female',33,64,142,'VA Hospital',1,88,130,'Good'};
vName = T.table.Properties.VariableNames; %%##
temp1 = cell2table(data,'VariableNames',vName);

aa = [T.table;temp1];



TB.No2 = (1:TB.height); % gen nature number col
TB.No2 = 1;
TB.No2 = 'good';

TB = T.row([1:10]).gen('Age3=pi');
TB = T(1:3,2:3).row(1).gen('Age4=Age+100');
% ``` 

% ### generate new col from other cols
% ``` matlab
TB = T.row('ismember(LastName,{''Jones''})').gen('Age2=Age+100')...
    .row([1,2]).gen('Age2=Age+100');
TB = T.runCmdGen('Age2 = Age + 100');
% ``` 

% ### generate new col or variable, by passing inline-function para

% ``` matlab
% % Test of passing anonymous-function-para
fnew = @(x)(x+3);
TB = T.row().gen('Age=fnew(pi)',fnew,'fnew');
% ``` 

% ### Test of passing variable-para
para.x = [1,1]';
para.y = [10,10]';
TB = T.row([1,2]).gen('AgeB=Age + para.x',para);


% ### generate new col by group operation

% ``` matlab
% % method 1
TB = T.row('Systolic>=120').groupby('Gender').genbygroup('Systolic_TF = Systolic - mean(Systolic)')...
    .genbygroup('Diastolic_TF = mean(Diastolic)');
% % method 2
TB = T.groupby('Gender','AgeMean',@(x)mean(x),'Age');% coly = f(colx)
% ```

% ### generate new col for each cols
TB = T.row([1,2]).gen_forEachCol('Age,Height','$x+4','$x_add');

TB = T.row().gen_slice('HH', ...
    ["ismember(LastName,{'Smith','Jones'})","'NAME'"; ...
    "ismember(Gender,{'Female'})","'female'"
    "else","'ELSE'"]);

% ### generate new col for dummy variable
TB = T.gen_dummy('Age');

%% ### test for block Exchange and Copy
rowsA = 1;
colsA = 2:8;
rowsTarget = rowsA +1;
colsTarget = colsA;
TB = T.blockExchange(rowsA,colsA,rowsTarget,colsTarget);
TB = T.blockCopy(rowsA,colsA,rowsTarget,colsTarget);

% ###  Function declare: merge
TB = T.gen('Age3 = Age+100');
TC = TB([1,2],[1,11]);
TM = T.merge(TC,'LastName');

% ###  Function declare: query
keyA = 'LastName';
keyB = keyA;
valsA = 'Age3';
valsB = 'Age3';

TM = T.queryTabAinTabB(keyA,valsA,TC,keyB,valsB);

% ### Function declare: stack
TB = tableAgent;
TB.Month = {'October';'November';'December';...
    'January';'February';'March'};
TB.Year = [2005*ones(3,1); 2006*ones(3,1)];
TB.NE = [1.1902; 1.3610; 1.5003; 1.7772; 2.1350; 2.2345];
TB.MidAtl = [1.1865; 1.4120; 1.6043; 1.8830; 2.1227; 1.9920];
TB.SAtl = [1.2730; 1.5820; 1.8625; 1.9540; 2.4803; 2.0203];

TC = TB.stack('NE,MidAtl,SAtl');

TD = TC.unstack('NE_MidAtl_SAtl','NE_MidAtl_SAtl_Indicator');


[TB,TC] = T.pivot({'Gender','Smoker'},'Diastolic',@numel);


% stackCell
TM = TD.gen_forEachCol('Year,NE,MidAtl,SAtl','num2str($x)');
TM{1,1:5} = TM.table.Properties.VariableNames;

TN = TM.stackCell('loc,Value',(1:6),(1:2),([3,4,5]));
% TM.stackCell(vnameRowandColval,rows,colsID,colsVal)


%% ##  test of disp
T.disp
disp(T);
disp(T.table);

T.dispclass;
dispclass(T);
T.gen('G=2').dispclass;

T.dispBasicProperties;

%% ## test of plotcols
hf = figure;
setfontdefault(11)
T.gen('No=1:obj.height').plotcols('No,Age,Weight');

%%

%% ## a long example
TB = T.row('Age==40|Age<35').gen('Age = Age+1').gen('G = Age*2')...
    .row('Age<=99').gen('G = log(Age)*10')...
    .row([1,3]).gen('G=3')...
    .row().gen('G=pi');

tt = T.table;
tb = TB.table;
return;
