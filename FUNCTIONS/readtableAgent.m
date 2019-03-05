function TAgent = readtableAgent(varargin)
%  TAgent = readtableAgent(varargin)
    T = readtable(filename,varargin{:} );
    TAgent = tableAgent(T);
end