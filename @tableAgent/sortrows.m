function [obj, index] = sortrows(obj,col,varargin)
% [obj, index] = sortrows(obj,col)
col = colstr2coldouble(col);
[obj.table, index]= sortrows(obj.table,col,varargin{:});

end