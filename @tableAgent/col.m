% OBJECTIVE: Calculate #####
function obj = col(obj,strcol)
% obj = fn(obj,strcol)
%
%% INPUT
% obj =
% strcol =
%% OUTPUT
% obj =
%
%% REQUIRMENT
%
%
%% EXMAPLE
%
%
%% SEE ALSO
%
%
%% AUTHOR: linrenwen@gmail.com
%% VERSION: v1.0 2019/02/21


%% Part 1, Data
narginchk(1,2)
if nargin == 1
    % for example select all cols
    obj.colselected = 1:width(obj.table);
return;
end

obj.colselected = colstr2coldouble(obj, strcol);

end


