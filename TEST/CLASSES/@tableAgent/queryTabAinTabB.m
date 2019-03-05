function [obj,lia,TinAnotB,TinBnotA] = queryTabAinTabB(obj,keyA,valsA,TB,keyB,valsB,varargin)
%  [obj,lia,TinAnotB,TinBnotA] = queryTabAinTabB(obj,keyA,valsA,TB,keyB,valsB,varargin)
% TA = TA.queryTabAinTabB('colkey1',{'colsNew'},TB, 'colkey1b',{'colsNeed'})
if isa(TB,'tableAgent')
   TBy = TB.table;
elseif istable(TB)
   TBy = TB;
else
end
[obj.table,lia,TinAnotB,TinBnotA] = queryTabAinTabB(obj.table,keyA,valsA,TBy,keyB,valsB,varargin{:});


end