function tfschar = isemptycell(A)
% tfschar = ischarcell(A)
tfschar = cellfun(@isempty, A);
end