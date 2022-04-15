function fig = main

	basePath = fileparts(fileparts(mfilename('fullpath')));
	addpath(genpath(basePath));
	
	fig = figureNB(8.5,9.5);

	R = fig.Position(4)/fig.Position(3);
    xr = 5.25-0.7;
    yr = 3.2-0.5;
    h = 0.37;
    w = xr/yr*h*R;
	axes('Position',[0.525-w/2,0.63,w,h]); 
	buildmodeldiagram(true);
	gcaformat;


	pars15 = getNav15params(1);
	simulateDIICN(pars15);
	simulateDIVCN(pars15);

	
	labelpanel(0.1,0.95,'a');
	labelpanel(0.05,0.59,'b');
	labelpanel(0.36,0.59,'d');
	labelpanel(0.67,0.59,'f');
	labelpanel(0.05,0.28,'c');
	labelpanel(0.36,0.28,'e');
	labelpanel(0.67,0.28,'g');

function simulateDIICN(pars15)

	clrs = getColours;
	
	% Nav1.5 model
	ax = axes('Position',[0.7,0.42,0.22,0.18]);
		plotComparison(pars15,@nav15_NB,[1,1,1]*0.3+0.7*clrs(1,:),'square'); 
		plotComparison(pars15,@nav15minusC1_NB,clrs(3,:),'v'); 
		local_format;

	V = linspace(-150,60,100);
	for i = 1:length(V)
		% [CSI_WT(i),DIV_WT(i),t_inact_WT(:,i),t_open_WT(:,i)] = computemodelCSI(pars15,@nav15_NB,V(i));
		[t_inact_DII(:,i),t_open_DII(:,i)] = computemodelCSI(pars15,@nav15minusC1_NB,V(i));
	end

	ax = axes('Position',[0.7,0.1,0.22,0.18]);
		plot(V,median(1e3*t_inact_DII,1),'-','color',clrs(3,:),'LineWidth',1); hold on;
		plot(V,median(1e3*t_open_DII,1),'--','color',clrs(3,:),'LineWidth',1);
		local_format
		ylim([0.01,100]); set(gca,'yscale','log'); set(get(gca,'yaxis'),'visible','on');
		yax = get(gca,'yaxis'); yax.MinorTickValues = [0.1,10];



function simulateDIVCN(pars15)
	fig = gcf;
	figh = fig.Position(4);

	clrs = getColours;

	% Nav1.5 model
	ax = axes('Position',[0.1,0.42,0.22,0.18]);
		plotComparison(pars15,@nav15_NB,clrs(1,:),'square'); 
		local_format

	ax = axes('Position',[0.4,0.42,0.22,0.18]);
		plotComparison(pars15,@nav15_NB,[1,1,1]*0.3+0.7*clrs(1,:),'square'); 
		pars15_DIVCN = lowCSIparams(pars15,@nav15_NB);
		plotComparison(pars15_DIVCN,@nav15_NB,clrs(5,:),'v'); 
		local_format

	V = linspace(-150,60,100);
	for i = 1:length(V)
		[t_inact_WT(:,i),t_open_WT(:,i)] = computemodelCSI(pars15,@nav15_NB,V(i));
		[t_inact_DIV(:,i),t_open_DIV(:,i)] = computemodelCSI(pars15_DIVCN,@nav15_NB,V(i));
	end

	ax = axes('Position',[0.1,0.1,0.22,0.18]);
		plot(V,median(1e3*t_inact_WT,1),'-','color',clrs(1,:),'LineWidth',1); hold on;
		plot(V,median(1e3*t_open_WT,1),'--','color',clrs(1,:),'LineWidth',1);
		local_format
		ylim([0.01,100]); set(gca,'yscale','log'); set(get(gca,'yaxis'),'visible','on');
		yax = get(gca,'yaxis'); yax.MinorTickValues = [0.1,10];
		yl = ylabel('Latency (ms)')
		yl.Position = [-210,1,-1];
		L = legend('Inactivation','Pore opening');
		L.Box = 'off';
		L.ItemTokenSize = [7.5,5];
		L.Position = [0.095,0.095,0.21,0.07];
		L.FontSize = 6;

	ax = axes('Position',[0.4,0.1,0.22,0.18]);
		plot(V,median(1e3*t_inact_DIV,1),'-','color',clrs(5,:),'LineWidth',1); hold on;
		plot(V,median(1e3*t_open_DIV,1),'--','color',clrs(5,:),'LineWidth',1);
		local_format
		ylim([0.01,100]); set(gca,'yscale','log'); set(get(gca,'yaxis'),'visible','on');
		yax = get(gca,'yaxis'); yax.MinorTickValues = [0.1,10];

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
	xlim([-150,60]); ylim([0,1]); ylabel('');
	set(get(gca,'yaxis'),'visible','off');
	ch = get(gca,'Children');
	for i = 1:length(ch)
		ch(i).MarkerSize=3;
		ch(i).LineWidth=0.75;
	end
	set(gca,'xtick',[-120:60:60]);
	xlabel('Voltage (mV)');
	% set(gca,'xticklabel',{'-100','0 mV'});