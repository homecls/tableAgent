function varargout = subsref(obj,S)
%SUBSREF Method for panelTable object

%   Author: Lin Renwen
%   Copyright 2018

switch S(1).type
    case '.'
        switch S(1).subs
            case fieldnames(obj)
                obj = obj.(S(1).subs);
            case methods(obj)
                if areParensNext(S)
                    objB = feval(S(1).subs, obj, S(2).subs{:});
                    S = shiftS(S,1);
                else
                    objB = feval(S(1).subs, obj);
                end
                obj = objB;
            case fieldnames(obj.table)
                obj = obj.table.(S(1).subs);
            case methods(obj.table)
                if areParensNext(S)
                    obj = feval(S(1).subs, obj.table, S(2).subs{:});
                    S = shiftS(S,1);
                else
                    obj = feval(S(1).subs, obj.table);
                end
            case setdiff(obj.label,fieldnames(obj.table))
                [~,idlabel] = ismember(S(1).subs,obj.label);
                vnames = obj.table.Properties.VariableNames;
                vname = vnames{idlabel};
                obj = obj.table.(vname);
            otherwise
                error(['@section.subsref: unknown field or method: ' S(1).subs]);
        end
        varargout{1} = obj;
    case '()'
        S = colstr2coldoubleRobust(obj,S); % function defined this function
        obj.table = obj.table(S(1).subs{:});
        varargout{1} = obj.table;
        % S = shiftS(S,1);
    case '{}'
        % Overload the subsref method.
        %         subsrefcheck(obj.table, S);
        S = colstr2coldoubleRobust(obj,S);
        [varargout{1:nargout}] = [builtin('subsref', obj.table, S)];
        S = shiftS(S,1);
%         obj.table{makeitdouble(S(1).subs),makeitdouble(S(2).subs)};
%         obj.table{S(2).subs{:}};
    otherwise
        error('@section.subsref: impossible case')
end

S = shiftS(S,1);
% if numel(S)>=1;
%     struct2table(S)
% end
if length(S) >= 1
    if istable(obj)
        obj0 = tableAgent(obj);
        obj0.table = obj;
        % objx = copy(obj);
    elseif isa(obj,'tableAgent')
%         TempTable = obj.table;
%         obj0 = tableAgent(TempTable);
%         obj0.table = TempTable; 
%         obj0 = copy(obj);
    elseif iscell(obj)
        % FIXME: case T.table.Properties.VariableNames({'Var1'})
        return;
    else
        % struct2table(S)
        error('return of it should be table or tableagent class')
    end
    % struct2table(S)
    obj2 = subsref(obj, S);
    
    varargout{1} = obj2;
end
end
%% appendix
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
% end

%
% if strcmp(s(1).type,'()')
%     obj = struct(obj);
%     obj = obj(s(1).subs{:});
%     obj = fdspec(obj);
%     s(1) = [];
% end
%
% if isempty(s)
%     a = obj;
%     return
% end
%
% switch s(1).type
%     case {'()','{}'}
%         error(message('signal:fdspec:subsref:GUIErr'))
%     case '.'
%
%         if isfield(s(1).subs,obj)
%             % 是否为panelTable的子域，
%             a = obj.(s(1).subs);
%
%         elseif isfield(s(1).subs,obj.table) || ismember(s(1).subs,obj.table.Properties.VariableNames)
%           % 是否为Table的子域， 或者是否为table的列变量
%             a = obj.table.(s(1).subs);
%         else
%             error(message('signal:fdspec:subsref:GUIErr'))
%         end
%
% end
%
% if length(s)>1
%     % subsref into ans
%     a = mysubsref(a,s(2:end));
% end
%
%
% function a = mysubsref(a,s)
%
% for i=1:length(s)
%     switch s(i).type
%     case '()'
%         a = a(s(i).subs{:});
%     case '{}'
%         a = a{s(i).subs{:}};
%     case '.'
%         a = getfield(a,s(i).subs);
%     end
% end
