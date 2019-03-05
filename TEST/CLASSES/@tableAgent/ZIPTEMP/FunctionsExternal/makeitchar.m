function data = makeitchar(data)
% SYNTAX: 
% data = makeitchar(data)
% 
% DES:
% transit any data type to char
% 
% AUTHOR: linrenwen@gmail.com
% 
% VERSION: 2019-1-1 16:32:35
%

switch lower(class(data))
    case {'string'}
        if numel(data)>1
            error('string-inputshould be scalar rather than vector')
        else
            data = char(data);
        end
    case {'char'}
            % donothing
    case {'double'}
        if numel(data)>1
            error('numerical-inputshould be scalar rather than vector')
        else
            data = num2str(data);
        end
    case {'cell'}
        data = makeitnotcell(data);
        data = makeitchar(data);
    otherwise
        error('input should be string or char array, cellnum,cellstr')
end

end