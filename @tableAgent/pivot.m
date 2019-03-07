function [obj,objUnstack] = pivot(obj,colAandB,colVal,fn)
% TB = T.pivot({'Name', 'Letter'}, 'ColValue', @sum)
% https://www.mathworks.com/matlabcentral/fileexchange/59021-mjeppesen-matlab-pivot-table
[~,colAandB] = colstr2coldouble(obj,colAandB);
obj.table = pivot_table(obj.table,colAandB,colVal,fn);
objUnstack = obj;
vnames = obj.table.Properties.VariableNames;
if islogical(obj.table.(vnames{2}))
    objUnstack.table.(vnames{2}) = cellstr((string(vnames{2} +"_" + objUnstack.table.(vnames{2}))));
end
objUnstack.table= unstack(objUnstack.table,3,2);
end