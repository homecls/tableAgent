function [obj,Tmerge] = merge(obj,TB,key,varargin)
% [obj,Tmerge] = merge(obj,TB,key,varargin)
% S = stack(obj,vars,Name,Value);
% S = stack(obj,vars,Name,Value);
if isa(TB,'tableAgent')
   TBy = TB.table;
elseif istable(TB)
   TBy = TB;
else
end
[TM, Tmerge] = outerjoinSmart(obj.table,TBy,key,varargin{:});
obj.table = TM;
end