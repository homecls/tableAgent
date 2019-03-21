function TAgent = readtableAgent(varargin)
%  TAgent = readtableAgent(varargin)
    filename = varargin{1};
    T = readtable(filename,varargin{2:end} );
    TAgent = tableAgent(T);
    
    % adjust the label
    [colLabel,TvENvCN] = getOriginalVarnameofTableVar(T);
    TAgent.label = colLabel;
    
    TcolLabel2colName = TvENvCN;
    TcolLabel2colName.Properties.VariableNames({'vEN','vCN'}) = {'Name','Label'};
    TAgent.TcolLabel2colName = TcolLabel2colName;
end