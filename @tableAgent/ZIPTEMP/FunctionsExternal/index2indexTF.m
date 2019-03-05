function idxTF = index2indexTF(data,idx)
% [1,2,4] to [true,true,false,true];
if isscalar(data)
    m = data;   % height, length as input
else
    [m,~] = size(data);
end
idxTF = false(m,1);
idxTF(idx) = true;
end