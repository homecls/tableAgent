function T = bygroup(T,vy,fn,vx,vG)
% bygroupSimple
% T = bygroup(T,vy,fn,vx,vG)
% EXAMPLE 1:
% T2 = bygroupSimple(T,...
%     {'HA','HB'},@(x1,x2)([x1+x2,x2]),{'HousePrice7','HousePrice7'},'city');
% EXAMPLE 2:
% fn = @(x)hpfilterNaN(x,'yearly');
% T = bygroup(T,{'houseprice7Trend','houseprice7Cycle'},fn,{'houseprice7'},'city');


% SEE ALSO: T = bygroupRobust(@fndiff,T,'city');
% vy = makeitcell(vy);
% vx = makeitcell(vx);

T = sortrows(T,vG);

DX = T(:,vx);
GT = T(:,vG);


[G] = findgroups(GT);
narg = nargin(fn);
if narg>1
    xs = cell(narg,1);
    for ii = 1:narg
        xs{ii} = DX{G==1,ii};
    end
    if ~iscell(fn(xs{:}))  % fromf fn(x) to {fn(x)}
        xs = strcatrobust('x',[1:narg]');
        xsstr = strjoin(xs,',');
        fnstr = ['fn = @( ', xsstr, '){fn(', xsstr, ')};'];
        eval(fnstr);
    end
else
    if ~iscell(fn(DX{G==1,:}))  % fromf fn(x) to {fn(x)}
        fn = @(x){fn(x)};
    end
end

ys = splitapply(fn,DX,G);
% repmat
nG = max(G);
for iG = 1:nG
    inGy = numel(ys{iG});
    inG = sum(iG==G);
   if inGy<inG && inGy==1
       ys{iG} = repmat(ys{iG},inG,1);
   else
       warning('no of res < no of input of each group, and cannot be repmat')
   end
end
%% 
y = vertcat(ys{:});
nvy = numel(vy);
for ii=1:nvy
    T.(vy{ii}) = y(:,ii);
end
end