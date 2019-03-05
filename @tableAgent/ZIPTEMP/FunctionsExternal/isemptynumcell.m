function tfNaN = isemptynumcell(A)
tfNaN = cellfun(@(x) ( isnumeric(x) && isempty(x)), A);
end