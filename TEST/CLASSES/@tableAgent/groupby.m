function obj = groupby(obj,colstr,coly,fn,colx)
% obj = groupby(obj,colstr,coly,fn,colx)
% 

if nargin==1
    obj.ISGROUPED = false;
    obj.groupvar = '';
   return; 
end

[vG,vGcellstr] = colstr2coldouble(obj,colstr);

T = obj.table;
T = sortrows(T,vG);
GT = T(:,vG);

[G,TID]= findgroups(GT);
obj.groupvar = vGcellstr;
obj.groupno = G;
obj.groupid = TID;
obj.ISGROUPED = true;

if nargin==2
    return;
elseif nargin ==5
    [~,vy] = colstr2coldouble(obj,coly);
    vx = colstr2coldouble(obj,colx);
    T = bygroup(T,vy,fn,vx,vG);
    obj.table = T;
end