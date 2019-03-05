% OBJECTIVE: Calculate #####
function val = missingData(data,M,N)
    % val = fn(dataClass,M,N)
    %
    %% INPUT
    % data = datatype
    % M,N = 
    %% OUTPUT
    % val = 
    %
    %% REQUIRMENT
    % 
    % 
    %% EXMAPLE
    % 
    % 
    %% SEE ALSO
    %
    % 
    %% AUTHOR: linrenwen@gmail.com
    %% VERSION: v1.0 2019/02/23

    switch nargin
    case {1}
        [M,N] = size(data);
        
    case {2}
        error('# of arg should be 1, 3 %s','');
        
    case {3}
        
    otherwise
        error('# of arg should be <= 3! %s','');
    end
    
    dClass = class(data);
    switch dClass
    case {'char'}
        val = repmat('',M,N);

    case {'cell'}
        if iscellstr(data)
            val = repmat({''},M,N);

        elseif iscellnum(data)
            val = repmat({NaN},M,N);
        else
            error('for cell type: only cellnum and cellstr are supportec')
        end
    case {'string'}
        val = repmat(string(missing),M,N);
        
        
    case {'double'}
        val = NaN(M,N);

    case {'datetime'}
        val = NaT(M,N);

        
    otherwise
        error('only support double, cell, string, char, and others %s','');
    end

    
    %% Part 1, Data
    
    
    %% Part 2, Calculation
    
    
    %% Part 3, Output of result
    
    
    %% Part 4, Demo of result
    
    
end
