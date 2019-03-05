function obj = renamecol(obj,cololdnew)
% T = T.renamecol('Var1,TTT;Var2,UUU')
% T = T.renamecol(["Var1","TTT";"Var2","sss"])
cols = strCommaSemicolon2cellstr(cololdnew);
obj.table.Properties.VariableNames(cols(:,1)) = cols(:,2);
end

