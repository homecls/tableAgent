function T = correctVariableCNname(T)
vars = T.Properties.VariableNames;
varsDes = T.Properties.VariableDescriptions;
nv = width(T);
for ii=1:nv
if ~contains(varsDes{ii},'ԭʼ�б���:')
    if isempty(varsDes{ii})
        varDESii = vars{ii};
    else
        varDESii = varsDes{ii};
    end
    T.Properties.VariableDescriptions{vars{ii}} = ['ԭʼ�б���: ''', varDESii,''''];
end
end