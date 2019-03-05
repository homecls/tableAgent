function [T,TvENCN,TvCNEN] = setOriginalVarnameofTableVar(T,vEN,vCN)
% [T,TvENCN,TvCNEN] = setOriginalVarnameofTableVar(T,vEN,vCN)
% set the vCN
vCNadj = strcat('原始列标题: ''',vCN,'''');
T.Properties.VariableDescriptions(makeitcell(vEN)) = makeitcell(vCNadj);
% get the vCN vEN mapping
T = correctVariableCNname(T);
if nargout>1
[~,TvENCN,TvCNEN] = getOriginalVarnameofTableVar(T);
end
end 
