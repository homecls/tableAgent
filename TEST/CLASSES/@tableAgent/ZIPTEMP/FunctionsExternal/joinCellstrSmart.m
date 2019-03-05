function C = joinCellstrSmart(A,B,varargin)
% tfschar = cellfun(@isempty, A);

idnanA = cellfun(@isempty, A);
try 
idnanAm = ismissing(A,{'',' ', '  ','NaN'});
catch
    idnanAm = idnanA;
end
idnanA = idnanA | idnanAm;
if isempty(A(idnanA)) % all elemenets are empty
else
%     try
%         if isempty(A{idnanA})
%         else
A(idnanA) = B(idnanA);
% for ii=1:numel(idnanA)
%    ii
%    if idnanA(ii) ==1
%    A{ii} = B{ii};
%    end
% end
%         end
%     catch
%         error('as ');
%     end
end
if nargin == 2
    C = A;
    return;
end


idnanB = cellfun(@isempty, B);
try
idnanBm = ismissing(B,{'',' ','  ', 'NaN'});
catch
    idnanBm = idnanB;
end
idnanB = idnanB | idnanBm;
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
return
end