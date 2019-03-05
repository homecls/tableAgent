function TAgent = readtableAgentRaw(filename,varargin)
%  TAgent = readtableAgentRaw(filename,varargin)
    T = readtable(filename,'ReadVariableNames',false,varargin{:});
%     T = readtable(filename,'ReadVariableNames',false,varargin{:});
    TAgent = tableAgent(T);
end
