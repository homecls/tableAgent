% OBJECTIVE: Calculate #####
function fzip = zipFiles(fall,fzip)
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

% find mainfile
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


%% Part 2, Calculation

% 2.1 move all file to a temp folder then zip it
mkdir('ZIPTEMP');
mkdir('ZIPTEMP\FunctionsExternal');
nNotClassNotMain = numel(pfNotClassNotMain);
for ifile=1:nNotClassNotMain
    copyfile(pfNotClassNotMain{ifile},'ZIPTEMP\FunctionsExternal');
end
copyfile(pfMain,'ZIPTEMP');
copyfile(pfEmf,'ZIPTEMP');

pOrg = pwd;


cmdstr = """C:\Program Files\WinRAR\WinRAR.exe"" a -r -ibck" ...
    + " """ + pfZip + """ "...
    + " """ + "FunctionsExternal" + """ "...
    + " """ + fmain + """ "...
    + " """ + fEmf + """ "; % -AP means append % -r means reserve path
% log = dos(cmdstr);


% 2.2 zip the files of class and their method functions
% cmdstrP1 = "7z a " + """" + pfZip + """";
cd('ZIPTEMP')
for ifC =1:nClass
    ipClass = pclassUnique(ifC);
    copyfile((ipClass),makeitchar("CLASSES\"+filepartsname(ipClass)) );
    
    % cmdstrP2 = strjoin(" """ + fclass(ipClass == pclass) + """ ");
    cmdstrP2 = " """ + ipClass + """ ";
    % cmdstr = char(cmdstrP1 + cmdstrP2+ "");
%     cd(fileparts(ipClass));
%     log = dos(cmdstr);
end
% cd(pOrg)
cmdstrP1 = """C:\Program Files\WinRAR\WinRAR.exe"" a -r -ibck " + """" + pfZip + """"; % -r root of path
cmdstrP2 = " """"";
cmdstr = char(cmdstrP1 + cmdstrP2+ "");

log = dos(cmdstr);

cd(pOrg);
rmdir('ZIPTEMP','s');


% zip the files not belong to class
% cmdstrP1 = """C:\Program Files\WinRAR\WinRAR.exe"" a -AP " + """" + pfZip + """"; % -AP means append % -r means reserve path
% cmdstrP2 = strjoin(" """ + pfNotClassNotMain + """ ");
% cmdstr = char(cmdstrP1 + cmdstrP2);
% log = dos(cmdstr);




% 
% filestobezip1 = strcat('functions\', filepartsname(fAllWithoutMainEmf));
% filestobezip2 =  filepartsname({fMain,femf});
% filestobezip = [filestobezip1;filestobezip2];
% zip(fzip,filestobezip,[pwd, '\ZIPTEMP\']);
% fZIPTEMP = [pwd, '\ZIPTEMP'];
% rmdir('ZIPTEMP','s');
% %
% 
% %%
% idMain = string(filepartsname(fall))==string(f);
% fMain = fall{idMain,1};
% fMainPath = fileparts(fMain);
% fAllWithoutMainEmf = fall(~idMain); 
% pOrg = pwd;
% cd(fMainPath)
% mkdir('ZIPTEMP');
% mkdir('ZIPTEMP\functions');
% for ifile=1:numel(fAllWithoutMainEmf)
%     copyfile(fAllWithoutMainEmf{ifile},'ZIPTEMP\functions');
% end
% copyfile(fMain,'ZIPTEMP');
% copyfile(femf,'ZIPTEMP');
% filestobezip1 = strcat('functions\', filepartsname(fAllWithoutMainEmf));
% filestobezip2 =  filepartsname({fMain,femf});
% filestobezip = [filestobezip1;filestobezip2];
% zip(fzip,filestobezip,[pwd, '\ZIPTEMP\']);
% fZIPTEMP = [pwd, '\ZIPTEMP'];
% rmdir('ZIPTEMP','s');
%% Part 3, Output of result


%% Part 4, Demo of result


end
