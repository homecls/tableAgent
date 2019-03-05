function cellB = squeezecellstr(cellAs)
% AIM: {{{'a'}},{''}} to {'a', ''};
% cellB = squeezecellstr(cellAs)
% example:
% squeezecellstr({{{{'a'}}},{''}})
% linrenwen@gmail.com
% 2018-1-4 10:31:13
nobs = numel(cellAs);
cellB = cell(nobs,1);
% cellB = cellAs{1}{:};
for ii=1:nobs
    strtmp = [cellAs{ii}{:}];
    while iscell(strtmp)
       strtmp = strtmp{:}; 
    end
    if isempty(strtmp)
        strtmp = '';
    end
    cellB{ii,1} = strtmp;
end

% for ii = 2:numel(cellAs)
%     strtmp = [cellAs{ii}{:}];
%     if isempty(strtmp)
%         strtmp = 'NaN';
%     end
%     cellB = [cellB; strtmp];
% end
end % EOF