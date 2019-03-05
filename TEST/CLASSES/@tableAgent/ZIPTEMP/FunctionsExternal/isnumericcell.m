function tfsnum = isnumericcell(A)
% tfsnum = isnumericcell(A)
% linrenwen@gmail.com
% 2012-6-9 9:49:20
tfsnum = cellfun(@isnumeric, A);
end