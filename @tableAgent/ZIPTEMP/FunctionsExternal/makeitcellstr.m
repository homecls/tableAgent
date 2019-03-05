function var = makeitcellstr(var)
% var = makeitcellstr(var)
switch lower(class(var))
    case {'string','char'}
        var = cellstr(var);
    case {'double'}
        var = cellstr(string(var));
    case {'cell'}
        if iscellnum(var)
            var = cellnum2cellstr(var);
        
        elseif iscellstr(var)
            
        elseif numel(var{1})>1 && numel(var{1})==numel(var{2})
            ncol = numel(var);
            nobs = numel(var{1});
            varnew = repmat({''},nobs,ncol);
            for icol = 1:ncol
               varnew(:,icol) = cellstr(string(var{icol}));
            end
            var = varnew;
        else
            
            error('input should be string or char array, cellnum,cellstr')
        end
    otherwise
        error('input should be string or char array, cellnum,cellstr')
end
end