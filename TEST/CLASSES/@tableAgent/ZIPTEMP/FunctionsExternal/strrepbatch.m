function A = strrepbatch(A, yx)
% A = strrepbatch(A, yx)
if isstring(yx)
yx = cellstr(yx);
end
[m, n] = size(yx);
for ii = 1:m
    for jj = 2:n
        if ischar(yx{ii, jj})
        A = strrep(A, yx{ii, jj}, yx{ii, 1});
        end
    end
end


return;


end