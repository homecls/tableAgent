function cellB = strsplitCell(cellA,demi)
% cellB = strsplitCell(cellA,demi);
tmp1 = strsplit(cellA{1}, demi);
cellB = cell(numel(cellA), numel(tmp1)+5);
nMax = numel(tmp1);
for ii=1:numel(cellA)
    iiC= strsplitlrw(cellA{ii}, demi);
    [m,n] = size(iiC);
    nMax = max(nMax,n);
    cellB(ii,1:n) = iiC;
end
cellB = cellB(:,1:nMax);

end
