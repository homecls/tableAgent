function T = cell2tableWithhead(cellA,varargin)
% T = cell2tableWithhead(cellA)
T = cell2table(cellA(2:end,:), varargin{:});
try
    T.Properties.VariableNames = cellA(1,:);
catch
    vCN = matlab.lang.makeUniqueStrings(cellA(1,:));
    vEN = matlab.lang.makeValidName(vCN);
    T.Properties.VariableNames = vEN;
    T = setOriginalVarnameofTableVar(T, vEN, vCN);
    
%     matlab.lang.makeValidName(matlab.lang.makeUniqueStrings({'Äê','Äê','Äê'}))
end
end