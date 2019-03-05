function B = strcatrobust(varargin)
%   B = strcatrobust(varargin)
%   B = strcatrobust(1, {'a' 'b'},[2 , 3], 't')
%   B = {'1a2t'    '1b3t'};
for ii = 1:nargin
    a = varargin{ii};
    if iscellstr(a)
        
    elseif ischar(a)
        varargin{ii} = cellstr(a);
    elseif iscell(a)
        tfs = isnumericcell(a);
        a(tfs) = cellfun(@num2str, a(tfs),'uniformoutput',0);
        varargin{ii} = a;
    elseif isnumeric(a)
        varargin{ii} = num2cellstr(varargin{ii});
    end
end
B = {''};
for ii = 1:nargin
    B = strcat(B, varargin{ii});
end

if iscell(B) && numel(B) == 1
    B = B{1};
end
% B = '';
% for ii = 1:nargin
% %     B = strcat(B, varargin{ii});
%     B = [B, varargin{ii}{1}];
% end

end