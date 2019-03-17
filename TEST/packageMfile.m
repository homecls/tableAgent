function [pfZip,pfList,pfMain,pfClass] = packageMfile(f,varargin)

% find functions and their dependence.
% plot the function dependence.
% hf = figure('visible','off');
% opt = plot_depfunLRW(f);
% femf = strrep(f,'.m','.emf');
fzip = strrep(f,'.m','.zip');
% saveas(hf,femf)
% fList = opt.us.full(:);
% % tic
fprintf('P1,find depend functions and files called by %s\n',f);
tStart = tic;
[fList,pList] = matlab.codetools.requiredFilesAndProducts(f);
% % toc
tEnd = toc(tStart);
fprintf('finished within %d minutes and %f seconds\n', floor(tEnd/60), rem(tEnd,60));

fList = string(fList)';
% % % save data_files.mat fList fzip
% load data_files.mat fList fzip
% [zipfilename,req] = exportToZipLRW(f,varargin{:});
fprintf('P2,zip the files. ')
tStart = tic;
[pfZip,pfList,pfMain,pfClass] = zipFiles(fList,fzip);
tEnd = toc(tStart);
fprintf('finished within %d minutes and %f seconds\n', floor(tEnd/60), rem(tEnd,60));
% rmdir('ZIPTEMP');
if exist('ZIPTEMP','dir')
    rmdir('ZIPTEMP','s');
end 