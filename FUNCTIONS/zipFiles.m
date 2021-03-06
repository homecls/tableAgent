% OBJECTIVE: Calculate #####
function [pfZip,pfList,pfMain,pfClass] = zipFiles(fall,fzip)
% fzip = fn(fall,fzip)
%
%% INPUT
% fall = 
% fzip = 
%% OUTPUT
% fzip = 
%
%% REQUIRMENT
% 
% 
%% EXMAPLE
% 
% 
%% SEE ALSO
%
% How to use 7z for ziping http://blog.haoji.me/windows-cmd-zip.html?from=xa
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/24


%% Part 1, Data
fall = makeitstring(fall);
pfList = fall;

% find mainfile and emf
fmain = string(strrep(fzip,'.zip','.m'));
fEmf = string(strrep(fzip,'.zip','.emf'));
pmainRaw = extractBefore(fall,fmain);
idMain = ~ismissing(pmainRaw);
pmain = pmainRaw(idMain);
pfMain = fall(idMain);
pfZip = pmain + fzip;
pfEmf = pmain + fEmf;

% find files belong to class
pclassRaw = extractBefore(fall,'@');
idClassBefore = ~ismissing(pclassRaw);
pfClass0 = pclassRaw(idClassBefore);

fclassRaw = extractAfter(fall,'@');
idClassAfter = ~ismissing(fclassRaw);
fclass = "@" + fclassRaw(idClassAfter);
classnames = extractBefore(fclass,'\');
pfClass = pfClass0+classnames;

if ~all(idClassBefore == idClassAfter) || ~all(pfClass0+fclass == fall(idClassAfter))
    error('fail to deal ')
end 
pclassUnique = unique(pfClass);
nClass = numel(pclassUnique);

% find files not belong to class
pfNotClassNotMain = fall(~idClassAfter & ~idMain);


%% Part 2, zip the files

%% 2.1 move all file (without class files) to a temp folder then zip it
mkdir('ZIPTEMP');
mkdir('ZIPTEMP\FunctionsExternal');
nNotClassNotMain = numel(pfNotClassNotMain);
for ifile=1:nNotClassNotMain
    copyfile(pfNotClassNotMain{ifile},'ZIPTEMP\FunctionsExternal');
end
copyfile(pfMain,'ZIPTEMP');
% copyfile(pfEmf,'ZIPTEMP');

pOrg = pwd;


cmdstr = """C:\Program Files\WinRAR\WinRAR.exe"" a -r -ibck" ...
    + " """ + pfZip + """ "...
    + " """ + "FunctionsExternal" + """ "...
    + " """ + fmain + """ "; % -AP means append % -r means reserve path...
%     + " """ + fEmf + """ "; % -AP means append % -r means reserve path
cd('ZIPTEMP')
log = dos(cmdstr);


%% 2.2 zip the files of class and their method functions
% cmdstrP1 = "7z a " + """" + pfZip + """";
for ifC =1:nClass
    ipClass = pclassUnique(ifC);
    copyfile(makeitchar(ipClass),makeitchar("CLASSES\"+filepartsname(ipClass)) );
end

cd(pOrg+"\ZIPTEMP");
cmdstr = """C:\Program Files\WinRAR\WinRAR.exe"" a -r -ibck" ...
    + " """ + pfZip + """ "...
    + " """ + "CLASSES" + """ ";

if exist('./CLASSES','dir')
    log = dos(cmdstr);
end

%% delete the temp folder
cd(pOrg);
if exist('ZIPTEMP','dir')
try
    rmdir('ZIPTEMP','s');
catch
    try
        rmdir('ZIPTEMP','s');
    catch
%         rmdir('ZIPTEMP');
    end
    
end
end
end
