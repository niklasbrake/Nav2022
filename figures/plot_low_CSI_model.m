function plotfigure5

	basePath = fileparts(fileparts(mfilename('fullpath')));
	addpath(genpath(basePath));
	
	fig = figureNB;
	% fig.Position(3)= 8.5;
	fig.Position(3)= 8.9;
	fig.Position(4) = 9.5;
	figh = fig.Position(4);


	ax = axes('units','centimeters');
	ax.Position = [1.5,figh-3.5,6,0.28];
	ax.Position(4) = ax.Position(3)*range([0.5,3.2])/range([0.7,5.25]);
	ax.Units = 'normalized';
	buildmodeldiagram(false); set(gca,'FontSize',7)
	% annotation('textbox',[0.1,0.96,0.05,0.03], 'String',{'a'}, 'LineStyle','none', 'FontWeight','bold', 'FontSize',8,'Margin',0.1,'VerticalAlignment','bottom');
	labelpanel(0.1,0.95,'a');

	pars15 = getNav15params;

	simulateDIICN(pars15);
	simulateDIVCN(pars15);

function simulateDIICN(pars15)
	fig = gcf;
	figh = fig.Position(4);

	clrs = getColours;
	
	% Nav1.5 model
	ax = axes('Units','centimeters');
	ax.Position = [-0.2+0.125+0.5,figh-6,2.25,1.75];
		plotComparison(pars15,@nav15_NB,clrs(1,:),'square'); 
		plotComparison(pars15,@nav15minusC1_NB,clrs(3,:),'v'); 
		local_format;

	% Low CSI Model
	pars15 = lowCSIparams(pars15,@nav15_NB);
	ax = axes('Units','centimeters');
	ax.Position = [-0.2+0.125+6,figh-6,2.25,1.75];
		plotComparison(pars15,@nav15_NB,clrs(1,:),'square'); 
		plotComparison(pars15,@nav15minusC1_NB,clrs(3,:),'v'); 
		local_format;

	L=labelpanel(0.04,0.555,'b');
		annotation('textbox',[0.04+0.05,0.57,0.25,0.03], 'String',{'Nav1.5 model'}, 'LineStyle','none', 'FontWeight','normal', 'FontSize',7,'Margin',0);
	L=labelpanel(0.35,0.555,'c');
		annotation('textbox',[0.35+0.05,0.57,0.25,0.03], 'String',{'Nav1.4 model'}, 'LineStyle','none', 'FontWeight','normal', 'FontSize',7,'Margin',0);
	L=labelpanel(0.665,0.555,'d');
		annotation('textbox',[0.67+0.05,0.57,0.25,0.03], 'String',{'Low CSI model'}, 'LineStyle','none', 'FontWeight','normal', 'FontSize',7,'Margin',0);

function simulateDIVCN(pars15)
	fig = gcf;
	figh = fig.Position(4);

	clrs = getColours;

	% Nav1.5 model
	ax = axes('Units','centimeters');
	ax.Position = [-0.2+0.125+0.5,figh-9,2.25,1.75];
		plotComparison(pars15,@nav15_NB,clrs(1,:),'square'); 
		pars15_DIVCN = getDIVCNparams(pars15,@nav15_NB);
		plotComparison(pars15_DIVCN,@nav15_NB,clrs(5,:),'v'); 
		local_format

	% Low CSI Model
	pars15_lowCSI = lowCSIparams(pars15,@nav15_NB);
	ax = axes('Units','centimeters');
	ax.Position = [-0.2+0.125+3.25,figh-9,2.25,1.75];
		plotComparison(pars15_lowCSI,@nav15_NB,clrs(1,:),'square'); 
		pars15_lowCSI_DIVCN = getDIVCNparams(pars15_lowCSI,@nav15_NB);
		plotComparison(pars15_lowCSI_DIVCN,@nav15_NB,clrs(5,:),'v'); 
		local_format


	CSI = computemodelCSI(pars15,@nav15_NB,0)
	CSI = computemodelCSI(pars15_DIVCN,@nav15_NB,0)
	ax = axes('Units','centimeters');
	ax.Position = [-0.2+0.125+6,figh-9,2.25,1.75];
		plotComparison(pars15_lowCSI,@nav15_NB,clrs(1,:),'square'); 
		pars15_lowCSI_DIVCN = getDIVCNparams(pars15_lowCSI,@nav15_NB);
		plotComparison(pars15_lowCSI_DIVCN,@nav15_NB,clrs(5,:),'v'); 
		local_format

	L=labelpanel(0.04,0.24,'f');
		annotation('textbox',[0.04+0.05,0.255,0.25,0.03], 'String',{'Nav1.5 model'}, 'LineStyle','none', 'FontWeight','normal', 'FontSize',7,'Margin',0);
	L=labelpanel(0.35,0.24,'g');
		annotation('textbox',[0.35+0.05,0.255,0.25,0.03], 'String',{'Nav1.4 model'}, 'LineStyle','none', 'FontWeight','normal', 'FontSize',7,'Margin',0);
	L=labelpanel(0.665,0.24,'h');
		annotation('textbox',[0.67+0.05,0.255,0.25,0.03], 'String',{'Nav1.5 (low CSI)'}, 'LineStyle','none', 'FontWeight','normal', 'FontSize',7,'Margin',0);


function plotComparison(params,modelfunction,clr,markerType)
	[Q,OpenPositions] = modelfunction(params);
	output = simulateprotocols(Q,OpenPositions);
	plot(output.activation.V,output.activation.G,'Marker',markerType,'Color',clr,'MarkerSize',5,'LineWidth',1.5); drawnow; hold on;
	h = plot(output.activation.V,output.activation.G,'Marker',markerType,'Color',clr,'MarkerSize',5,'LineWidth',1.5); drawnow; 
	hold on;
	set(h.NodeChildren(1),'LineWidth',0.75);
	h1 = plot(output.inactivation.V,output.inactivation.I,'Marker',markerType','Color',clr,'MarkerSize',5,'LineWidth',1.5); drawnow; 
	set(h1.NodeChildren(1),'LineWidth',0.75);

function paramsCSI = lowCSIparams(defaultParams,modelfunction)
	[~,~,P] = modelfunction(defaultParams);
	paramsCSI = defaultParams;
	idx = find(strcmp(fieldnames(P),'alpha_4k'));
	paramsCSI(idx) = paramsCSI(idx)/20;
	idx = find(strcmp(fieldnames(P),'beta_4k'));
	paramsCSI(idx) = 20*paramsCSI(idx);
	idx = find(strcmp(fieldnames(P),'alpha_4ok'));
	paramsCSI(idx) = paramsCSI(idx)*20;
	idx = find(strcmp(fieldnames(P),'beta_4ok'));
	paramsCSI(idx) = 0.05*paramsCSI(idx);

function paramsDIVCN = getDIVCNparams(defaultParams,modelfunction)
	[~,~,P] = modelfunction(defaultParams);
	paramsDIVCN = defaultParams;
	idx = find(strcmp(fieldnames(P),'alpha_4k'));
	paramsDIVCN(idx) = 20*paramsDIVCN(idx);
	idx = find(strcmp(fieldnames(P),'alpha_4ok'));
	paramsDIVCN(idx) = 20*paramsDIVCN(idx);
	idx = find(strcmp(fieldnames(P),'beta_4ok'));
	paramsDIVCN(idx) = 0.05*paramsDIVCN(idx);
	idx = find(strcmp(fieldnames(P),'beta_4k'));
	paramsDIVCN(idx) = 0.05*paramsDIVCN(idx);

function local_format
	gcaformat;
	xlim([-160,60]); ylim([0,1]); ylabel('');
	set(get(gca,'yaxis'),'visible','off');
	ch = get(gca,'Children');
	for i = 1:length(ch)
		ch(i).MarkerSize=3;
		ch(i).LineWidth=0.75;
	end
	set(gca,'xtick',[-100,0]);
	set(gca,'xticklabel',{'-100','0 mV'});