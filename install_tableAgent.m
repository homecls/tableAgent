% objective: install tableAgent class by addpath
clc; clear;

p = cdmfile(mfilename);
pTableAgent = p;
addpath(genpath(pTableAgent),'-end');
savepath;

return;
function p = cdmfile(mfile)
% p = cdmfile(mfile)
cd(fileparts(which(mfile)));
p = pwd;
end