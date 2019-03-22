function TmapUnique = getcolnamecollabelcoldouble(TAgent)
if ~istableAgent(TAgent)
    error('inputshould be tableAgent class')
end
TcolNameDouble = getColnameColdouble(TAgent.table);
TcolNameDouble.Name = TcolNameDouble.Row;

% TmapLabel
TcolNameLabel = TAgent.TcolLabel2colName;
coldouble = TcolNameDouble{TcolNameLabel.Name,1};
TcolNameLabel.No = coldouble;
TD = TcolNameLabel(:,{'Label','No'});
TD.Properties.VariableNames({'Label'})={'Name'};
TD.Row = [];

TU = TcolNameDouble;
TU.Row = [];
% TUp.Row = [];
% 
% TD = TcolNameLabel(:,{'Label','No'});
% TD.Properties.VariableNames({'Label'})={'Name'};
% TD.Row = [];
Tmap = [TU; TD];
[~,ia] = unique(Tmap.Name);
if numel(ia)<height(Tmap)
    cprintf('error','the following label are not unique\n');
    iaNot = setdiff(1:height(Tmap),ia);
    disp(Tmap.Name(iaNot))
end
TmapUnique = Tmap(ia,:);
TmapUnique.Row = TmapUnique.Name;

end