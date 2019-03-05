function [TM, Tmerge] = mergeTables(varargin)
% [TC, Tmerge] = mergeTables(TAs,key,varargin)
% [TC, Tmerge] = mergeTables(TA,TB,TC,...,key,varargin)
% Author: linrenwen@gmail.com
% 2019-3-2 21:36:32

x0 = varargin{1};
ISTableAgentMerge = false;
if iscell(x0) && istable(x0{1}) % case (TAs,key,varargin)
    TAs = x0;
    key = varargin{2};
    arginRemind = varargin(3:end);
elseif iscell(x0) && istableAgent(x0{1})
    TAs = x0;
    [TAs,ISTableAgentMerge] = makethecellTable(TAs);
    key = varargin{2};
    arginRemind = varargin(3:end);
    
else %  (TA,TB,TC,...,key,varargin)
    % find the key and other argins
    for ii =1: nargin
        x = varargin{ii};
        if ischar(x) || iscell(x) 
            key = varargin{ii};
            locKey = ii;
            arginRemind = varargin(ii+1:end);
            break;
        else
            
        end
    end
    % get the tables
    TAs = cell(locKey-1,1);
    for ii=1:(locKey-1)
        TAs{ii} = varargin{ii};
    end
    [TAs,ISTableAgentMerge] = makethecellTable(TAs);  
end

% merge
TC = TAs{1};
for ii=1:numel(TAs)-1
    [TC, Tmerge] = outerjoinSmart(TC,TAs{ii+1},key,arginRemind{:});
end

if ISTableAgentMerge
    TM = tableAgent(TC);
else
    TM = TC;
end

end
%% Appendix
function [TBs,ISTableAgentMerge] = makethecellTable(TAs)
% transfer the tableAgent cell to table cell

    ISTableAgentMerge = false;
    nMember = numel(TAs);
    TBs = cell(nMember,1);
    for imember = 1:nMember
        if istableAgent(TAs{imember})
            TBs{imember} = TAs{imember}.table;
            ISTableAgentMerge = true;
        elseif istable(TAs{imember})
            TBs{imember} = TAs{imember}.table;
        end
    end
end