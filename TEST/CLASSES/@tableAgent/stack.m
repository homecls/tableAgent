function [obj,iu] = stack(obj,vars, varargin)
% S = stack(obj,vars,Name,Value);
% S = stack(obj,vars,Name,Value);
% S = stack(obj,vars,Name,Value);
[S,iu] = stack(obj.table,vars,varargin{:});
obj.table = S;
end