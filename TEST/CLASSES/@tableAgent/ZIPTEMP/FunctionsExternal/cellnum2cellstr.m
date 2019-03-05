function cellA = cellnum2cellstr(cellA,num2strdigit)
[m,n] = size(cellA);
for ii=1:m
    for jj = 1:n
        if isnumeric(cellA{ii,jj})
            if nargin == 2
                cellA{ii,jj} = num2str(cellA{ii,jj},num2strdigit);
            else
                cellA{ii,jj} = num2str(cellA{ii,jj});
            end
        end;
        
    end
end

end