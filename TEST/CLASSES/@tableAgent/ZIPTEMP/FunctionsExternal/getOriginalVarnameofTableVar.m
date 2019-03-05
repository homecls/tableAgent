function [varnameOriginal,TvENCN,TvCNEN] = getOriginalVarnameofTableVar(T)
%% 1 get original variables name list
vname = T.Properties.VariableDescriptions;
% Ta.Properties.VariableNames
vname0 = regexp(vname,'.*''(.*)''$','tokens');
% vname1 = [vname0{:}]';
% varnameOriginal = [vname1{:}]';
varnameOriginal = squeezecellstr(vname0);
idnotrenamebymatlab = isemptycell(vname);
varnameOriginal(idnotrenamebymatlab)=T.Properties.VariableNames(idnotrenamebymatlab);

%% 2. create the Table of variable vCN£¬vEN mapping
vEN = T.Properties.VariableNames;
vCN = varnameOriginal;
if isempty(vCN)
   vCN = vEN;
   cprintf('error','No vCN is DES of Table cols\n');
end
if nargout > 1
    TvENCN = table(vEN(:),vCN(:),'variablenames',{'vEN','vCN',});
    TvENCN.Properties.RowNames = TvENCN.vEN;
    
    if nargout ==3
        TvCNEN = table(vCN(:),vEN(:),'variablenames',{'vCN','vEN'});
        TvCNEN.Properties.RowNames = TvCNEN.vCN;
    end

end


end
