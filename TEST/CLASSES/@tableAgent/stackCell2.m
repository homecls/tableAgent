% OBJECTIVE: Calculate #####
function obj = stackCell2(obj,vnameRowColVal,rows,cols)
% obj = fn(obj,vnameRowColVal,rows,cols)
%
%% INPUT
% obj = 
% vnameRowColVal,rows,cols = 
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
%% VERSION: v1.0 2019/03/02


%% Part 1, Data

switch nargin
case {2}
    % obj = fn(obj,vnameRowColVal);

    
case {4}
    Acell = table2cell(obj.table(rows,cols));
    Bcell = stackce(Acell,vnameRowColVal);
    obj.table = cell2table(Bcell);
otherwise
    error('# of arg should be <= 4! %s','');
end

%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result


end
