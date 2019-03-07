function [obj,varargout] = unstack(obj,vars,ivar,varargin)
% [obj,iu] = stack(obj,vars, varargin)
% vars = 'val'
% ivar = 'Year'
% [U,is] = unstack(S,'Price','Stock','AggregationFunction',@mean)
[obj.table,varargout{1:nargout-1}] = unstack(obj.table,vars,ivar,varargin{:});
end