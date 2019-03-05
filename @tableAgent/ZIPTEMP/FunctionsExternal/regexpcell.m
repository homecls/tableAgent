function ids =  regexpcell(tmpstr, cellNames)
% TFAtmp2 =  regexpcell(tmpstr, cellNames)

if isnumeric(tmpstr); tmpstr = num2str(tmpstr); end;
TFAtmp = regexp(tmpstr,cellNames);


    if ~iscell(TFAtmp)
        ids = TFAtmp;
    else
        ids = cellfun(@any,TFAtmp);
    end
end