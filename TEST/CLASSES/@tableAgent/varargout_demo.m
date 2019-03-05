% function varargout_demo
% 
%     function varargout = wrapper( varargin )
%         [varargout{1:nargout}] = someFunction( varargin{:} );
%         
%     end
% 
%     function varargout = size(obj, varargin )
%         [varargout{1:nargout}] = size(obj.table,varargin{:} );
%     end