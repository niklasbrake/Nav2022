function fig = main

	basePath = fileparts(fileparts(mfilename('fullpath')));
	addpath(genpath(basePath));

	Params = getNav15params(2);
	[Q,OpenPositions,P] = schemeII(Params);
	modeloutput = simulateprotocols(Q,OpenPositions);

	WT.A = load(fullfile('Nav1.5e','20170418c2','activation.mat'));
	WT.I = load(fullfile('Nav1.5e','20170428c4','inactivation.mat'));
	WT.R = load(fullfile('Nav1.5e','20170418c2','recovery1ms.mat'));
	WT.R2 = load(fullfile('Nav1.5e','20170418c2','recovery10ms.mat'));

	fig = figureNB(8.5,8.5);

	axes('Position',[0.03,3/4,0.3,0.23]);
		V = mean(WT.A.Voltage(:,WT.A.Epochs(4):WT.A.Epochs(4)+500)');
		WT.A.Current = activationleakcorrection(WT.A.Voltage,WT.A.Current,WT.A.Epochs);
		X = WT.A.Current(:,WT.A.Epochs(4)+33:WT.A.Epochs(4)+500+33)';
		[M,I] = max(abs(X));
		sig = sign(X(I+[0:length(I)-1]*501));
		FT = fitGVcurve(V,M.*sig/max(M(:)));
		X = X(:,find(V<FT.ERev-5));
		plot(X/max(abs(X(:))),'k'); ylim([-1,0]); xlim([0,500]);
		set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');
		text(200,-0.55,'Data','fontsize',7,'color','k')

	axes('Position',[0.35,3/4,0.3,0.23]);
		V = mean(WT.I.Voltage(:,WT.I.Epochs(5)+30:WT.I.Epochs(5)+530)');
		WT.I.Current = inactivationleakcorrection(WT.I.Voltage,WT.I.Current,WT.I.Epochs);
		X = WT.I.Current(:,WT.I.Epochs(5)+30:WT.I.Epochs(5)+530)';
		[M,I] = max(abs(X));
		sig = sign(X(I+[0:length(I)-1]*501));
		FT = fitGVcurve(V,M.*sig/max(M(:)));
		X = X(:,find(V<FT.ERev));
		plot(X/max(abs(X(:))),'k'); ylim([-1,0]); xlim([0,500]);
		set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');

	axes('Position',[0.67,3/4,0.3,0.23]); hold on;
		X = WT.R.Current(:,WT.R.Epochs(5)-100:WT.R.Epochs(5)+100e2)';
		for i = 1:size(X,2)
			X(1:101+i*10*10+45,i) = nan;
		end
		pre = mean(WT.R.Current(:,WT.R.Epochs(4)+1:WT.R.Epochs(4)+500));
		mX = max(abs(pre));
		plot((1:500)-300,pre/mX,'k'); hold on;
		plot(X./mX,'k'); hold on;
		X = WT.R2.Current(:,WT.R.Epochs(5)-100:WT.R.Epochs(5)+100e2)';
		for i = 1:size(X,2)
			X(1:101+i*100*10+45,i) = nan;
		end
		xlim([-300,30e2]);
		ylim([-1,0]);
		set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');

	axes('Position',[0.03,0.48,0.3,0.23]);
		plot(modeloutput.activation.estimate,'Color','b','LineWidth',0.5); xlim([0,500]);
		text(200,-0.55,'Model','fontsize',7,'color','b')
		set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');
	
	axes('Position',[0.35,0.48,0.3,0.23]);
		plot(modeloutput.inactivation.estimate,'Color','b','LineWidth',0.5); xlim([0,500]);
		set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');
	
	axes('Position',[0.67,0.48,0.3,0.23]); 
		pre = modeloutput.recovery.pre;
		mx = max(abs(pre(:)));
		plot(((1:300)-300)*1e-2,-pre(1:300)/mx,'color','b'); hold on;
		for idx = 1:25
			plot(linspace(idx,idx+5,500),-modeloutput.recovery.estimate(:,idx),'color','b','LineWidth',0.5);
		end
		xlim([-3,30]);
		ylim([-1,0]);
		set(get(gca,'xaxis'),'visible','off'); set(get(gca,'yaxis'),'visible','off');


	axes('Position',[0.065,0.1,0.4,0.3]);
		load('Nav1.5e\activation_analyzed.mat')
		V = cat(2,T.V_activation{:});
		G = cat(2,T.G_activation{:});
		plot(V,G,'.k','MarkerSize',2); hold on;
		h = plot(modeloutput.activation.V,modeloutput.activation.G,'Color','b','LineWidth',2); drawnow; 
		xlim([-130 30]); ylim([0,1]);

		load('Nav1.5e\inactivation_analyzed.mat')
		V = cat(2,T.V_SSI{:});
		I = cat(2,T.Ipost_SSI{:});
		G=1-I.*T.Imax(:)';
		plot(V,G,'.k','MarkerSize',2); hold on;
		h1 = plot(modeloutput.inactivation.V,modeloutput.inactivation.I,'Color','b','LineWidth',2); drawnow; 
		xlim([-130 30]); ylim([0,1]);
		xlabel('Voltage(mV)'); 
		gcaformat;


	axes('Position',[0.57,0.1,0.4,0.3]);
		load('Nav1.5e\Recovery_Curves.mat')
		idcs = [1,2,3,4,7,10,15,20,26:size(a,2)];
		plot(a(:,idcs),b(:,idcs),'.k','MarkerSize',2)
		set(gca,'xscale','log')
		hold on;
		h1 = plot(modeloutput.recovery.t,modeloutput.recovery.I,'Color','b','LineWidth',2); drawnow;
		set(gca,'XScale','log');xlim([1 150]);ylim([0,1]);
		ylim([0,1]);
		xl = xlabel('Inter-pulse interval (ms)'); 
		xl.Position = [12.2,-0.22,-1];
		gcaformat;
		set(gca,'xtick',[1,10,100]);


	
	labelpanel(0.0,0.95,'a');
	labelpanel(0.0,0.68,'b');
	labelpanel(0.0,0.4,'c');
	labelpanel(0.52,0.4,'d');