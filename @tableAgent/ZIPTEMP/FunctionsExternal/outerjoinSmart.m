function [TC, Tmerge] = outerjoinSmart(TA,TB,key,varargin)
% [TC, Tmerge] = outerjoinSmart(TA,TB,key,varargin)
% Tmerge is the Raw-Result of outerjoin
% TM is the data-cleaned version of TMerge
% 
% Author: linrenwen@gmail.com
% 2019-3-2 21:17:44

key = makeitcell(key);
for ii=1:numel(key)
    if isdatetime(TA.(key{ii}))
        cprintf('red','Datetime-datenum convernsion performed on TA-var %s\n',key{ii});
        TA.(key{ii}) = datenum(TA.(key{ii}));
    end
    if isdatetime(TB.(key{ii}))
        cprintf('red','Datetime-datenum convernsion performed on TB-var %s\n',key{ii});
        TB.(key{ii}) = datenum(TB.(key{ii}));
    end
end
left = TA;
right = TB;

Tmerge =  outerjoin(left,right,'Keys',key,'MergeKeys',1,varargin{:});

headl = left.Properties.VariableNames;
headr = right.Properties.VariableNames;
headm = Tmerge.Properties.VariableNames;
startIndexL = cell2num( regexp(headm,'_left'));
startIndexR = cell2num( regexp(headm,'_right'));
headL = sort(headm(startIndexL>0));
headR = sort(headm(startIndexR>0));

if isempty(headL) && isempty(headR) % case of no confliction obs
    TC = Tmerge;
    return; 
end
[~,~,headLtoken] =regexptokcell(headL, '_left$');
[~,~,headRtoken] =regexptokcell(headR, '_right$');
% [headLtoken, headLremain] = strtok(headL,'_left$');
% [headRtoken, headRremain] = strtok(headR,'_right$');
if isequal(headLtoken, headRtoken)
else
    error('left var name ~= right var name')
end
for ii=1:numel(headL)
    if isnumeric(Tmerge{:,headL{ii}}) % numer
        if isdatetime(Tmerge{:,headR{ii}})
            cprintf('red','Datetime-datenum convernsion performed on var %s\n',headR{ii});
            Tmerge.(headR{ii}) = datenum(Tmerge.(headR{ii}));
        end
        Tmerge{:,headLtoken{ii}} = joinNumSmart(...
            Tmerge{:,headL{ii}}, Tmerge{:,headR{ii}});
    elseif iscategorical(Tmerge{:,headL{ii}}) || iscategorical(Tmerge{:,headR{ii}}) 
        pA = cellstr(Tmerge{:,headL{ii}});
        pB = cellstr(Tmerge{:,headR{ii}});
        Tmerge{:,headLtoken{ii}} = joinCellstrSmart(...
            pA, pB);
    elseif iscellstr(Tmerge{:,headL{ii}}) % cell string
        Tmerge{:,headLtoken{ii}} = joinCellstrSmart(...
            Tmerge{:,headL{ii}}, Tmerge{:,headR{ii}});
    elseif isdatetime(Tmerge{:,headL{ii}}) % numer
        cprintf('red','Datetime-datenum convernsion performed on var %s\n',headL{ii});
        Tmerge.(headL{ii}) = datenum(Tmerge.(headL{ii}));
        if isdatetime(Tmerge{:,headR{ii}})
            cprintf('red','Datetime-datenum convernsion performed on var %s\n',headR{ii});
            Tmerge.(headR{ii}) = datenum(Tmerge.(headR{ii}));
        end
        Tmerge{:,headLtoken{ii}} = joinNumSmart(...
            Tmerge{:,headL{ii}}, Tmerge{:,headR{ii}});
    end
end
TC = Tmerge;
TC(:, [headL headR]) = [];

% reorder the vars in table
varsordered = sort(Tmerge.Properties.VariableNames);
Tmerge = Tmerge(:,varsordered);

% outerjoin Table properties
varA = TA.Properties.VariableNames;
varB = TB.Properties.VariableNames;
varC = TC.Properties.VariableNames;
varAB = union(varA,varB);
varBmA = setdiff(varAB,varA);
nVA = numel(varA);
nVB = numel(varB);
nVAB = numel(varAB);
nVBmA = numel(varBmA);
% for variable in TB butnot TA
for ii=1:nVBmA
    vari = varBmA{ii};
    % Des
    if ~isempty(TB.Properties.VariableDescriptions) && ~isempty(TB.Properties.VariableDescriptions{vari})
        TC.Properties.VariableDescriptions{vari} = TB.Properties.VariableDescriptions{vari};
    end
    % unit
    
%     if ~isempty(TB.Properties.VariableUnits) && ~isempty(TB.Properties.VariableUnits{vari})
%         TC.Properties.VariableUnits{vari} = TB.Properties.VariableUnits{vari};
%     end
end
% for variable in TA
for ii=1:nVA
    vari = varA{ii};
    % Des
    if ~isempty(TA.Properties.VariableDescriptions) && ~isempty(TA.Properties.VariableDescriptions{vari})
        try
        TC.Properties.VariableDescriptions{vari} = TA.Properties.VariableDescriptions{vari};
        catch
            ''
        end
        elseif ~isempty(TB.Properties.VariableDescriptions) && ismember(vari,varB)
        TC.Properties.VariableDescriptions{vari} = TB.Properties.VariableDescriptions{vari};
    end
    % unit
%     if ~isempty(TA.Properties.VariableUnits) && ~isempty(TA.Properties.VariableUnits{vari})
%         TC.Properties.VariableUnits{vari} = TA.Properties.VariableUnits{vari};
%     elseif ismember(vari,varB)
%         TC.Properties.VariableUnits{vari} = TB.Properties.VariableUnits{vari};
%     end
end

end