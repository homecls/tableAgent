function B = subsasgn(obj, S, V)
% function B = subsasgn(obj, S, V)

% Copyright (C) 2018 linrenwen@gmail.com
%
% This file is part of panelTable.
%

if isempty(obj.label)
    setlabel = {'label canot find '};
else
    %   if iscell()
    if iscell(obj.label)
        labelnames = obj.label;
    else
        labelnames = obj.label.(1);
    end
    setlabel =  setdiff(labelnames,fieldnames(obj.table));      
end

B = obj;
if length(S) > 1
    for i=1:(length(S)-1)
        B = subsref(B, S(i));
    end
    B = subsasgn(B, S(end), V(:));
    B = subsasgn(obj, S(1:(end-1)), B);
    return
end

switch S.type
    case '()'
        % index = S.subs{:};
        % assert(isnumeric(index));
        S = colstr2coldoubleRobust(obj,S);
        B.table(S.subs{:}) = V;
    case '{}'
        S = colstr2coldoubleRobust(obj,S);
        % index = S.subs{:};
        % assert(isnumeric(index));
        B.table{S.subs{:}} = V;
    case '.'
        if iscell(V) || isnumeric(V) || isstring(V)
            if numel(V)>1
                V = V(:);
            end
        end
        switch S.subs
            case fieldnames(obj)
                B.(S.subs) = V;
            case fieldnames(obj.table)
                vnamef = S.subs;
                %B.table.(S.subs) = V;
                if ischar(V)
                   B.table.(vnamef) = repmat({V},obj.height,1);
                elseif isstring(V) && numel(V) == 1
                    B.table.(vnamef) = repmat(V, obj.height, 1);
                elseif iscellstr(V) && numel(V) == 1
                    B.table.(vnamef) = repmat(V, obj.height, 1);
                elseif isnumeric(V) && numel(V) == 1
                    B.table.(vnamef) = repmat(V,obj.height,1);
                else
                    B.table.(vnamef)= V(:) ;
                end
                
            case obj.table.Properties.VariableNames
                B.table.(S.subs) = V;
            case setlabel
                [~,idlabel] = ismember(S(1).subs,labelnames);
                vnames = obj.table.Properties.VariableNames;
                vname = vnames{idlabel};
                
                if ischar(V)
                   B.table.(vname) = repmat({V},obj.height,1);
                elseif isstring(V) && numel(V) == 1
                    B.table.(vname) = repmat(V, obj.height, 1);
                elseif iscellstr(V) && numel(V) == 1
                    B.table.(vname) = repmat(V, obj.height, 1);
                elseif isnumeric(V) && numel(V) == 1
                    B.table.(vname) = repmat(V,obj.height,1);
                else
                    B.table.(vname)= V(:) ;
                end
            otherwise
                B.table.(S.subs) = V(:);    
                % error(['@page.subsasgn: field ' S.subs 'does not exist']);
        end
    otherwise
        error('@page.subsasgn: syntax error');
end
end

function S = colstr2coldoubleRobust(obj,S)
% TB{:,'地区,所属市'} = {''}
if numel(S(1).subs)==2
    % case TB{:,'地区,所属市'}
    colsdouble = colstr2coldouble(obj,S(1).subs{2});
    if colsdouble == 0
        colsdouble = colstrLabel2coldouble(obj,S(1).subs{2});
        
        if colsdouble == 0
            colsdouble = S(1).subs{2};
        end

    end
    
    S(1).subs{2} = colsdouble;
end

end