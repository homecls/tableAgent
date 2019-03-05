function panelTarget = stackCell(Acell, varargin) 
% BCell = stackCell(Acell, {'colname' 'varname'})
% BCell = stackCell(Acell, {'colname' 'varname'},rows,colsID,colsVal) 
% BCell = stackCell(Acell, varnameCol varnameVal})

% change the data format of timeseries in xls files;
% province 1951 1952
% shanghai  1  2
% beijing   3  4
% TO
% shanghai 1951 1
% beijing 1951  3
% ...
% example:
% % cellinv2 = pagevar2panel(cell2, {'Year' 'Province'  'GFCF'});
[m, n] = size(Acell);
rows = [1:m];
colsID = [1];
colsVal = 2:n;


switch nargin
    case 2
        vars = varargin{1};
        [nameCol, nameVal] = deal(vars{:});
    case 4
        % stackCell(Acell, varnames,rows,colsID,colsVal) 
    case 3
        nameCol = varargin{2};
        nameVal = varargin{3};
    case 5
        vars = varargin{1};
        [nameCol, nameVal] = deal(vars{:});
        rows = varargin{2};
        
        colsID = varargin{3};
        colsVal = varargin{4};
        if islogical(rows)
            rows = find(rows);
        end
        if islogical(colsID)
            colsID = find(colsID);
        end
        if islogical(colsVal)
            colsVal = find(colsVal);
        end
    otherwise
        disp('wrong # of input')
           
end

if ~(numel(vars)==2)|| ~ iscellstr(vars)
    
end

% basic - blocks for repmat
yearOrg = Acell(rows(1), colsVal);
locationOrg = Acell(rows(2:end), colsID);
bodyOrg = Acell(rows(2:end), colsVal);
nameIDs = Acell(rows(1), colsID);

[nLocation, nYear] = size(bodyOrg) ;
nObs = nLocation * nYear;

% repmat the basic blocks
locationTarget = repmat(locationOrg, nYear, 1); 
yearTarget = reshape(repmat(yearOrg, nLocation, 1), nObs, 1);
bodyTarget = reshape(bodyOrg, nObs, 1);

% put togethor the procesed blocks 
a = [nameIDs, {nameCol, nameVal}];
b = [locationTarget, (yearTarget), (bodyTarget)];

panelTarget = [a; b];

end