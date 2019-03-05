function data = makeitnotcell(data)
% transit any data type to str
if iscell(data) && numel(data)==1
    data = data{1};
    data = makeitnotcell(data);
elseif iscell(data) && numel(data)>1
    return;
else
    return;
end
    
    
%     
%     
%     
%     nobs = numel(data);
%     c = cell(nobs,1);
%     for ii=1:nobs
%         dii = data{ii};
%         if iscell(dii) && numel(dii)>1;error('the numel of input should 1, but>1');end
%         while iscell(dii)
%             dii = data{ii};
%             if iscell(dii) && numel(dii)>1;error('the numel of input should 1, but>1');end
%         end
%             c{ii} = dii;
%     end
% elseif iscell(data) && numel(data)==1
%     c = data{1};
% else
%     c = data;
% end