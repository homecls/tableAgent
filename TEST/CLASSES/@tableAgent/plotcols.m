% OBJECTIVE: plot cols of tableAgent
function [obj,h_plot] = plotcols(obj, colsxy, varargin)
% obj = fn(obj,cols)
%
%% INPUT
% obj = 
% cols = 
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
%% VERSION: v1.0 2019/03/05


%% Part 1, Data


%% Part 2, Calculation


%% Part 3, Output of result


%% Part 4, Demo of result
if obj.ISGROUPED
    vG = varargin{1};
    h_plot = drawTableBygroup(T, colxy, vG, varargin{2:end});
else
    [colsxy,colsxyStr] = colstr2coldouble(obj,colsxy);
    if any(colsxy==0)
            error('cols "%s" are not found!',strjoin(colsxyStr(colsxy==0),'; '));
    end
    T = obj.table(:,colsxy); % fixme: obj(:,colsxy) dont work here?
    h_plot = drawTable(T,varargin);
end



end
