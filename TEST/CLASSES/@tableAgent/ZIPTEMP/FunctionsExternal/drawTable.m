function h_plot = drawTable(T1,varargin)
% hf = drawTable(T1)
% T1 is table or timetable

% example
% figure; hold all; drawTable(...
%     ( TI(:,{'GDPexp' 'GDP2000' 'C1952' 'InvGFCFYearlyCN' 'CSalesYearlyCN'})) ...
%  ,{{'.-','MarkerSize', 10},...
%  {'x-','linewidth', 0.8,'MarkerSize', 3,'MarkerFaceColor',[1 1 1]} ,...
%  {'o-','linewidth', 0.8,'MarkerSize', 2.5,'MarkerFaceColor',[1 1 1]},...
%  {'*-','MarkerSize', 4} ...
%  {':','linewidth', 1.5}...
%  {'.--','linewidth', 1.5}} );

% set(groot,'defaultAxesColorOrder',[0 0 0],...
%       'defaultAxesLineStyleOrder','-|--|:')
% set(groot,...
%       'defaultAxesLineStyleOrder','-|-.|:')




if nargin == 2
    linepropSet = varargin{1};
    sgnLineprop = 1;
elseif nargin == 1
    lineprop = {};
    sgnLineprop = 0;
end
if istimetable(T1)
   T1= timetable2table(T1); 
   T1.Time.Format = 'yyyy-MM';
end
vnames0 = T1.Properties.VariableNames;
xname = vnames0(:,1);
vnames = vnames0(:,2:end);
nlines= numel(vnames);
% hp = plot(T1{:,1},T1{:,2:end});
hold all;
for ii=1:nlines
    if sgnLineprop == 1
        if ii <= numel(linepropSet)
            lineprop = linepropSet{ii};
        else
            lineprop = {'.-'};
        end
    end
    
    Tfigi = T1(:,[1, ii+1]);
    Tfigi = rmmissing(Tfigi);
    h_plot(ii) = plot((Tfigi{:,1}),Tfigi{:,2},lineprop{:});
    h_leg(ii) = legend(h_plot(ii),vnames{ii});
    h_leg(ii).ItemHitFcn = @actionLineWidth;
%     h_leg(ii).ItemHitFcn = @actionVisible;
end
legend(h_plot,vnames);
xlabel(xname);
% set(groot,'defaultAxesLineStyleOrder','remove')
% set(groot,'defaultAxesColorOrder','remove')
end