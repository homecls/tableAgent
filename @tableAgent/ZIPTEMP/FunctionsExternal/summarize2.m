function Tsum = summarize2(x)
%SUMMARIZE calculates descriptive statistics of a variable (or set of
%  variables) in the same manner as Stata's -summarize- command
%
%   RESULT = SUMMARIZE(X) finds summary statistics of X, which can be a
%   column vector or matrix.
%
%   RESULT = SUMMARIZE(X,OPTIONS) calculates summary statistics with the
%   default options replaced by values in the structure OPTIONS, an argument
%   created with the STRUCT function.  See STRUCT for details.  Available
%   options are Names, Weights, and Detail. 
%      'Names' is a string vector of variable names for each column of X
%   (note that it should not be a cell array of variable names); 'Weights'
%   is a vector or matrix of sample weights (fweights in the Stata sense)
%   to compute weighted summary statistics. If a vector is given, all
%   columns of X are weighted by that vector; if a matrix is given, each
%   column of X is weighted by its respective column of the weights matrix.
%   'Detail' is either 'on' or 'off' to indicate whether or not detailed
%   summary statistics should be calculated.
% 
%   Examples
%     Using built-in Matlab dataset 'carbig':
%        load carbig
%        sums = summarize(Acceleration);
% 
%        sums = summarize([Acceleration Cylinders Displacement]);
% 
%        options = struct('Weights',rand(size(Acceleration)));
%        sums = summarize(Acceleration,options);
% 
%        options = struct('Detail','on','Weights',rand(size([Acceleration Cylinders Displacement])));
%        sums = summarize([Acceleration Cylinders Displacement],options);
% 
%        options = struct('Detail','on','Names',strvcat('Acceleration','Cylinders','Displacement'),'Weights',rand(size([Acceleration Cylinders Displacement])));
%        sums = summarize([Acceleration Cylinders Displacement],options);
% 
%   See also MEAN, STRUCT, <a href="http://www.mathworks.com/matlabcentral/fileexchange/29305-descriptive-statistics/">getDescriptiveStatistics</a> (MathWorks File Exchange).
% 
%   User notes
%     Just like Stata, NaN values are automatically dropped and do not 
%     contribute to summmary statistics.
% 
%     When 'Detail' is set to 'off', the following statistics are
%     computed:
%        N       - number of valid observations
%        mean    - sample mean
%        std dev - sample standard deviation
%        min     - sample minimum
%        max     - sample maximum
% 
%     When 'Detail' is set to 'on', the following statistics are
%     additionally computed:
%        1, 5, 10, 25, 50, 75, 90, 95, 99 percentiles
%        smallest and largest 4 observations
%        sum of weights
%        variance - sample variance (2nd moment)
%        skewness - sample skewness (3rd moment)
%        kurtosis - sample kurtosis (4th moment)
%
%     Percentile caclulations may differ between Matlab and Stata, due to
%     differences between Matlab's PRCTILE function and Stata's default 
%     options. For details on the different ways to calculate percentiles,
%     see Sections 3 and 4 of the Stata FAQ <a href="http://www.stata.com/support/faqs/statistics/percentile-ranks-and-plotting-positions/">here</a>.
%
%   Written by Tyler Ransom, Duke University (e-mail: tmr17@duke.edu)

%   $Revision: 1.3.0.0 $  $Date: 2014/08/04 15:25:43 $

% ------------Initialization----------------
% defaultopt = struct( ...
%     'Detail','off', ...  
%     'Weights',[], ...
%     'Names',[] ...
%     );  

% If just 'defaults' passed in, return the default options in X
% if nargin==1 && nargout <= 1
%    x = defaultopt;
%    return
% end

% if nargin < 2, options=[]; end 

% Detect problem structure input
% if nargin == 1
%     if isa(x,'struct')
%         [x,options] = separateOptimStruct(x);
%     else % Single input and non-structure.
% %         error('optim:summarize:InputArg','The input to SUMMARIZE should be either a structure with valid fields or consist of at least two arguments.');
%     end
% end

% if nargin == 0 
%   error('optim:summarize:NotEnoughInputs','SUMMARIZE requires at least one input arguments.')
% end
% 
% % Check for non-double inputs
% if ~isa(x,'double') && ~isa(x,'logical')
%   error('optim:summarize:NonDoubleLogicalInput', ...
%         'SUMMARIZE only accepts inputs of data type double or logical.')
% end

x = double(x); % to prevent errors with logical inputs
numberOfVariables=size(x,2);

[n,m] = size(x);
if n==1 && m>1, x = x'; elseif n==1 && m==1, error('summarize:ScalarInput','SUMMARIZE requires matrix inputs.'), end

% pre-allocate statistics matrix
Ns      = NaN(m,1);
Nobs      = NaN(m,1);
Nnans     = NaN(m,1);
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
        if all(isnan(x(:,j)))
            Ns(j)      = numel(x(:,j));
            Nobs(j)     = 0;
            Nnans(j)     = Ns(j);
        else
            Ns(j)      = numel(x(:,j));
            Nobs(j)     = sum(~isnan(x(:,j)));
            Nnans(j)     = sum(isnan(x(:,j)));
            means(j)   = nanmean(x(:,j));
            medians(j) = nanmedian(x(:,j));
            stdevs(j)  = nanstd(x(:,j));
            vars(j)    = nanvar(x(:,j));
            maxes(j)   = nanmax(x(:,j));
            mins(j)    = nanmin(x(:,j));
            p1(j)      = prctile(x(:,j),1);
            p5(j)      = prctile(x(:,j),5);
            p10(j)     = prctile(x(:,j),10);
            p25(j)     = prctile(x(:,j),25);
            p50(j)     = prctile(x(:,j),50);
            p75(j)     = prctile(x(:,j),75);
            p90(j)     = prctile(x(:,j),90);
            p95(j)     = prctile(x(:,j),95);
            p99(j)     = prctile(x(:,j),99);
            skew(j)    = skewness(x(:,j));
            kurt(j)    = kurtosis(x(:,j));
            sortyupj   = sort(x(~isnan(x(:,j)),j));
			if size(x(~isnan(x(:,j)),j),1)<5
% 				disp('Variable has less than 5 valid observations');
				min1(j)    = mins(j);
				min2(j)    = mins(j);
				min3(j)    = mins(j);
				min4(j)    = mins(j);
				min5(j)    = mins(j);
				max1(j)    = maxes(j);
				max2(j)    = maxes(j);
				max3(j)    = maxes(j);
				max4(j)    = maxes(j);
				max5(j)    = maxes(j);
			else
				min1(j)    = sortyupj(1);
				min2(j)    = sortyupj(2);
				min3(j)    = sortyupj(3);
				min4(j)    = sortyupj(4);
				min5(j)    = sortyupj(5);
				max1(j)    = sortyupj(end);
				max2(j)    = sortyupj(end-1);
				max3(j)    = sortyupj(end-2);
				max4(j)    = sortyupj(end-3);
				max5(j)    = sortyupj(end-4);
			end
        end
    end
    
Tsum = table(Ns,Nobs,Nnans,means ,medians,stdevs,vars,maxes,mins);
%     if isempty(optimget(options,'Names',defaultopt,'fast'));
%         if strcmp(optimget(options,'Detail',defaultopt,'fast'),'off')==1;
%             result = [Ns means stdevs mins maxes];
%             fprintf('\n %9s %13s %13s %13s %13s','N','mean','std dev','min','max');
%             fprintf('\n ----------------------------------------------------------------\n');
%             for j=1:m
%                 if all(isnan(x(:,j)))
%                     fprintf('%9d \n',Ns(j));
%                 else
%                     fprintf('%9d %13.4f %13.4f %13.4f %13.4f \n',Ns(j),means(j),stdevs(j),mins(j),maxes(j));
%                 end
%             end
%         elseif strcmp(optimget(options,'Detail',defaultopt,'fast'),'on')==1;
%             result = [Ns means stdevs mins maxes medians p1 p5 p10 p25 p50 p75 p90 p95 p99];
%             for j=1:m
%                 fprintf('\n ----------------------------------------------------- \n');
%                 if all(isnan(x(:,j)))
%                     fprintf('%15s \n','No observations');
%                 else
%                     fprintf('%13s \t %13s \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13d \n %2d%% %13.2f %13.2f %13s %13.4f \n \n %2d%% %13.2f \t \t \t \t %13s %13.4f \n   \t \t \t \t %13s \t %13s %13.4f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13.4e \n %2d%% %13.2f %13.2f %13s %13.6f \n %2d%% %13.2f %13.2f %13s %13.6f \n','Percentiles','Smallest',1,p1(j),min1(j),5,p5(j),min2(j),10,p10(j),min3(j),'Obs',Ns(j),25,p25(j),min4(j),'Sum of Wgt',Nws(j),50,p50(j),'Mean',means(j),'Largest','Std. Dev.',stdevs(j),75,p75(j),max4(j),90,p90(j),max3(j),'Variance',vars(j),95,p95(j),max2(j),'Skewness',skew(j),99,p99(j),max1(j),'Kurtosis',kurt(j));
%                 end
%             end
%         end
%     elseif ~isempty(optimget(options,'Names',defaultopt,'fast'));
%         if strcmp(optimget(options,'Detail',defaultopt,'fast'),'off')==1;
%             result = [Ns means stdevs mins maxes];
%             fprintf('\n %13s %9s %13s %13s %13s %13s','Variable','N','mean','std dev','min','max');
%             fprintf('\n ------------------------------------------------------------------------------------\n');
%             for j=1:m
%                 if all(isnan(x(:,j)))
%                     fprintf('%13s %9d \n',options.Names(j,:),Ns(j));
%                 else
%                     fprintf('%13s %9d %13.4f %13.4f %13.4f %13.4f \n',options.Names(j,:),Ns(j),means(j),stdevs(j),mins(j),maxes(j));
%                 end
%             end
%         elseif strcmp(optimget(options,'Detail',defaultopt,'fast'),'on')==1;
%             result = [Ns means stdevs mins maxes medians ];
%             for j=1:m
%                 if all(isnan(x(:,j)))
%                     fprintf('\n \t \t \t %13s',options.Names(j,:));
%                     fprintf('\n ----------------------------------------------------- \n');
%                     fprintf('%15s \n','No observations');
%                 else
%                     fprintf('\n \t \t \t %13s',options.Names(j,:));
%                     fprintf('\n ----------------------------------------------------- \n');
%                     fprintf('%13s \t %13s \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13d \n %2d%% %13.2f %13.2f %13s %13.4f \n \n %2d%% %13.2f \t \t \t \t %13s %13.4f \n   \t \t \t \t %13s \t %13s %13.4f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13.4e \n %2d%% %13.2f %13.2f %13s %13.6f \n %2d%% %13.2f %13.2f %13s %13.6f \n','Percentiles','Smallest',1,p1(j),min1(j),5,p5(j),min2(j),10,p10(j),min3(j),'Obs',Ns(j),25,p25(j),min4(j),'Sum of Wgt',Nws(j),50,p50(j),'Mean',means(j),'Largest','Std. Dev.',stdevs(j),75,p75(j),max4(j),90,p90(j),max3(j),'Variance',vars(j),95,p95(j),max2(j),'Skewness',skew(j),99,p99(j),max1(j),'Kurtosis',kurt(j));
%                 end
%             end
%         end
%     end
%     
% % now do weighted calculations
% elseif ~isempty(optimget(options,'Weights',defaultopt,'fast'));
%     if size(options.Weights,2)>1 && numberOfVariables==1
%         error('weights:summarize:NotEnoughInputs','SUMMARIZE requires a single vector of weights if only a single data vector is specified.');
%     elseif size(options.Weights,2)>1 && numberOfVariables>1 && size(options.Weights,2)~=numberOfVariables
%         error('weights:summarize:TooManyInputs','SUMMARIZE requires either a single weights vector, or a weights matrix the same size as the data matrix.');
%     elseif size(options.Weights,2)==1 && numberOfVariables>1
%         warning('weights:summarize:VectorInput','SUMMARIZE will use the same weights vector for all variables.');
%         options.Weights = repmat(options.Weights,[1 numberOfVariables]);
%     end
%     for j=1:m
%         if all(isnan(x(:,j)))
%             Ns(j)      = 0;
%         else
%             xpj   = options.Weights(~isnan(x(:,j)),j).*x(~isnan(x(:,j)),j);
%             wpj   = options.Weights(~isnan(x(:,j)),j);
%             wpnj  = options.Weights(~isnan(x(:,j)),j)./sum(options.Weights(~isnan(x(:,j)),j));
%             xpnj  = wpnj.*x(~isnan(x(:,j)),j);
%             Ns(j)    = sum(~isnan(x(:,j)));
%             Nws(j)   = sum(wpj.*~isnan(x(:,j)));
%             means(j) = sum(xpj)./sum(wpj);
%             medians(j) = nanmedian(xpnj);
%             stdevs(j) = sqrt(nanvar(x(:,j),options.Weights(:,j)));
%             vars(j)   = nanvar(x(:,j),options.Weights(:,j));
%             maxes(j) = nanmax(x(:,j));
%             mins(j) = nanmin(x(:,j));
%             p1(j)      = prctile(xpnj,1);
%             p5(j)      = prctile(xpnj,5);
%             p10(j)     = prctile(xpnj,10);
%             p25(j)     = prctile(xpnj,25);
%             p50(j)     = prctile(xpnj,50);
%             p75(j)     = prctile(xpnj,75);
%             p90(j)     = prctile(xpnj,90);
%             p95(j)     = prctile(xpnj,95);
%             p99(j)     = prctile(xpnj,99);
%             skew(j)    = skewness(xpnj);
%             kurt(j)    = kurtosis(xpnj);
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
%         end
%     end
%     if isempty(optimget(options,'Names',defaultopt,'fast'));
%         if strcmp(optimget(options,'Detail',defaultopt,'fast'),'off')==1;
%             result = [Ns means stdevs mins maxes];
%             fprintf('\n %9s %13s %13s %13s %13s','N','mean','std dev','min','max');
%             fprintf('\n ----------------------------------------------------------------\n');
%             for j=1:m
%                 if all(isnan(x(:,j)))
%                     fprintf('%9d \n',Ns(j));
%                 else
%                     fprintf('%9d %13.4f %13.4f %13.4f %13.4f \n',Ns(j),means(j),stdevs(j),mins(j),maxes(j));
%                 end
%             end
%         elseif strcmp(optimget(options,'Detail',defaultopt,'fast'),'on')==1;
%             result = [Ns means stdevs mins maxes medians p1 p5 p10 p25 p50 p75 p90 p95 p99];
%             for j=1:m
%                 fprintf('\n ----------------------------------------------------- \n');
%                 if all(isnan(x(:,j)))
%                     fprintf('%15s \n','No observations');
%                 else
%                     fprintf('%13s \t %13s \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13d \n %2d%% %13.2f %13.2f %13s %13.4f \n \n %2d%% %13.2f \t \t \t \t %13s %13.4f \n   \t \t \t \t %13s \t %13s %13.4f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13.4e \n %2d%% %13.2f %13.2f %13s %13.6f \n %2d%% %13.2f %13.2f %13s %13.6f \n','Percentiles','Smallest',1,p1(j),min1(j),5,p5(j),min2(j),10,p10(j),min3(j),'Obs',Ns(j),25,p25(j),min4(j),'Sum of Wgt',Nws(j),50,p50(j),'Mean',means(j),'Largest','Std. Dev.',stdevs(j),75,p75(j),max4(j),90,p90(j),max3(j),'Variance',vars(j),95,p95(j),max2(j),'Skewness',skew(j),99,p99(j),max1(j),'Kurtosis',kurt(j));
%                 end
%             end
%         end
%     elseif ~isempty(optimget(options,'Names',defaultopt,'fast'));
%         if strcmp(optimget(options,'Detail',defaultopt,'fast'),'off')==1;
%             result = [Ns means stdevs mins maxes];
%             fprintf('\n %13s %9s %13s %13s %13s %13s','N','mean','std dev','min','max');
%             fprintf('\n ------------------------------------------------------------------------\n');
%             for j=1:m
%                 if all(isnan(x(:,j)))
%                     fprintf('%13s %9d \n',options.Names(j,:),Ns(j));
%                 else
%                     fprintf('%13s %9d %13.4f %13.4f %13.4f %13.4f \n',options.Names(j,:),Ns(j),means(j),stdevs(j),mins(j),maxes(j));
%                 end
%             end
%         elseif strcmp(optimget(options,'Detail',defaultopt,'fast'),'on')==1;
%             result = [Ns means stdevs mins maxes medians ];
%             for j=1:m
%                 if all(isnan(x(:,j)))
%                     fprintf('\n \t \t \t %13s',options.Names(j,:));
%                     fprintf('\n ----------------------------------------------------- \n');
%                     fprintf('%15s \n','No observations');
%                 else
%                     fprintf('\n \t \t \t %13s',options.Names(j,:));
%                     fprintf('\n ----------------------------------------------------- \n');
%                     fprintf('%13s \t %13s \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13d \n %2d%% %13.2f %13.2f %13s %13.4f \n \n %2d%% %13.2f \t \t \t \t %13s %13.4f \n   \t \t \t \t %13s \t %13s %13.4f \n %2d%% %13.2f %13.2f \n %2d%% %13.2f %13.2f %13s %13.4e \n %2d%% %13.2f %13.2f %13s %13.6f \n %2d%% %13.2f %13.2f %13s %13.6f \n','Percentiles','Smallest',1,p1(j),min1(j),5,p5(j),min2(j),10,p10(j),min3(j),'Obs',Ns(j),25,p25(j),min4(j),'Sum of Wgt',Nws(j),50,p50(j),'Mean',means(j),'Largest','Std. Dev.',stdevs(j),75,p75(j),max4(j),90,p90(j),max3(j),'Variance',vars(j),95,p95(j),max2(j),'Skewness',skew(j),99,p99(j),max1(j),'Kurtosis',kurt(j));
%                 end
%             end
%         end
%     end    
% end
% 
% {'N','mean','std dev','min','max'}

