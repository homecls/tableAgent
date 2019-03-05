function A = num2cellstr(A,varargin)
%  A = num2cellstr(A)
% A = cellfun(@num2str,num2cell(A),'uniformoutput',0);
% idnans = isnan(A);
% A(idnans) = [];
if nargin==2
    A = cellfun(@(x)num2str(x,varargin{1}),num2cell(A),'uniformoutput',0);
else
    A = cellfun(@num2str,num2cell(A),'uniformoutput',0);
end
end
