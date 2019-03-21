function TColnameColdouble = getColnameColdouble(TA)
  vnames = (TA.Properties.VariableNames)';
  TColnameColdouble = table;
  ncol = width(TA);
  No = (1:ncol)';
  TColnameColdouble.No = [No;No;ncol];
  TColnameColdouble.Row = [vnames;num2cellstr(No);{'end'}];
  
end