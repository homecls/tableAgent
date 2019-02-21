function obj = subsref(obj,S)
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
                    obj = feval(S(1).subs, obj, S(2).subs{:});
                    S = shiftS(S,1);
                else
                    obj = feval(S(1).subs, obj);
                end
            case fieldnames(obj.table)
                obj = obj.table.(S(1).subs);
            case methods(obj.table)
                if areParensNext(S)
                    obj = feval(S(1).subs, obj.table, S(2).subs{:});
                    S = shiftS(S,1);
                else
                    obj = feval(S(1).subs, obj.table);
                end
            otherwise
                error(['@section.subsref: unknown field or method: ' S(1).subs]);
        end
    case '()'
        obj = obj.table(S(1).subs{:});
    case '{}'
        obj = obj.table{S(1).subs{:}};
    otherwise
        error('@section.subsref: impossible case')
end

S = shiftS(S,1);
if length(S) >= 1
    obj = subsref(obj, S);
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
