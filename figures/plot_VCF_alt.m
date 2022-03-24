function plotfigure4

warning('off','curvefit:prepareFittingData:removingNaNAndInf')
basePath = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(basePath));

load(fullfile('VCF','VCF_SummaryData.mat'));
F(:,3) = F(:,3)/mean(F(vF>-50,3));
D(1) = load(fullfile('VCF','D1_20180510c2.mat'));
baseline(1) = 1.8849;
D(2) = load(fullfile('VCF','D2_20180512c1.mat'));
baseline(2) = 1.8307;
D(3) = load(fullfile('VCF','D3_20180518c4.mat'));
baseline(3) = 1.8307;
D(4) = load(fullfile('VCF','D4_20180514c5.mat'));
baseline(4) = 2.0698;

WT = load('ephys_SummaryData.mat');

fig = figure('Units','Centimeters','Color','w');
fig.Position(3) = 8.5;
fig.Position(4) = 6.5;
fig.Position(2) = fig.Position(2)-4;
figh = fig.Position(4);

C1 = [0,1,0];
CM = [linspace(0,C1(1),5)' linspace(0,C1(2),5)' linspace(0,C1(3),5)'];

axs(1) = axes('units','Centimeters');
axs(1).Position = [0.1+0.3,0.15+figh-2,1.75,1.5]; axs(1).YLim = [-0.025 0.01];
axs(2) = axes('units','Centimeters');
axs(2).Position = [0.1+0.6+1.75,0.15+figh-2,1.75,1.5]; axs(2).YLim = [-0.03 0.01];
axs(3) = axes('units','Centimeters');
axs(3).Position = [0.1+0.9+3.5,0.15+figh-2,1.75,1.5]; axs(3).YLim = [-0.015 0.02];
axs(4) = axes('units','Centimeters');
axs(4).Position = [0.1+1.2+5.25,0.15+figh-2,1.75,1.5]; axs(4).YLim = [-0.035 0.01];

T = 1.7e4-1.2e4:1.7e4+1.2e4;
tLine = 0.8e4;
for i = 1:4
	axes(axs(i)); hold on;
	yl = axs(i).YLim;
	for j = 1:5
		plot(downsample(T,50),downsample(D(i).VCF(T,j),50),'LineWidth',0.75,'Color',CM(j,:));
	end
	line([T(1) T(end)],[0,0],'Color','k','LineWidth',1,'LineStyle','--');
	xlim([T(1) T(end)]);
	line([tLine tLine+0.5e4],[yl(1),yl(1)],'Color','k','LineWidth',1);
			text(tLine+0.25e4,yl(1), '50 ms', 'FontSize',6,'HorizontalAlignment','center',...
				'VerticalAlignment','top');
	if(sum(i==[1,3]))
		line([tLine tLine],[yl(1),yl(1)+0.003*baseline(i)],'Color','k','LineWidth',1);
		text(tLine-5e2,yl(1)+(0.003*baseline(i))/2, '0.3%', 'FontSize',6,'HorizontalAlignment','right');
	else
		line([tLine tLine],[yl(1),yl(1)+0.004*baseline(i)],'Color','k','LineWidth',1);
		text(tLine-5e2,yl(1)+(0.004*baseline(i))/2, '0.4%', 'FontSize',6,'HorizontalAlignment','right');
		if(i==4)
			
		end
	end
			
	set(get(gca,'xaxis'),'visible','off');
	set(get(gca,'yaxis'),'visible','off');
end

A=labelpanel(0.04,0.9,'DI*'); A.FontWeight = 'normal'; A.FontSize = 7;
A=labelpanel(0.28,0.9,'DII*'); A.FontWeight = 'normal'; A.FontSize = 7;
A=labelpanel(0.52,0.9,'DIII*'); A.FontWeight = 'normal'; A.FontSize = 7;
A=labelpanel(0.77,0.9,'DIV*'); A.FontWeight = 'normal'; A.FontSize = 7;

clrs = lines(6);
clrs=clrs([2,3,4,6],:);
mrks = {'^','v','d','o'};

iD4 = WT.minusD4.inactivation;
[V,iV1,iV2] = intersect(vF,iD4(:,1));
FF = F(iV1,3);
FF(FF>1.05) = nan;
SSI = iD4(iV2,2);

ax(6) = axes('units','Centimeters','fontsize',7,'LineWidth',1,'box','off','tickdir','out'); hold on;
ax(6).Position = [0.95,figh-5.65,3.8,3];
for i = 1:4
	FB = FitBoltzmanCurve2(vF,F(:,i),-50,-5);
	EB(i) = errorbar(vF,F(:,i),sF(:,i),'LineWidth',0.25,'LineStyle','none','Marker',mrks{i},'MarkerSize',4,'color',clrs(i,:)); hold on;
	EB(i).MarkerFaceColor = EB(i).Color;
	plot(vF(1):vF(end),FB(vF(1):vF(end)),'Color',EB(i).Color);
	if(i==3)
		FB = FitBoltzmanCurve2(vF,F(:,4),-50,-5);
		FB2 = @(V) FB.v50/FB.k.*exp((FB.v50-V)/FB.k)./(1+exp((FB.v50-V)/FB.k)).^2;
		FB = FitBoltzmanCurve2(vF,F(:,3),-50,-5);
		bmp = FB2(vF(1):vF(end));
		bmp = bmp(:)/max(bmp(:))*(max(F(:,3)-1));
		plot(vF(1):vF(end),FB(vF(1):vF(end))+bmp,'-k','LineWidth',0.5);
	end
	end
xlim([-200 20]);
ylim([-0.1,1.2]);
xlabel('Voltage (mV)')
ylabel('\DeltaF')


plot(WT.Nav15e.activation(:,1),WT.Nav15e.activation(:,2),'--','color',[0.5,0.5,0.5])
plot(WT.Nav15e.inactivation(:,1),WT.Nav15e.inactivation(:,2),'--','color',[0.5,0.5,0.5])

EB = [];
ax = axes('Position',[0,0,0,0]);
for i =1:2
	EB(i) = errorbar(nan,nan,'Marker',mrks{i},'MarkerSize',4,'color',clrs(i,:),'MarkerFaceColor',clrs(i,:)); hold on;
end
L = legend(EB,{'DI*','DII*'},'FontSize',7);
L.ItemTokenSize = [10,5];
L.Box = 'off';
L.Position = [0.66 0.57 0.1760 0.0649];
ax.Visible = 'off';

ax = axes('Position',[0,0,0,0]);
for i =3:4
	EB(i-2) = errorbar(nan,nan,'Marker',mrks{i},'MarkerSize',4,'color',clrs(i,:),'MarkerFaceColor',clrs(i,:)); hold on;
end
L2 = legend(EB,{'DIII*','DIV*'},'FontSize',7);
L2.ItemTokenSize = [10,5];
L2.Box = 'off';
L2.Position = [0.8 0.57 0.1760 0.0649];
ax.Visible = 'off';


ax(5) = axes('units','Centimeters','fontsize',7,'LineWidth',1,'box','off','tickdir','out'); hold on;
ax(5).Position = [5.75,figh-5.65,2.5,2.5];
	h(1) = errorbar(SSI,F(iV1,1),sF(iV1,1),sF(iV1,1),iD4(iV2,3),iD4(iV2,3),mrks{1},'Color',clrs(1,:),'LineWidth',0.25,'MarkerSize',4); h(1).MarkerFaceColor = h(1).Color;
	hold on;
	h(2) = errorbar(SSI,F(iV1,2),sF(iV1,2),sF(iV1,2),iD4(iV2,3),iD4(iV2,3),mrks{2},'Color',clrs(2,:),'LineWidth',0.25,'MarkerSize',4); h(2).MarkerFaceColor = h(2).Color;
	h(3) = errorbar(SSI,F(iV1,3),sF(iV1,3),sF(iV1,3),iD4(iV2,3),iD4(iV2,3),mrks{3},'Color',clrs(3,:),'LineWidth',0.25,'MarkerSize',4); h(3).MarkerFaceColor = h(3).Color;
	FT = fitlm(SSI,FF); hold on;
	plot(SSI,FT.predict(SSI),'--k','LineWidth',1);
	xlim([-0.05,1])
	ylim([-0.1,1.2])
	box off
	set(gca,'TickDir','out')
	xlabel('SSI (DIV-CN)')
	ylabel('\DeltaF')

	axis square;

A=labelpanel(0.,0.95,'a');
A=labelpanel(0.05,0.55,'b');
A=labelpanel(0.63,0.49,'c');