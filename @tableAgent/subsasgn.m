function B = subsasgn(obj, S, V)
% function B = subsasgn(obj, S, V)

% Copyright (C) 2018 linrenwen@gmail.com
%
% This file is part of panelTable.
%

B = obj;
if length(S) > 1
    for i=1:(length(S)-1)
        B = subsref(B, S(i));
    end
    B = subsasgn(B, S(end), V);
    B = subsasgn(obj, S(1:(end-1)), B);
    return
end

switch S.type
    case '()'
        index = S.subs{:};
        % assert(isnumeric(index));
        B.table(S.subs{:}) = V;
    case '{}'
        index = S.subs{:};
        %assert(isnumeric(index));
        B.table{S.subs{:}} = V;
    case '.'
        switch S.subs
            case fieldnames(obj)
                B.(S.subs) = V;
            case fieldnames(obj.table)
                B.table.(S.subs) = V;  
            otherwise
                error(['@page.subsasgn: field ' S.subs 'does not exist']);
        end
    otherwise
        error('@page.subsasgn: syntax error');
end
end