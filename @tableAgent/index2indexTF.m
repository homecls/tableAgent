function idxTF = index2indexTF(data,idx)
% [1,2,4] to [true,true,false,true];
[m,~] = size(data);
idxTF = false(m,1);
idxTF(idx) = true;
end