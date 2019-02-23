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

clc; clear; close all; % fclose all;
P.prj = addpathprj('tableAgent');

%% Part 1, Data 
% method 1
T = tableAgent;
T.name = ["Joan","Merry","Tom","Kate"]';
T.sex = ["male","female","male","female"]';
T.grade = [99,67,66,35]';
T.G = [99,67,88,55]'+ 4;
return;

%%  method 2
Ttable = table;
Ttable.name = ["Joan","Merry","Tom"]';
Ttable.grade = [99,67,35]';
Ttable.G = [99,67,35]'+ 4;
T2 = tableAgent(Ttable);
clear Ttable T2
return;

%% test by group gen
TB = T.row('G>=60').groupby('sex').genbygroup('Gmean = mean(G)');
TB = T.row('G>=60').groupby('sex').genbygroup('SexPlus = G+1')...
    .genbygroup('SexPlus = sex+"plus"');

TB = T.row([1,4]).groupby('sex').genbygroup('SexPlus = G+1')...
    .genbygroup('SexPlus = sex+"plus"');

% T = T.gen('SexPlus=string(missing)').row('G>=60').groupby('sex').genbygroup('SexPlus = sex+"plus"');

return
%% test by gen

T2 = T.gen('Gmean="good"');
T = T.gen('Gmean=1');
T = T.gen('Gmean=NaT');
% T = T.gen('Gmean="bad"');
% T = T.gen('Gmean=G+1');

% T = T.gen('Gmean=NaN').row('G>=60').groupby('sex').genbygroup('Gmean = mean(G)');


return;
%% test of groupby
% T = T.groupby('sex')
T2 = T.groupby('sex','Gmean',@(x)mean(x),'G');


return;
%% test gen new cols or vars
TB = T.row('name=="Merry"').gen('G2=G+3')...
    .row([1,3]).gen('G2=G+9');
TB = T.row().gen('G3=pi');

%% test of dropcols and droprows
TB = T.row([1,2]).droprow('G==71');
TB = T.keeprow([1,3,4]);
TB = T.dropcol(2).row(3).droprow().keepcol('name,G');

TB = T.droprow('G==71');
TB = T.row(1).droprow()
return;
%% Test of assign
T.gen('G=grade+4');
d1 = T{1,'G'};
TB = T(1:3,2:3).row(1).gen('G3=grade+5');
d2 = TB{1,3};
assert(d2-d1==1,'fail to item should equal')
return;

%% Test of passing variable-para x
para.x = [1,1]';
para.y = [10,10]';
T.row([1,2]).gen('Gx=grade + para.x',para);
disp(T.table)

%% Test of passing anonymous-function-para
fnew = @(x)(x+3);
TB = T.row().gen('G2=fnew(pi)',fnew,'fnew');

%% Test of assign
T{1,2:3} = [33,55]; %FIXME: 33 Will Be change to "33" in this case;
T{1,1} = "Joan,Hi";
disp(T.table)







%% Part 3, a long example
TB = T.row('grade==67|grade<38').gen('grade = grade+1').gen('G = grade*2')...
    .row('grade<=99').gen('G = log(grade)*10')...
    .row([1,3]).gen('G=3')...
    .row().gen('G=pi');

%% test of disp
T = T.row([1,2]);
T.gen('G=2').dispclass;
dispclass(T);
disp(T);
disp(T.table);
% FIXME: T.row(1,3).dispclass; are not supported, since no 'subsrefDot' for
% tablAgent class

return;
 
