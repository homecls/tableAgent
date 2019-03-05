function Tsum = summarizeDatetime(x)

% x = double(x); % to prevent errors with logical inputs
% numberOfVariables=size(x,2);

[n,m] = size(x);
if n==1 && m>1, x = x'; elseif n==1 && m==1, error('summarize:ScalarInput','SUMMARIZE requires matrix inputs.'), end

% pre-allocate statistics matrix
Ns      = NaN(m,1);
Nobs      = NaN(m,1);
Nnans     = NaN(m,1);
% strEmp = repmat({''},m,1);
means   = NaN(m,1);
medians = NaN(m,1);
stdevs  = NaN(m,1);
vars    = NaN(m,1);
maxes   = NaN(m,1);
mins    = NaN(m,1);
p1      = NaN(m,1);
p5      = NaN(m,1);
p10     = NaN(m,1);
p25     = NaN(m,1);
p50     = NaN(m,1);
p75     = NaN(m,1);
p90     = NaN(m,1);
p95     = NaN(m,1);
p99     = NaN(m,1);
skew    = NaN(m,1);
kurt    = NaN(m,1);
min1    = NaN(m,1);
min2    = NaN(m,1);
min3    = NaN(m,1);
min4    = NaN(m,1);
min5    = NaN(m,1);
max1    = NaN(m,1);
max2    = NaN(m,1);
max3    = NaN(m,1);
max4    = NaN(m,1);
max5    = NaN(m,1);

% calculate statistics
% first do unweighted calculations
	for j=1:m
        idsempty = isnat(x(:,j));
        if all(idsempty)
            Ns(j)      = numel(x(:,j));
            Nobs(j)     = 0;
            Nnans(j)     = Ns(j);
        else
            Ns(j)      = numel(x(:,j));
            Nobs(j)     = sum(~idsempty);
            Nnans(j)     = sum(idsempty);
%             means(j)   = nanmean(x(:,j));
            medians(j) = date2num(nanmedian(datenum(x(:,j))));
%             stdevs(j)  = nanstd(x(:,j));
%             vars(j)    = nanvar(x(:,j));
            maxes(j)   = date2num(nanmax(datenum(x(:,j))));
            mins(j)    = date2num(nanmin(datenum(x(:,j))));
%             p1(j)      = prctile(x(:,j),1);
%             p5(j)      = prctile(x(:,j),5);
%             p10(j)     = prctile(x(:,j),10);
%             p25(j)     = prctile(x(:,j),25);
%             p50(j)     = prctile(x(:,j),50);
%             p75(j)     = prctile(x(:,j),75);
%             p90(j)     = prctile(x(:,j),90);
%             p95(j)     = prctile(x(:,j),95);
%             p99(j)     = prctile(x(:,j),99);
%             skew(j)    = skewness(x(:,j));
%             kurt(j)    = kurtosis(x(:,j));
%             sortyupj   = sort(x(~isnan(x(:,j)),j));
% 			if size(x(~isnan(x(:,j)),j),1)<5
% % 				disp('Variable has less than 5 valid observations');
% 				min1(j)    = mins(j);
% 				min2(j)    = mins(j);
% 				min3(j)    = mins(j);
% 				min4(j)    = mins(j);
% 				min5(j)    = mins(j);
% 				max1(j)    = maxes(j);
% 				max2(j)    = maxes(j);
% 				max3(j)    = maxes(j);
% 				max4(j)    = maxes(j);
% 				max5(j)    = maxes(j);
% 			else
% 				min1(j)    = sortyupj(1);
% 				min2(j)    = sortyupj(2);
% 				min3(j)    = sortyupj(3);
% 				min4(j)    = sortyupj(4);
% 				min5(j)    = sortyupj(5);
% 				max1(j)    = sortyupj(end);
% 				max2(j)    = sortyupj(end-1);
% 				max3(j)    = sortyupj(end-2);
% 				max4(j)    = sortyupj(end-3);
% 				max5(j)    = sortyupj(end-4);
% 			end
        end
    end
    
Tsum = table(Ns,Nobs,Nnans,means ,medians,stdevs,vars,maxes,mins);
end