function [toks, strtail, strhead] = regexptokcell(acell, mystr)
toks = cell(size(acell));
strtail = toks;
strhead = toks;

for ii = 1:numel(acell)
    [toks{ii}, strtail{ii}, strhead{ii}]= regexptok(acell{ii}, mystr);
end

toks2 = [toks{:}];
strtail2 = [strtail{:}];
strhead2 = [strhead{:}];
if iscell(toks{1}) && numel(toks) == numel(toks2)
    toks = toks2;
end;
if iscell(strtail{1}) && numel(strtail) == numel(strtail2)
    strtail = strtail2;
end;
if iscell(strhead{1}) && numel(strhead) == numel(strhead2)
    strhead = strhead2;
end;

end