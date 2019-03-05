function valueEmpty = createEmptyArray(value,m,n)
switch class(value)
    case {'cell'}
        idempty = isemptycell(value);
        valueEmpty = cell(m,n);
    case {'string'}
        idempty = isempty(value);
        valueEmpty = repmat(string(missing),m,n);
    case {'double'}
        idempty = isnan(value);
        valueEmpty = NaN(m,n);
    otherwise
        error('the value to be queried in TabA should be double or string/cell')
end

end