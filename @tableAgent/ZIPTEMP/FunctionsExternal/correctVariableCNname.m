function T = correctVariableCNname(T)
vars = T.Properties.VariableNames;
varsDes = T.Properties.VariableDescriptions;
nv = width(T);
for ii=1:nv
if ~contains(varsDes{ii},'原始列标题:')
    if isempty(varsDes{ii})
        varDESii = vars{ii};
    else
        varDESii = varsDes{ii};
    end
    T.Properties.VariableDescriptions{vars{ii}} = ['原始列标题: ''', varDESii,''''];
end
end