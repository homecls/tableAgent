% Author: linrenwen@gmail.com
% 2019/02/24
% 缺失两个文件，需要补充：mysin.m  DataTemp.xlsb, 并拷贝如.zip文件

clc; clear; close all; %fclose all
P = addpathprj('tableAgent');
cdmfile(mfilename);
tic
[pfZip,pfList,pfMain,pfClass] = packageMfile('tableAgent_test.m');
toc

