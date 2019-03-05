function Bdouble = makeitdouble(data)
% transit any data type to str
if iscellstr(data) || isstring(data) || ischar(data)
    Bdouble = str2double(data);
    return;
end
if iscellnum(data)
    Bdouble = cell2mat(data);
return;
end
if isnumeric(data)
    % no conversion is needed£¡
   Bdouble = data;
   return; 
end

error('class not supported')

end