function [value, lia, TinAnotB,TinBnotA] = query(key,Table,keyVariableInTable,ValueVariableInTable,varargin)
% ismember(['3','4';1,1],['1','2';'3','4';5,5],'rows')
% query(TcityMapping.CityFullname, Tcity,'name','code');

ncol = numel(makeitcell(ValueVariableInTable));
ncolkey = numel(makeitcell(keyVariableInTable));

TinAnotB = table;
TinBnotA = table;

% supporting multi-col key
if size(key,2)>1
    try
        keySetInTable = Table{:,keyVariableInTable};
    catch
        nkey = size(key{1},1);
        keyString = repmat(string(missing),nkey,ncolkey);
        keySetInTableString = repmat(string(missing),height(Table),ncolkey);
        for icol=1:ncolkey
            keyString(:,icol) = string(key{icol});
            keySetInTableString(:,icol) = string(Table{:,keyVariableInTable{icol}});
        end
        key = keyString;
        keySetInTable = keySetInTableString;
    end
    %     a = [num2cellstr(keySetInTable{1}),keySetInTable{2}]
    %     key = {2,'B'}
    %     [lia,locb] = ismember(key, a,'rows',varargin{:});
    %     for icol=1:ncolkey
    %         [lia(:,icol),locb(:,icol)] = ismember(key{icol}, keySetInTable{icol},'rows',varargin{:});
    %     end
    if iscellstr(keySetInTable)
        key = makeitcellstr(key);
        key = string(key);
        keySetInTable = string(keySetInTable);
    end
    [lia,locb] = ismember(key, keySetInTable,'rows',varargin{:});
    % show the keys missed in the table B
else % only one key
    keyVariableInTable = makeitnotcell(keyVariableInTable);
    keySetInTable = Table.(keyVariableInTable);
    [lia,locb] = ismember(key, keySetInTable,varargin{:});
end

if any(~lia)
    cprintf('error','the following %g keys are in Table A, but missed in the Table B''s key\n',sum(~lia));
    disp(key(~lia,:));
    
end
if nargout>=3
    TinAnotB = key(~lia,:);
end

if nargout==4
idInTableBnotinTableA =  setdiff(1:height(Table),locb);
nobsInTableBnotinTableA = numel(idInTableBnotinTableA);
if nobsInTableBnotinTableA>0
%     cprintf('error','the following %g keys are in Table B, but not in the Table A''s key\n',nobsInTableBnotinTableA);
%     disp(Table(idInTableBnotinTableA,:));
    TinBnotA = Table(idInTableBnotinTableA,:);
end
end



nkey = numel(lia);

if ncol>1
    value = cell(ncol,1);
    
    for icol = 1:ncol
        ValueSetInTable = Table.(ValueVariableInTable{icol});
        switch class(ValueSetInTable)
            case {'string'}
                value{icol} = string(repmat(missing,[nkey,1]));
            case {'cell'}
                value{icol} = cell(nkey,1);
            case {'double'}
                value{icol} = NaN(nkey,1);
            otherwise
                error('the value to be queried should be double or string/cell')
        end
        value{icol}(lia) = ValueSetInTable(locb(lia),:);
        
    end
    return;
else % if ncol==1
    ValueVariableInTable = makeitchar(ValueVariableInTable);
    ValueSetInTable = Table.(ValueVariableInTable);
    value = createEmptyArray(ValueSetInTable,nkey,1);
    value(lia) = ValueSetInTable(locb(lia),:);
    value = value(:);
    return;
    
end


% value(~lia) = 
end