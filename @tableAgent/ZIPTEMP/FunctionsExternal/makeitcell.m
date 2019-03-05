function c = makeitcell(data)
% transit any data type to str
if ~iscell(data)
    c = {data};
else 
    c = data;
end

end