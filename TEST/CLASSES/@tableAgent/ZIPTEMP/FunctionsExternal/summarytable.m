function Tsummary = summarytable(T)
nvar = width(T);
nrow = height(T);
vEN = T.Properties.VariableNames;
vCN = T.Properties.VariableDescriptions;
if isempty(vCN) 
    vCN = repmat({''},1,nvar);
end
vUnit = T.Properties.VariableUnits;
if isempty(vUnit)
   vUnit = repmat({''},nvar,1)';
end

TID = table(vEN',vCN',vUnit','variablenames',{'vName','vDES','vUnit'}); 
tfnums = false(nvar,1);
tfdatetime = false(nvar,1);
tfothers = false(nvar,1);
vType = repmat({'STR'},nvar,1);
for ii=1:nvar
    Aii = T{:,ii};
    if isnumeric(Aii)
       tfnums(ii) =  true;
       vType{ii} = 'NUM';
    elseif  isdatetime(Aii)
       vType{ii} = 'Datetime';
       tfdatetime(ii) = true;
    elseif ischar(Aii)
        T.(vEN{ii}) = cellstr(T{:,ii});
        tfothers(ii) = true;
    else
        tfothers(ii) = true;
    end
end
Ttype = table(vType,'variablenames',{'vType'});
%% summarize numerical data
TsumNum = summarize2(T{:,tfnums});
% nNums = sum(tfnums);
% TsumDatetime = createBlankRow(TsumNum,sum(tfdatetime));
TsumDatetime = summarizeDatetime(T{:,tfdatetime});
TsumStr = summarizeString(T{:,tfothers});

Tsum2 = [TsumNum;TsumStr];
Tsum2(tfnums,:) = TsumNum;
Tsum2(tfdatetime,:) = TsumDatetime;
Tsum2(tfothers,:) = TsumStr;

Tsummary = [TID,Ttype,Tsum2];
end
