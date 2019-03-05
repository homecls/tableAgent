

function OUT = cell2num(datacell)
% =======================================================================
% Convert a cell array (of numbers) into a double array. If the cell arrqay
% does not include a number returns NaN
% =======================================================================
% OUT = cell2num(datacell)
% -----------------------------------------------------------------------
% INPUTS 
%	- datacell: a (m x n) cell array with numbers
% -----------------------------------------------------------------------
% OUTPUT
%	- OUT: a (m x n) matrix with numbers
% =========================================================================
% Ambrogio Cesa Bianchi, March 2015
% ambrogiocesabianchi@gmail.com
%-------------------------------------------------------------------------

if ~iscell(datacell)
    error('Input has to be a cell array')
end

% Initialize
OUT = zeros(size(datacell));

% Convert
for r=1:size(datacell,1)
    for c=1:size(datacell,2)
        if numel(datacell{r,c}) > 1
            datacell{r,c}
            numel(datacell{r,c})
            error('too many numel')
        elseif isempty(datacell{r,c})
            OUT(r,c)=NaN;
        elseif    isnumeric(datacell{r,c})
            OUT(r,c)=datacell{r,c};
        else
            OUT(r,c)=NaN;
        end
    end  
end

