function [TabA,lia,TinAnotB,TinBnotA] = queryTabAinTabB(TabA,keyA,valsA,TabB,keyB,valsB,varargin)
% SYNTAX: 
% TabA = queryTabAinTabB(TabA,keyA,valA,TabB,keyB,valB) 
% b = queryTabAinTabB(TGradeOfficial,vkeys,vars,TGrade,vkeys,vars,'left');
% b = queryTabAinTabB(TGradeOfficial,vkeys,vars,TGrade,vkeys,vars,'right');
% 
% Description
% TabA = queryTabAinTabB(TabA,keyA,valA,TabB,keyB,valB) 
% query table A's key in table B and extract the data from table B
% 
% INPUT Arguments:
% varargin{1} = the value to be keeped; default is the right side value.
%
% EXAMPLE: 
% % vars = {'StudentID','StudentName','GradeNormal','GradeFinal','GradeComp'};
% vkeys = {'StudentName'};
% % vkeys = {'StudentName','StudentID'};
% b = queryTabAinTabB(TGradeOfficial,vkeys,vars,TGrade,vkeys,vars,'left');
%
% AUTHOR: linrenwen@gmail.com
%
% SEE ALSO: Grade201909.m

%% P1, query the key in table B
keyA = makeitcell(keyA);
nkeyvar = numel(keyA);
if nkeyvar == 1
    keyA = makeitnotcell(keyA);
    keyAdata = TabA.(keyA);
elseif nkeyvar == 2
    keyAdata = cell(1,2);
    for ikey=1:nkeyvar
        keyAdata{ikey} = TabA.(keyA{ikey});
    end
else
    error('variables of keys in A should be a cellstr')
end
[valueSQueried, lia, TinAnotB,TinBnotA]= query(keyAdata,TabB,keyB,valsB);



%% P2, write the result back into table A
nkey = numel(lia);
valsA = makeitcell(valsA);
valueSQueried = makeitcell(valueSQueried);
ncol = numel(valsA);
idConflictOccur = false(nkey,1);
for icol=1:ncol
    idConflictOccur = false(nkey,1);
    valA = valsA{icol};
    valueQueried = valueSQueried{icol};
    if ismember(valA,TabA.Properties.VariableNames)
        valASet = TabA.(valA);
    else
        switch class(valueQueried)
            case {'cell'}
                idempty = isemptycell(valueQueried);
                vempty = cell(nkey,1);
            case {'string'}
                idempty = isempty(valueQueried);
                vempty = repmat(string(missing),nkey,1);
            case {'double'}
                idempty = isnan(valueQueried);
                vempty = NaN(nkey,1);
            otherwise
                error('the value to be queried in TabA should be double or string/cell')
        end
        if isempty(idempty)
            TabA.(valA) = vempty;
        else
           TabA.(valA) = valueQueried;
           % TabA.(valA)(lia) = valueQueried; 
        end
        continue;
    end
    
    % Check the conflict term between col in A and the result of query
    switch class(valASet)
        case {'cell'}
            idempty = isemptycell(valASet);
        case {'string'}
            idempty = isempty(valASet);
        case {'double'}
            idempty = isnan(valASet);
        otherwise
            error('the value to be queried in TabA should be double or string/cell')
    end
    idConflict =  lia & (~idempty);
    
    
   %% write the queried record from table B back to table A
    % conflict record will be overwrited
    valASetOld = valASet;
    switch class(valASet(lia,:))
        case {'double'}
            valueQueriedCovnerted = makeitdouble(valueQueried(lia,:));
            valASet(lia,:) = valueQueriedCovnerted;
        case {'string'}
            valueQueriedCovnerted = string(valueQueried(lia,:));
            valASet(lia,:) = valueQueriedCovnerted;
        case {'cell'}
            if iscellstr(valASet(lia,:))
                valueQueriedCovnerted = makeitcellstr(valueQueried(lia,:));
            elseif iscellnum(valASet(lia,:))
                error('cellnum is not supported');
            else
                valueQueriedCovnerted = makeitcellstr(valueQueried(lia,:));
            end
            valASet(lia,:) = valueQueriedCovnerted;
        otherwise
            error('');
    end
    % indentify the conflict rows
    if any(idConflict)
        idxa = find(lia);
        valASetConflict = valASetOld(lia,:);
        valueQueriedConflict = valueQueriedCovnerted;
        for iconf = 1:numel(valASetConflict)
            da = valASetConflict(iconf);
            db = valueQueriedConflict(iconf);
            if ~isequal(da, db)
                tfmissingA = ismissingForManyClass(da);
                tfmissingB = ismissingForManyClass(db);
                if ~tfmissingA && ~tfmissingB
                   idConflictOccur(idxa(iconf)) = true; 
                   if nargin == 7
                       keep = varargin{1}; % 'left','right'
                   else
                       keep = 'right';
                   end
                   switch lower(keep)
                       case {'left'}
                           valASet(idxa(iconf),:) = valASetOld(idxa(iconf),:);
                       case {'right'}
                           % no change of valAset is conducted
                       otherwise
                       error('only left or right are supported for argin # 7')
                   end
                   
                elseif tfmissingB && ~tfmissingA
                    valASet(idxa(iconf),:) = valASetOld(idxa(iconf),:);
                elseif tfmissingB && tfmissingA
                     % leave valAset unchanged
                else
                    % leave valAset unchanged
                end
                
            end
        end
    end
    
    
    TabA.(valA) = valASet;
    % TODO: TO SIMPLIFY THE CODE, write the function to merge to array with conflict records and
    % both have empty data;
    if any(idConflictOccur)
        if nkeyvar==1
            TConflict = table(valASet(idConflictOccur,:)...
                , valASetOld(idConflictOccur,:)...
                , valueQueried(idConflictOccur,:)...
                , keyAdata(idConflictOccur,:)...
                ,'VariableNames',{valA,'left','rigth',keyA,});
        else
            TConflict1 = table;
            for icolkey = 1:nkeyvar
               TConflict1.(keyA{icolkey}) = keyAdata{icolkey}(idConflictOccur,:);
            end
            TConflict2 = table(valASet(idConflictOccur,:) ...
             , valASetOld(idConflictOccur,:), valueQueried(idConflictOccur,:)...
             ,'VariableNames',{valA,'left','rigth'});
            TConflict = [TConflict2,TConflict1];
        end
        TConflict.LineNo = find(idConflictOccur);
        cprintf('error','the following %g records are differ betwwen Table B  and Table A!\n', height(TConflict))
        disp(TConflict);
    end
end % for icol

end % function