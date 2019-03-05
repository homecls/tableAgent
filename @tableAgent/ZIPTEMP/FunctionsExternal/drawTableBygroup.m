function h_plot = drawTableBygroup(T,vxy,vG,varargin)
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

%% dataclean table type
if istimetable(T)
   T= timetable2table(T); 
   T.Time.Format = 'yyyy-MM';
end
vG = makeitnotcell(vG);

%% get the data cell
[G,ID] = findgroups(T.(vG));
nG = numel(ID);
Tfigs = cell(nG,1);
legs = cell(nG,1);
for ii=1:nG
    Tfigs{ii} = T(G==ii,vxy);
    legs{ii} = [ID{ii} vxy{2:end}];
end

%% prepare line style
if nargin == 4
    linepropSet = varargin{1};
    sgnLineprop = 1;
elseif nargin == 3
    lineprop = {};
    sgnLineprop = 0;
end

% vnames0 = T1.Properties.VariableNames;
% xname = vnames0(:,1);
% vnames = vnames0(:,2:end);
% nlines= numel(vnames);
% hp = plot(T1{:,1},T1{:,2:end});
hold all;
for ii=1:nG
    if sgnLineprop == 1
        if ii <= numel(linepropSet)
            lineprop = linepropSet{ii};
        else
            lineprop = {'.-'}; %{'.-'}
        end
    end
    
    Tfigi = Tfigs{ii};
    Tfigi = rmmissing(Tfigi);
    if isempty(Tfigi)
        % continue;
        Tfigi = Tfigs{ii};
    end
    h_plot(ii) = plot((Tfigi{:,1}),Tfigi{:,2},'.-');  %% lineprop{:}
    h_leg(ii) = legend(h_plot(ii),legs{ii});
    h_leg(ii).ItemHitFcn = @actionLineWidth;
%     h_leg(ii).ItemHitFcn = @actionVisible;
end
legend(h_plot,legs);
xlabel(vxy{1});
% set(groot,'defaultAxesLineStyleOrder','remove')
% set(groot,'defaultAxesColorOrder','remove')
end