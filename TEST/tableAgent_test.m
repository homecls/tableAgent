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
% Tagent.row('grade>1').gen('G = grade*9');

%% Part 3, Output of result
Tagent.row('grade==67|grade<38').gen('grade = grade+1').gen('G = grade*2')...
    .row('grade==99').gen('G = log(grade)*10');
%% Part 4, Demo of result
disp(T)
disp(Tagent.table)
return;
 
