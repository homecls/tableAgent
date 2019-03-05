function C = joinNumSmart(A,B,varargin)

idnanA = isnan(A);
A(idnanA) = B(idnanA);
if nargin == 2
    C = A;
    return;
end
idnanB = isnan(B);
B(idnanB) = A(idnanB);

flag = 'left';
if nargin == 3
    flag = varargin{1};
    if ~ismember(lower(flag), {'left', 'right', 'full'})
        error('flag arg is wrong! ')
    end
end
switch lower(flag)
    case {'left', 'full'}
        C = A;
    case 'right' 
        C = B;
end

end