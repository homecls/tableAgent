function TAgent = readtableAgent(varargin)
%  TAgent = readtableAgent(varargin)
    filename = varargin{1};
    T = readtable(filename,varargin{2:end} );
    TAgent = tableAgent(T);
end