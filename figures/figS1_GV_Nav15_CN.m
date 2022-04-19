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

setPanLab(0.1,fig.Position(4)-0.35,'a');
axes('units','centimeters','Position',[x1,y1,axw,axh]); hold on;
set(get(gca,'xaxis'),'visible','off');
set(get(gca,'yaxis'),'visible','off');
WT = load(fullfile('mH1','20170311c3','activation.mat'));
	V = mean(WT.Voltage(:,WT.Epochs(4):WT.Epochs(4)+500)');
	WT.Current = activationleakcorrection(WT.Voltage,WT.Current,WT.Epochs);
	X = WT.Current(:,WT.Epochs(4):WT.Epochs(4)+500)';
	[M,I] = max(abs(X));
	sig = sign(X(I+[0:length(I)-1]*501));
	FT = fitGVcurve(V,M.*sig/max(M(:)));
	X = X(:,find(V<FT.ERev-5));
	mX = max(abs(X(:)));
plot(X(:,1:2:end),'LineWidth',0.5,'color',clrs(1,:));
xlim([1,500]);
ylim([-1.1,0.2]*mX);
h=title('Nav1.5','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
line([300,400],[-0.9 -0.9]*mX,'LineWidth',1,'Color','k')
text(300,-mX,'1 ms','FontSize',6);
fr = 2e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-0.9*mX,['2 nA'],'FontSize',6,'Rotation',90);

axes('units','centimeters','Position',[x1+axw+0.2,y1,axw,axh]); hold on;
set(get(gca,'xaxis'),'visible','off');
set(get(gca,'yaxis'),'visible','off');
	D1 = load(fullfile('mH1-D1','20180301c6','activation.mat'));
	V = mean(D1.Voltage(:,D1.Epochs(4):D1.Epochs(4)+750)');
	D1.Current = activationleakcorrection(D1.Voltage,D1.Current,D1.Epochs);
	X = D1.Current(:,D1.Epochs(4):D1.Epochs(4)+750)';
	[M,I] = max(abs(X));
	sig = sign(X(I+[0:length(I)-1]*751));
	FT = fitGVcurve(V,M.*sig/max(M(:)));
	X = X(:,find(V<FT.ERev-5));
	mX = max(abs(X(:)));
plot(X(:,1:2:end),'LineWidth',0.5,'color',clrs(2,:));
xlim([1,750]);
ylim([-1.1,0.2]*mX);
h=title('DI-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
line([500,700],[-0.9 -0.9]*mX,'LineWidth',1,'Color','k')
text(500,-mX,'2 ms','FontSize',6);
fr = 2e3/mX;
line([500,500],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(425,-0.9*mX,['2 nA'],'FontSize',6,'Rotation',90);


axes('units','centimeters','Position',[x1+2*(axw+0.2),y1,axw,axh]); hold on;
set(get(gca,'xaxis'),'visible','off');
set(get(gca,'yaxis'),'visible','off');
	D2 = load(fullfile('mH1-D2','20180711c3','activation.mat'));
	V = mean(D2.Voltage(:,D2.Epochs(4):D2.Epochs(4)+500)');
	D2.Current = activationleakcorrection(D2.Voltage,D2.Current,D2.Epochs);
	X = D2.Current(:,D2.Epochs(4):D2.Epochs(4)+500)';
	[M,I] = max(abs(X));
	sig = sign(X(I+[0:length(I)-1]*501));
	FT = fitGVcurve(V,M.*sig/max(M(:)));
	X = X(:,find(V<FT.ERev-5));
	mX = max(abs(X(:)));
plot(X(:,1:2:end),'LineWidth',0.5,'color',clrs(3,:));
xlim([1,500]);
ylim([-1.1,0.2]*mX);
h=title('DII-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
line([300,400],[-0.9 -0.9]*mX,'LineWidth',1,'Color','k')
text(300,-mX,'1 ms','FontSize',6);
fr = 2e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-0.9*mX,['2 nA'],'FontSize',6,'Rotation',90);

axes('units','centimeters','Position',[x1+3*(axw+0.2),y1,axw,axh]); hold on;
set(get(gca,'xaxis'),'visible','off');
set(get(gca,'yaxis'),'visible','off');
	D3 = load(fullfile('mH1-D3','20180309c12','activation.mat'));
	V = mean(D3.Voltage(:,D3.Epochs(4):D3.Epochs(4)+500)');
	D3.Current = activationleakcorrection(D3.Voltage,D3.Current,D3.Epochs);
	X = D3.Current(:,D3.Epochs(4):D3.Epochs(4)+500)';
	[M,I] = max(abs(X));
	sig = sign(X(I+[0:length(I)-1]*501));
	FT = fitGVcurve(V,M.*sig/max(M(:)));
	X = X(:,find(V<FT.ERev-5));
	mX = max(abs(X(:)));
plot(X(:,1:2:end),'LineWidth',0.5,'color',clrs(4,:));
xlim([1,500]);
ylim([-1.1,0.2]*mX);
h=title('DIII-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
line([300,400],[-0.9 -0.9]*mX,'LineWidth',1,'Color','k')
text(300,-mX,'1 ms','FontSize',6);
fr = 1e3/mX;
line([300,300],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(250,-0.9*mX,['1 nA'],'FontSize',6,'Rotation',90);


axes('units','centimeters','Position',[x1+4*(axw+0.2),y1,axw,axh]); hold on;
set(get(gca,'xaxis'),'visible','off');
set(get(gca,'yaxis'),'visible','off');
	D4 = load(fullfile('mH1-D4','20181022c7','activation.mat'));
	V = mean(D4.Voltage(:,D4.Epochs(4):D4.Epochs(4)+500)');
	D4.Current = activationleakcorrection(D4.Voltage,D4.Current,D4.Epochs);
	X = D4.Current(:,D4.Epochs(4):D4.Epochs(4)+500)';
	[M,I] = max(abs(X));
	sig = sign(X(I+[0:length(I)-1]*501));
	FT = fitGVcurve(V,M.*sig/max(M(:)));
	X = X(:,find(V<50));
	mX = max(abs(X(:)));
plot(X(:,1:2:end),'LineWidth',0.5,'color',clrs(5,:));
xlim([1,500]+25);
ylim([-1.1,0.2]*mX);
h=title('DIV-CN','FontSize',7,'FontWeight','normal'); yl = get(gca,'ylim');
h.Position(2) =yl(2)-0.12*range(yl);
line([350,450],[-0.9 -0.9]*mX,'LineWidth',1,'Color','k')
text(350,-mX,'1 ms','FontSize',6);
fr = 0.5e3/mX;
line([350,350],[-0.9 -0.9+fr]*mX,'LineWidth',1,'Color','k')
text(300,-0.95*mX,['0.5 nA'],'FontSize',6,'Rotation',90);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% PANEL B %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setPanLab(0.1,fig.Position(4)+1.8-4.1-pt2cm*8/2,'b');
axes('Units','centimeters','Position',[1.75,fig.Position(4)+1.9-8,6,4],'color','w',...
	'box','off','tickdir','out','FontSize',7,'LineWidth',1); hold on;
xlim([-110,35]); 	xlabel('Test Pulse Potential (mV)')
ylim([0,1.1]); 		ylabel('Peak Conductance (Norm.)')


load(fullfile('mH1','activation_analyzed.mat')); mH1 = T;
load(fullfile('mH1-D1','activation_analyzed.mat')); mH1_D1 = T;
load(fullfile('mH1-D2','activation_analyzed.mat')); mH1_D2 = T;
load(fullfile('mH1-D3','activation_analyzed.mat')); mH1_D3 = T;
load(fullfile('mH1-D4','activation_analyzed.mat')); mH1_D4 = T;

A_V = cat(2,mH1.V_activation{:})';
G = cat(2,mH1.G_activation{:})';
t = linspace(min(V(:)),max(V(:)),1e3)';
eb(1) = errorbar(mean(A_V),mean(G),stderror(G),'squarek', ...
	'Color',clrs(1,:),'MarkerFaceColor',clrs(1,:),'MarkerSize',5);
FT = fitboltzman(V(V<35),mean(G(:,V<35)));
plot(t,FT(t),'Color',clrs(1,:));

A_V = cat(2,mH1_D1.V_activation{:})';
G = cat(2,mH1_D1.G_activation{:})';
t = linspace(min(V(:)),max(V(:)),1e3)';
eb(2) = errorbar(mean(A_V),mean(G),stderror(G),'squarek', ...
	'Color',clrs(2,:),'MarkerFaceColor',clrs(2,:),'MarkerSize',5);
FT = fitboltzman(V(V<35),mean(G(:,V<35)));
plot(t,FT(t),'Color',clrs(2,:));

A_V = cat(2,mH1_D2.V_activation{:})';
G = cat(2,mH1_D2.G_activation{:})';
t = linspace(min(V(:)),max(V(:)),1e3)';
eb(3) = errorbar(mean(A_V),mean(G),stderror(G),'squarek', ...
	'Color',clrs(3,:),'MarkerFaceColor',clrs(3,:),'MarkerSize',5);
FT = fitboltzman(V(V<35),mean(G(:,V<35)));
plot(t,FT(t),'Color',clrs(3,:));

A_V = cat(2,mH1_D3.V_activation{:})';
G = cat(2,mH1_D3.G_activation{:})';
t = linspace(min(V(:)),max(V(:)),1e3)';
eb(4) = errorbar(mean(A_V),mean(G),stderror(G),'squarek', ...
	'Color',clrs(4,:),'MarkerFaceColor',clrs(4,:),'MarkerSize',5);
FT = fitboltzman(V(V<35),mean(G(:,V<35)));
plot(t,FT(t),'Color',clrs(4,:));

A_V = cat(2,mH1_D4.V_activation{:})';
G = cat(2,mH1_D4.G_activation{:})';
t = linspace(min(V(:)),max(V(:)),1e3)';
eb(5) = errorbar(mean(A_V),mean(G),stderror(G),'squarek', ...
	'Color',clrs(5,:),'MarkerFaceColor',clrs(5,:),'MarkerSize',5);
FT = fitboltzman(V(V<35),mean(G(:,V<35)));
plot(t,FT(t),'Color',clrs(5,:));

set(gca,'xtick',[-100:25:25])
L = legend(eb,{'Nav1.5','DI-CN','DII-CN','DIII-CN','DIV-CN'},'box','off','FontSize',7, ...
	'TextColor','k','Units','centimeters');
L.Position=[1.8,3,1.5,1.5];
L.ItemTokenSize = [10,7];

axes('Units','centimeters','Position',[5.8,0.9,2.5,1.8],'color','none');
set(get(gca,'xaxis'),'visible','off')
set(get(gca,'yaxis'),'visible','off')
