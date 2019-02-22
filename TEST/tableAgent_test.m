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

T = table;
T.name = ["Joan","Merry","Tom"]';
T.grade = [99,67,35]';

%% Part 2, Calculation
Tagent = tableAgent(T);


%% Test of passing variable x
para.x = [1,1]';
para.y = [10,10]';
Tagent.row([1,2]).gen('Gx=grade + para.x',para);
disp(Tagent.table)
return

%% Test of passing variable-para x
para.x = [1,1]';
para.y = [10,10]';
Tagent.row([1,2]).gen('Gx=grade + para.x',para);
disp(Tagent.table)

%% Test of passing inline-function para
fnew = @(x)(x+3);
Tagent.row().gen('G=fnew(pi)',fnew,'fnew');
Tagent.row().gen('G2=fnew(pi)',fnew,'fnew');

%% Test of assign
Tagent{1,2:3} = [33,55];
Tagent{1,1} = "Joan,Hi";
disp(Tagent.table)





%% Part 3, Output of result
Tagent.row('grade==67|grade<38').gen('grade = grade+1').gen('G = grade*2')...
    .row('grade<=99').gen('G = log(grade)*10')...
    .row([1,3]).gen('G=3')...
    .row().gen('G=pi');

% Tagent.row().gen('G2=[]');
% Tagent.row().gen('G=pi',@log,@sin);
%% Part 4, Demo of result
disp(T)
disp(Tagent.table)


return;
 
