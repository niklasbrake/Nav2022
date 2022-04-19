function fig = main

basePath = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(basePath));

pt2cm = 0.0352778;

fig = figureNB(8.5,7);

clrs = getColours;

setPanLab = @(x,y,str) labelpanel(x/fig.Position(3),y/fig.Position(4),str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% PANEL A %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = 0.35;
y1 = fig.Position(4)+1.9-3.7;
axw = 1.45;
axh = 1.75;

setPanLab(0.1,fig.Position(4)-0.35,'A');
ax = axes('units','centimeters','Position',[x1,y1,axw,axh]); hold on;
WT = load(fullfile('mH1','20170311c3','inactivation.mat'));
WT.Current = inactivationleakcorrection(WT.Voltage,WT.Current,WT.Epochs);
X = WT.Current(:,WT.Epochs(5)+31:WT.Epochs(5)+480)';
X(1:4,:) = nan;
plot(X,'LineWidth',0.5,'color',clrs(1,:));
mX = max(abs(X(:)));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('Nav1.5','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
fr = 2e3/mX;
plot([250,250,400],[-0.9+fr,-0.9,-0.9]*mX,'LineWidth',1,'Color','k');
% text(270,mX*(-0.9+fr/2),['2 nA'],'FontSize',6);
text(200,-(0.9-fr/2)*mX,['2 nA'],'FontSize',6,'Rotation',90,'HorizontalAlignment','center');
text((250+400)/2,-1.02*mX,'1 ms','FontSize',6,'HorizontalAlignment','center');


ax = axes('units','centimeters','Position',[x1+axw+0.2,y1,axw,axh]); hold on;
D1 = load(fullfile('mH1-D1','20180301c6','inactivation.mat'));
D1.Current = inactivationleakcorrection(D1.Voltage,D1.Current,D1.Epochs);
X = D1.Current(:,D1.Epochs(5)+31:D1.Epochs(5)+30+400)';
X(1:4,:) = nan;
plot(X,'LineWidth',0.5,'color',clrs(2,:));
mX = max(abs(X(:)));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DI-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
fr = 2e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-(0.9-fr/2)*mX,['1 nA'],'FontSize',6,'Rotation',90,'HorizontalAlignment','center');


ax=axes('units','centimeters','Position',[x1+2*(axw+0.2),y1,axw,axh]);
D2 = load(fullfile('mH1-D2','20180711c3','inactivation.mat'));
D2.Current = inactivationleakcorrection(D2.Voltage,D2.Current,D2.Epochs);
X = D2.Current(:,D2.Epochs(5)+31:D2.Epochs(5)+30+400)';
mX = max(abs(X(:)));
X(1:4,:) = nan;
plot(X,'LineWidth',0.5,'color',clrs(3,:));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DII-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
fr = 2e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-(0.9-fr/2)*mX,['2 nA'],'FontSize',6,'Rotation',90,'HorizontalAlignment','center');

ax = axes('units','centimeters','Position',[x1+3*(axw+0.2),y1,axw,axh]); hold on;
D3 = load(fullfile('mH1-D3','20180309c12','inactivation.mat'));
D3.Current = inactivationleakcorrection(D3.Voltage,D3.Current,D3.Epochs);
X = D3.Current(:,D3.Epochs(5):D3.Epochs(5)+430)';
mX = max(abs(X(:)));
X(1:4,:) = nan;
plot(X,'LineWidth',0.5,'color',clrs(4,:));
xlim([1,400]+30);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DIII-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
fr = 2e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-(0.9-fr/2)*mX,['2 nA'],'FontSize',6,'Rotation',90,'HorizontalAlignment','center');



ax = axes('units','centimeters','Position',[x1+4*(axw+0.2),y1,axw,axh]); hold on;
D4 = load(fullfile('mH1-D4','20181022c7','inactivation.mat'));
D4.Current = inactivationleakcorrection(D4.Voltage,D4.Current,D4.Epochs);
X = D4.Current(:,D4.Epochs(5)+15:D4.Epochs(5)+30+400)';
mX = max(abs(X(:)));
X(1:8,:) = nan;
plot(X,'LineWidth',0.5,'color',clrs(5,:));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DIV-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
fr = 1e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-(0.9-fr/2)*mX,['1 nA'],'FontSize',6,'Rotation',90,'HorizontalAlignment','center');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% PANEL B %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setPanLab(0.1,fig.Position(4)+1.8-4.1-pt2cm*8/2,'B');
axes('Units','centimeters','Position',[1.75,fig.Position(4)+1.9-8,6,4],'color','w',...
	'box','off','tickdir','out','FontSize',7,'LineWidth',1); hold on;
xlim([-150,-40]); 	xlabel('Test Pulse Potential (mV)')
ylim([0,1.1]); 		ylabel('Peak Conductance (Norm.)')


load(fullfile('mH1','inactivation_analyzed.mat')); mH1 = T;
load(fullfile('mH1-D1','inactivation_analyzed.mat')); mH1_D1 = T;
load(fullfile('mH1-D2','inactivation_analyzed.mat')); mH1_D2 = T;
load(fullfile('mH1-D3','inactivation_analyzed.mat')); mH1_D3 = T;
load(fullfile('mH1-D4','inactivation_analyzed.mat')); mH1_D4 = T;


V = cat(2,mH1.V_SSI{:})';
G = cat(2,mH1.Ipost_SSI{:})'; G = G./G(:,end);
t = linspace(min(V(:)),max(V(:)),1e3)';
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end

eb(1) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(1,:),'MarkerFaceColor',clrs(1,:),'MarkerSize',5); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'k','linewidth',1)

V = cat(2,mH1_D1.V_SSI{:})';
G = cat(2,mH1_D1.Ipost_SSI{:})'; G = G./G(:,end);
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end
eb(2) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(2,:),'MarkerFaceColor',clrs(2,:),'MarkerSize',5); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(2,:),'linewidth',1)

V = cat(2,mH1_D2.V_SSI{:})';
G = cat(2,mH1_D2.Ipost_SSI{:})'; G = G./G(:,end);
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end
eb(3) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(3,:),'MarkerFaceColor',clrs(3,:),'MarkerSize',5); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(3,:),'linewidth',1)

V = cat(2,mH1_D3.V_SSI{:})';
G = cat(2,mH1_D3.Ipost_SSI{:})'; G = G./G(:,end);
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end
eb(4) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(4,:),'MarkerFaceColor',clrs(4,:),'MarkerSize',5); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(4,:),'linewidth',1)

V = cat(2,mH1_D4.V_SSI{:})';
G = cat(2,mH1_D4.Ipost_SSI{:})'; G = G./G(:,end);
t = linspace(min(V(:)),max(V(:)),1e3)';
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end

eb(5) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(5,:),'MarkerFaceColor',clrs(5,:),'MarkerSize',5); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(5,:),'linewidth',1)


set(gca,'xtick',[-140:20:25])
L = legend(eb,{'Nav1.5','DI-CN','DII-CN','DIII-CN','DIV-CN'},'box','off','FontSize',7, ...
	'TextColor','k','Units','centimeters');
L.Position=[6,3,1.5,1.5];
L.ItemTokenSize = [10,7];

axes('Units','centimeters','Position',[5.8,0.9,2.5,1.8],'color','none');
set(get(gca,'xaxis'),'visible','off')
set(get(gca,'yaxis'),'visible','off')