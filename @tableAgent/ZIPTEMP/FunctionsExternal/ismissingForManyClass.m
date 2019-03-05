function tfmissing = ismissingForManyClass(data)

switch lower(class(data))
    case {'string'}
        tfmissing = ismissing(data);
    case {'double'}
        tfmissing = isnan(data);
    case {'char'}
        tfmissing = isemptyl(data);
    case {'cell'}
        if iscellstr(data)
        tfmissing = isemptycell(data);
        elseif iscellnum(data)
            tfmissing = isemptynumcell(data);
        else
            error('The input is cell and contains both num and char ')
        end
    otherwise
        
      error('some thing is wrong')
end % switch
    
    
end % function