function fig = main

basePath = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(basePath));

fig = figureNB(8.5,9.25);
figh = fig.Position(4);

% Representative Traces 
WT = load(fullfile('Nav1.5e','20170428c4','inactivation.mat'));
D1 = load(fullfile('Nav1.5e-D1','20180307c1','inactivation.mat'));
D2 = load(fullfile('Nav1.5e-D2','20180316c1','inactivation.mat'));
D3 = load(fullfile('Nav1.5e-D3','20180712c3','inactivation.mat'));
D4 = load(fullfile('Nav1.5e-D4','20190318c3','inactivation.mat'));

clrs = getColours;

ax = axes('Units','centimeters','color',[0.95,0.95,0.95]);
ax.Color = 'none';
ax.Position = [0.15,figh-3.75,4.2,3.5];
set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');

ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [0.35,figh-1.6,3.65,1];
set(gca,'fontsize',7);
set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off')
line([0,1.9],[-30 -30],'color','k','LineWidth',0.75);
plot([0,1.9,1.9,3.65],[-160,-160,-5 -5],'Color','k','LineWidth',0.75);
text((3.65+1.9)/2,15,['-10 mV'],'FontSize',6,'HorizontalAlignment','center','VerticalAlignment','bottom')
text(1.9/2,-10,['-30 mV'],'FontSize',6,'HorizontalAlignment','center','VerticalAlignment','bottom');
text(1.9/2,-170,['-160 mV'],'FontSize',6,'HorizontalAlignment','center','VerticalAlignment','top');
xlim([0,3.65]);
ylim([-200,0])
text(1.9/2,-90,'\vdots','FontSize',10,'HorizontalAlignment', ...
	'center','VerticalAlignment','middle','interpreter','latex','color',zeros(3,1))


ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [0.35,figh-3.55,1.9,1.75];
WT.Current = inactivationleakcorrection(WT.Voltage,WT.Current,WT.Epochs);
X = WT.Current(:,WT.Epochs(4)+31:WT.Epochs(4)+30+9950)';
X(:,3) = [];
plot(1:9950,X,'color',zeros(3,1)); hold on;
mX = max(abs(X(:)));
xlim([1,10000]);
ylim([-1.1,0.2]*mX);
set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');
line([2e3,5e3],[-0.9 -0.9]*mX,'LineWidth',1,'Color',zeros(3,1))
text(3.5e3,-1.05*mX,'30 ms','FontSize',6,'HorizontalAlignment','center','color',zeros(3,1));


ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [2.2,figh-3.55,1.75,1.75];
WT.Current = inactivationleakcorrection(WT.Voltage,WT.Current,WT.Epochs);
X = WT.Current(:,WT.Epochs(5)+31:WT.Epochs(5)+480)';
plot(X,'LineWidth',0.5,'color',clrs(1,:));
mX = max(abs(X(:)));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
fr = 2e3/mX;
plot([250,250,400],[-0.9+fr,-0.9,-0.9]*mX,'LineWidth',1,'Color','k');
text(270,mX*(-0.9+fr/2),['2 nA'],'FontSize',6);
text((250+400)/2,-1.05*mX,'1 ms','FontSize',6,'HorizontalAlignment','center');

ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [4.5,figh-1.85,1.75,1.75];
D1.Current = inactivationleakcorrection(D1.Voltage,D1.Current,D1.Epochs);
X = D1.Current(:,D1.Epochs(5)+31:D1.Epochs(5)+30+400)';
plot(X,'LineWidth',0.5,'color',clrs(2,:));
mX = max(abs(X(:)));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DI-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.1*range(yl);
fr = 2e3/mX;
line([275,275],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(295,mX*(-0.9+fr/2),['2 nA'],'FontSize',6);

ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [6.55,figh-1.85,1.75,1.75];
D2.Current = inactivationleakcorrection(D2.Voltage,D2.Current,D2.Epochs);
X = D2.Current(:,D2.Epochs(5)+31:D2.Epochs(5)+30+400)';
mX = max(abs(X(:)));
plot(X,'LineWidth',0.5,'color',clrs(3,:));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DII-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.1*range(yl);
fr = 2e3/mX;
line([275,275],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(295,mX*(-0.9+fr/2),['2 nA'],'FontSize',6);

ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [4.5,figh-3.55,1.75,1.75];
D3.Current = inactivationleakcorrection(D3.Voltage,D3.Current,D3.Epochs);
X = D3.Current(:,D3.Epochs(5)+31:D3.Epochs(5)+30+400)';
mX = max(abs(X(:)));
plot(X,'LineWidth',0.5,'color',clrs(4,:));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DIII-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.1*range(yl);
fr = 1.5e3/mX;
line([275,275],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(295,mX*(-0.9+fr/2),['1.5 nA'],'FontSize',6);

ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [6.55,figh-3.55,1.75,1.75];
D4.Current = inactivationleakcorrection(D4.Voltage,D4.Current,D4.Epochs);
X = D4.Current(:,D4.Epochs(5)+31:D4.Epochs(5)+30+400)';
X(1:15,:) = 0;
mX = max(abs(X(:)));
plot(X,'LineWidth',0.5,'color',clrs(5,:));
xlim([1,400]);
ylim([-1.1,0.2]*mX);
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
h=title('DIV-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.1*range(yl);
fr = 0.5e3/mX;
line([275,275],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(295,mX*(-0.9+fr/2),['0.5 nA'],'FontSize',6);


ax = axes('units','centimeters','color','none'); hold on;
ax.Position = [1.85,figh-8.35,5.75,4.5];
load(fullfile('Nav1.5e','inactivation_analyzed.mat')); Nav15e = T;
load(fullfile('Nav1.5e-D1','inactivation_analyzed.mat')); Nav15e_D1 = T;
load(fullfile('Nav1.5e-D2','inactivation_analyzed.mat')); Nav15e_D2 = T;
load(fullfile('Nav1.5e-D3','inactivation_analyzed.mat')); Nav15e_D3 = T;
load(fullfile('Nav1.5e-D4','inactivation_analyzed.mat')); Nav15e_D4 = T;


V = cat(2,Nav15e.V_SSI{:})';
G = cat(2,Nav15e.Ipost_SSI{:})'; G = G./G(:,end);
t = linspace(min(V(:)),max(V(:)),1e3)';
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end

eb(1) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(1,:),'MarkerFaceColor',clrs(1,:),'MarkerSize',4); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'k','linewidth',1)

V = cat(2,Nav15e_D1.V_SSI{:})';
G = cat(2,Nav15e_D1.Ipost_SSI{:})'; G = G./G(:,end);
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end
eb(2) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(2,:),'MarkerFaceColor',clrs(2,:),'MarkerSize',4); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(2,:),'linewidth',1)

V = cat(2,Nav15e_D2.V_SSI{:})';
G = cat(2,Nav15e_D2.Ipost_SSI{:})'; G = G./G(:,end);
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end
eb(3) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(3,:),'MarkerFaceColor',clrs(3,:),'MarkerSize',4); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(3,:),'linewidth',1)

V = cat(2,Nav15e_D3.V_SSI{:})';
G = cat(2,Nav15e_D3.Ipost_SSI{:})'; G = G./G(:,end);
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end
eb(4) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(4,:),'MarkerFaceColor',clrs(4,:),'MarkerSize',4); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(4,:),'linewidth',1)

V = cat(2,Nav15e_D4.V_SSI{:})';
G = cat(2,Nav15e_D4.Ipost_SSI{:})'; G = G./G(:,end);
t = linspace(min(V(:)),max(V(:)),1e3)';
for i = 1:size(G,1)
	FT = fitSSIcurve(V(i,:),G(i,:),struct('v50',-100,'k',-10*sign(G(i,end)),'gmax',1/G(i,end)));
	G(i,:) = FT.Gmx-G(i,:);
end

eb(5) = errorbar(mean(V),mean(G),stderror(G),'^', ...
	'Color',clrs(5,:),'MarkerFaceColor',clrs(5,:),'MarkerSize',4); hold on;
FT = fitSSIcurve(V,G,struct('v50',-80,'k',10,'gmax',1));
plot(t,FT(t),'color',clrs(5,:),'linewidth',1)



box off
set(gca,'TickDir','out');
xlabel('Conditioning Pulse Potential (mV)')
ylim([0 1.1]);
xlim([-150 -40]);

set(gca,'FontSize',7)
set(gca,'LineWidth',1);
ylabel('Peak Conductance (Norm.)')
L=legend(eb,{'Nav1.5e','DI-CN','DII-CN','DIII-CN','DIV-CN'},'box','off','FontSize',7,'units','centimeters');
L.Position = [6.2,figh-6.5,1.9,1.7];
L.TextColor = 'k';
L.ItemTokenSize = [20,7];


labelpanel(0.01,0.95,'a');
labelpanel(0.51,0.95,'b');
labelpanel(0.14,0.54,'c');