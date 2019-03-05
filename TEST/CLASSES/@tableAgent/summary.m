function Tsummary = summary(obj, colstr, rowstr, colsofsummary)
% T.summary('grade,G',[1:3],'vName,Nobs,Nnans,means,stdevs, maxes,mins');
% {'vName','vDES','vUnit','vType','Ns','Nobs','Nnans','means','medians','stdevs','vars','maxes','mins'}
switch nargin
    case {1}
        Tsummary = summarytable(obj.table);
        Tsummary = tableAgent(Tsummary);
        colsofsummary = 'vName,vType,Nobs,Nnans,means,stdevs, maxes,mins';
        colsofsummarydouble = colstr2coldouble(Tsummary,colsofsummary);
        Tsummary = Tsummary.table(:,colsofsummarydouble);
    case {2} % col
        cols = colstr2coldouble(obj, colstr);
        Tsummary = summarytable(obj.table(:,cols));
    case {3} % col row
        rows = rowstr2rowdouble(obj, rowstr);
        cols = colstr2coldouble(obj, colstr);
        Tsummary = summarytable(obj.table(rows,cols));
    case {4}
        
        rows = rowstr2rowdouble(obj, rowstr);
        cols = colstr2coldouble(obj, colstr);
        Tsummary = summarytable(obj.table(rows,cols));
        Tsummary = tableAgent(Tsummary);
        colsofsummarydouble = colstr2coldouble(Tsummary,colsofsummary);
        % Tsummary = Tsummary(:,(colsofsummarydouble)');
        Tsummary = Tsummary.table(:,colsofsummarydouble);
        
    otherwise
        error('# of arg should be <= 3');
end

if istable(Tsummary)
    Tsummary = tableAgent(Tsummary);
end



end
