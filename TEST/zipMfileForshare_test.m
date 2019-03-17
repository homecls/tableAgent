% Author: linrenwen@gmail.com
% 2019/02/24

clc; clear; close all; %fclose all
P = addpathprj('tableAgent');
cdmfile(mfilename);
tic
[pfZip,pfList,pfMain,pfClass] = packageMfile('tableAgent_test.m');
toc
