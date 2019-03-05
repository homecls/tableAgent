function varargout =  addpathprj(varargin)
% p = addpathprj('成绩统计');
% p = addpathprj('C:\Dropbox\YY_LL\课程合辑\货币银行学（英）\2018秋_货银（辅选）\成绩统计');
% p = addpathprj(-1);
% varargin{1} no of layer
% 1 or -1, or 0
% '成绩统计'
% 'C:\Dropbox\YY_LL\课程合辑\货币银行学（英）\2018秋_货银（辅选）\成绩统计'
% function varargout =  addpathprj(varargin)
% argin
% #1 = # of the layers
% #2 = '-BEGIN'  / '-END'
% ARGOUT
% #1 = p


% mystack = dbstack;
% which(currentmfilepath)
% CallerFileNameWithPath = which(mystack(end).file);




% parts
pathpwd = string(pwd);
pathNames(1) = pathpwd;
folderNames(1) = string(missing);
[porg,norg] = fileparts(pathpwd);
pathNames(2) = string(porg);
folderNames(2) = string(norg);
ip = 2;
while ~isequal(folderNames(ip),folderNames(ip-1))
    % disp(paths(ip));
    [porg,norg] = fileparts(pathNames(ip));
    ip = ip+1;
    pathNames(ip) = string(porg);
    folderNames(ip) = string(norg);
end
narginchk(0,1);
if nargin == 0
    paraFolder = 1;
else
    paraFolder = varargin{1};
end


% for the case "C:\Dropbox\YY_LL\课程合辑\货币银行学（英）\2018秋_货银（辅选）\成绩统计"
if ~isnumeric(paraFolder) && contains(paraFolder,':\')
    pathadded = genpath(paraFolder);
    addpath(pathadded,'-begin');
    varargout{1} =  paraFolder;
    varargout{2} =  pathadded;
    return;
end

% deal with 1 -1; or 'folder name'
switch class(paraFolder)
    case {'double'}
        nlayer = abs(paraFolder);
        p = pathNames(nlayer+1);
    case {'string','char'}
        folderNamei = string(paraFolder);
        idi = (folderNamei==folderNames);
        if ~any(idi) 
            error('no match of folder name')
        else
            idxis = find(idi);
            idxi = idxis(1);
            p = pathNames(idxi)+"\"+folderNames(idxi)';
        end
    otherwise
            error('the class of para #1 should be string or double')
end




pathofPrj = p;
pathadded = genpath(pathofPrj);
addpath(pathadded,'-begin');

if nargout >= 1
    varargout{1} = pathofPrj;
end
if nargout == 2
    varargout{2} = pathadded;
end

%% Alternative Approach that can be used directly in the calling file
% pm = mfilename('fullpath');
% p = fileparts(fileparts(pm));
% addpath(genpath(p),'-begin');
end