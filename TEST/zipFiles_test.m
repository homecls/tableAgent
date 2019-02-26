% function fzip = zipFiles_test(fall,fzip)
clc;clear;close all;
load data_files.mat
addpathprj('tableAgent')
fall = fAll;
fzip = zipFiles(fall,fzip)