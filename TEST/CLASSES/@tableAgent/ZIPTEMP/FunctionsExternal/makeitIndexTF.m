function idxTF = makeitIndexTF(data,idx)
% [1,2,4] to [true,true,false,true];
% idxTF = makeitIndexTF(4,[1,3])
% idxTF = makeitIndexTF([1,2,3,4],[1,3])
% idxTF = makeitIndexTF({1,2,3,4},[1,3])

if isnumeric(data) && isscalar(data) && data>1
    m = data;
elseif isnumeric(data) && isvector(data)
    m = numel(data);
else
    [m,n] = size(data);
    if m==1
       m = n; 
    else
    end
end

idxTF = false(m,1);
idxTF(idx) = true;
end